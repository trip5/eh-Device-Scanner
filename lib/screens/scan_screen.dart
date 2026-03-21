import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/device.dart';
import '../providers/discovery_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/device_list_item.dart';

/// Main screen for scanning and displaying discovered devices
class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoveryState = ref.watch(discoveryProvider);
    final themeMode = ref.watch(themeProvider);

    // Determine the actual brightness being used
    final brightness = themeMode == ThemeMode.system
        ? MediaQuery.of(context).platformBrightness
        : (themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light);

    return Scaffold(
      appBar: AppBar(
        title: const Text('eh Device Scanner'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: Icon(
              brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme(brightness);
            },
          ),
        ],
      ),
      body: _buildBody(context, ref, discoveryState),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: discoveryState.scanState == ScanState.scanning
            ? null
            : () {
                ref.read(discoveryProvider.notifier).startScan();
              },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        icon: discoveryState.scanState == ScanState.scanning
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.search),
        label: Text(
          discoveryState.scanState == ScanState.scanning
              ? 'Scanning...'
              : 'Scan for Devices',
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, DiscoveryState state) {
    // Error state
    if (state.scanState == ScanState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Discovery Failed',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                state.errorMessage ?? 'Unknown error',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(discoveryProvider.notifier).clearError();
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
    }

    // Empty state (no devices discovered)
    if (state.devices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.devices, size: 96, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              state.scanState == ScanState.scanning
                  ? 'Searching for devices...'
                  : 'No devices found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                state.scanState == ScanState.scanning
                    ? 'Please wait while we discover ehDP-compatible devices on your network.'
                    : 'Tap the button below to scan for ehDP-compatible devices on your local network.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    // Device list
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(discoveryProvider.notifier).startScan();
      },
      child: ListView.builder(
        itemCount: state.devices.length,
        itemBuilder: (context, index) {
          final device = state.devices[index];
          return DeviceListItem(
            device: device,
            onTap: () => _openDeviceUI(context, device),
          );
        },
      ),
    );
  }

  Future<void> _openDeviceUI(BuildContext context, Device device) async {
    if (!device.hasWebUI) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This device has no web UI'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    final url = device.webUIUrl;
    if (url == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not construct device URL'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    try {
      final uri = Uri.parse(url);

      // In newer Flutter/Android, canLaunchUrl can return false even if it might work
      // due to intent filters / package visibility on certain API levels.
      // We'll try to launch it directly with external application mode.
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open device UI: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
