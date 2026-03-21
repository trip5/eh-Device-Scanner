import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:udp/udp.dart';

import '../models/device.dart';

/// Service for discovering ehDP-compatible devices on the local network
class DiscoveryService {
  static const int discoveryPort = 11867;
  static const String discoveryPayload = 'EHDP_DISCOVER';
  static const Duration discoveryTimeout = Duration(seconds: 3);

  final Logger _logger = Logger();
  final Map<String, Device> _discoveredDevices = {};

  /// Discovers devices on the local network
  ///
  /// Sends a UDP broadcast packet and collects responses for [timeout] duration.
  /// Returns a list of discovered devices, deduplicated by IP address.
  Future<List<Device>> discoverDevices({
    Duration timeout = discoveryTimeout,
  }) async {
    _discoveredDevices.clear();
    UDP? sender;
    UDP? receiver;

    try {
      // Create receiver first to ensure we don't miss any responses
      receiver = await UDP.bind(Endpoint.any(port: Port(discoveryPort)));
      _logger.i('Receiver bound to port $discoveryPort');

      // Set up listener for responses
      final responseSubscription = receiver.asStream().listen((datagram) {
        if (datagram != null) {
          _handleResponse(datagram);
        }
      });

      // Send broadcast discovery request
      sender = await UDP.bind(Endpoint.broadcast(port: Port(discoveryPort)));
      final broadcastEndpoint = Endpoint.broadcast(port: Port(discoveryPort));

      await sender.send(utf8.encode(discoveryPayload), broadcastEndpoint);
      _logger.i(
        'Broadcast sent to ${broadcastEndpoint.address}:${broadcastEndpoint.port}',
      );

      // Also try sending to all local network interfaces
      await _sendToLocalNetworks(sender);

      // Wait for responses
      await Future.delayed(timeout);

      // Clean up
      await responseSubscription.cancel();
      sender.close();
      receiver.close();

      _logger.i(
        'Discovery complete: found ${_discoveredDevices.length} devices',
      );
      return _discoveredDevices.values.toList();
    } catch (e, stackTrace) {
      _logger.e('Discovery error', error: e, stackTrace: stackTrace);
      sender?.close();
      receiver?.close();
      rethrow;
    }
  }

  /// Sends discovery packets to all local network broadcast addresses
  Future<void> _sendToLocalNetworks(UDP sender) async {
    try {
      final interfaces = await NetworkInterface.list();
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            // Calculate broadcast address for this subnet
            final broadcastAddr = _calculateBroadcastAddress(addr);
            if (broadcastAddr != null) {
              try {
                await sender.send(
                  utf8.encode(discoveryPayload),
                  Endpoint.unicast(
                    InternetAddress(broadcastAddr),
                    port: Port(discoveryPort),
                  ),
                );
                _logger.d('Sent to $broadcastAddr');
              } catch (e) {
                _logger.w('Failed to send to $broadcastAddr: $e');
              }
            }
          }
        }
      }
    } catch (e) {
      _logger.w('Failed to enumerate network interfaces: $e');
    }
  }

  /// Calculates the broadcast address for a given IP address
  String? _calculateBroadcastAddress(InternetAddress address) {
    try {
      final parts = address.address.split('.');
      if (parts.length != 4) return null;

      // Assume /24 subnet (255.255.255.0)
      // For most home networks, this is correct
      return '${parts[0]}.${parts[1]}.${parts[2]}.255';
    } catch (e) {
      _logger.w('Failed to calculate broadcast address: $e');
      return null;
    }
  }

  /// Handles a UDP response from a device
  void _handleResponse(Datagram datagram) {
    try {
      final data = utf8.decode(datagram.data);
      _logger.d('Received response from ${datagram.address}: $data');

      // Parse JSON
      final json = jsonDecode(data) as Map<String, dynamic>;

      // Validate proto field
      if (!json.containsKey('proto') || json['proto'] == null) {
        _logger.w('Response missing proto field');
        return;
      }

      if (!json['proto'].toString().startsWith('ehdp')) {
        _logger.w('Invalid proto field: ${json['proto']}');
        return;
      }

      // Validate required field (ip)
      if (!json.containsKey('ip') || json['ip'] == null) {
        _logger.w('Response missing required field (ip)');
        return;
      }

      // Validate at least one name field exists
      if (json['project'] == null &&
          json['firmware'] == null &&
          json['name'] == null) {
        _logger.w('Response missing name fields (project, firmware, name)');
        return;
      }

      // Create Device object
      final device = Device.fromJson(json);

      // Deduplicate by IP
      if (_discoveredDevices.containsKey(device.ip)) {
        _logger.d(
          'Device ${device.ip} already discovered (${device.displayName})',
        );
      } else {
        _discoveredDevices[device.ip] = device;
        _logger.i('Discovered device: ${device.displayName} (${device.ip})');
      }
    } on FormatException catch (e) {
      _logger.w('Invalid JSON response: $e');
    } catch (e) {
      _logger.w('Error handling response: $e');
    }
  }

  /// Clears the list of discovered devices
  void clear() {
    _discoveredDevices.clear();
  }
}
