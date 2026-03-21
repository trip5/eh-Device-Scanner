import 'package:flutter/material.dart';

import '../models/device.dart';

/// Widget displaying a single device in the list
class DeviceListItem extends StatelessWidget {
  final Device device;
  final VoidCallback? onTap;

  const DeviceListItem({super.key, required this.device, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = device.hasWebUI;
    final Color? dimmedColor = isEnabled
        ? null
        : Theme.of(context).disabledColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        leading: _buildDeviceIcon(dimmedColor),
        title: _buildTitle(context, dimmedColor),
        subtitle: _buildSubtitle(context, dimmedColor),
        onTap: onTap,
        enabled: isEnabled,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Color? dimmedColor) {
    // Priority for bolding: name > project > firmware
    final String? name = device.name?.isNotEmpty == true ? device.name : null;
    final String? project = device.project?.isNotEmpty == true
        ? device.project
        : null;
    final String? firmware = device.firmware?.isNotEmpty == true
        ? device.firmware
        : null;

    final List<Widget> items = [];

    if (name != null) {
      items.add(
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, color: dimmedColor),
        ),
      );
    }

    if (project != null) {
      items.add(
        Text(
          project,
          style: TextStyle(
            fontWeight: name == null ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
            color: dimmedColor,
          ),
        ),
      );
    }

    if (firmware != null) {
      items.add(
        Text(
          firmware,
          style: TextStyle(
            fontWeight: (name == null && project == null)
                ? FontWeight.bold
                : FontWeight.normal,
            fontSize: 13,
            color: dimmedColor ?? Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      );
    }

    if (items.isEmpty) {
      items.add(
        Text(
          'Unknown Device',
          style: TextStyle(fontWeight: FontWeight.bold, color: dimmedColor),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget _buildDeviceIcon(Color? dimmedColor) {
    // Use custom Material Symbols codepoint if specified, otherwise use generic device icon
    // Default: 0xe1b1 is "devices" icon in Material Symbols
    final IconData iconData = device.materialSymbol != null
        ? IconData(
            device.materialSymbol!,
            fontFamily: 'MaterialSymbolsOutlined',
            fontPackage: 'material_symbols_icons',
          )
        : const IconData(
            0xe1b1,
            fontFamily: 'MaterialSymbolsOutlined',
            fontPackage: 'material_symbols_icons',
          );

    return CircleAvatar(
      backgroundColor: dimmedColor != null
          ? Colors.grey.withAlpha(100)
          : const Color(0xFF003DA5), // Quebec Blue
      child: Icon(iconData, color: Colors.white),
    );
  }

  Widget _buildSubtitle(BuildContext context, Color? dimmedColor) {
    final String versionText = device.version != null
        ? 'Version: ${device.version}'
        : 'No version';
    final String hostDisplay = device.mdns != null && device.mdns!.isNotEmpty
        ? '${device.ip} • ${device.mdns}.local'
        : device.ip;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(versionText, style: TextStyle(color: dimmedColor)),
        Text(hostDisplay, style: TextStyle(color: dimmedColor)),
      ],
    );
  }
}
