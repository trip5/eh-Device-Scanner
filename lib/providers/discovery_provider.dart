import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../models/device.dart';
import '../services/discovery_service.dart';

/// Scan state enumeration
enum ScanState { idle, scanning, completed, error }

/// Discovery state model
class DiscoveryState {
  final List<Device> devices;
  final ScanState scanState;
  final String? errorMessage;

  const DiscoveryState({
    this.devices = const [],
    this.scanState = ScanState.idle,
    this.errorMessage,
  });

  DiscoveryState copyWith({
    List<Device>? devices,
    ScanState? scanState,
    String? errorMessage,
  }) {
    return DiscoveryState(
      devices: devices ?? this.devices,
      scanState: scanState ?? this.scanState,
      errorMessage: errorMessage,
    );
  }
}

/// Discovery state notifier
class DiscoveryNotifier extends StateNotifier<DiscoveryState> {
  final DiscoveryService _discoveryService;
  final Logger _logger = Logger();

  DiscoveryNotifier(this._discoveryService) : super(const DiscoveryState());

  /// Starts a device discovery scan
  Future<void> startScan() async {
    if (state.scanState == ScanState.scanning) {
      _logger.w('Scan already in progress');
      return;
    }

    _logger.i('Starting device discovery scan');
    state = state.copyWith(scanState: ScanState.scanning, errorMessage: null);

    try {
      final devices = await _discoveryService.discoverDevices();

      // Sort devices alphabetically by display name (case-insensitive)
      devices.sort(
        (a, b) =>
            a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()),
      );

      state = state.copyWith(devices: devices, scanState: ScanState.completed);

      _logger.i('Scan completed: found ${devices.length} devices');
    } catch (e, stackTrace) {
      _logger.e('Scan failed', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        scanState: ScanState.error,
        errorMessage: 'Discovery failed: ${e.toString()}',
      );
    }
  }

  /// Clears the discovered devices list
  void clearDevices() {
    _logger.d('Clearing devices');
    _discoveryService.clear();
    state = const DiscoveryState();
  }

  /// Resets error state
  void clearError() {
    if (state.scanState == ScanState.error) {
      state = state.copyWith(scanState: ScanState.idle, errorMessage: null);
    }
  }
}

/// Provider for the discovery service instance
final discoveryServiceProvider = Provider<DiscoveryService>((ref) {
  return DiscoveryService();
});

/// Provider for the discovery state notifier
final discoveryProvider =
    StateNotifierProvider<DiscoveryNotifier, DiscoveryState>((ref) {
      final service = ref.watch(discoveryServiceProvider);
      return DiscoveryNotifier(service);
    });
