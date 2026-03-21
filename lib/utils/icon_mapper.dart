import 'package:flutter/material.dart';

/// Maps Material icon names (as strings) to IconData
/// Supports all common Material Icons for ehDP devices
class IconMapper {
  static final Map<String, IconData> _iconMap = {
    // Common device icons
    'camera': Icons.camera,
    'camera_alt': Icons.camera_alt,
    'speaker': Icons.speaker,
    'radio': Icons.radio,
    'tv': Icons.tv,
    'music_note': Icons.music_note,
    'headphones': Icons.headphones,
    'mic': Icons.mic,
    'microphone': Icons.mic,

    // Time & clocks
    'access_time': Icons.access_time,
    'alarm': Icons.alarm,
    'schedule': Icons.schedule,
    'watch': Icons.watch,
    'timer': Icons.timer,

    // Lighting
    'lightbulb': Icons.lightbulb,
    'lightbulb_outline': Icons.lightbulb_outline,
    'light': Icons.light,
    'wb_incandescent': Icons.wb_incandescent,
    'wb_sunny': Icons.wb_sunny,
    'brightness_high': Icons.brightness_high,
    'brightness_medium': Icons.brightness_medium,
    'brightness_low': Icons.brightness_low,

    // Displays & screens
    'monitor': Icons.monitor,
    'desktop_windows': Icons.desktop_windows,
    'tablet': Icons.tablet,
    'phone_android': Icons.phone_android,
    'phonelink': Icons.phonelink,
    'article': Icons.article,

    // Sensors
    'sensors': Icons.sensors,
    'thermostat': Icons.thermostat,
    'device_thermostat': Icons.device_thermostat,
    'water_drop': Icons.water_drop,
    'air': Icons.air,
    'co2': Icons.co2,
    'speed': Icons.speed,

    // Power & control
    'power': Icons.power,
    'power_settings_new': Icons.power_settings_new,
    'toggle_on': Icons.toggle_on,
    'toggle_off': Icons.toggle_off,
    'outlet': Icons.outlet,
    'electrical_services': Icons.electrical_services,

    // Smart home
    'home': Icons.home,
    'garage': Icons.garage,
    'lock': Icons.lock,
    'lock_open': Icons.lock_open,

    // Weather
    'wb_cloudy': Icons.wb_cloudy,
    'nights_stay': Icons.nights_stay,
    'thunderstorm': Icons.thunderstorm,

    // Connectivity
    'wifi': Icons.wifi,
    'bluetooth': Icons.bluetooth,
    'router': Icons.router,
    'cell_tower': Icons.cell_tower,

    // Generic devices
    'device_unknown': Icons.device_unknown,
    'devices': Icons.devices,
    'developer_board': Icons.developer_board,
    'memory': Icons.memory,
    'settings_remote': Icons.settings_remote,
    'remote_control': Icons.settings_remote,

    // Media
    'play_arrow': Icons.play_arrow,
    'pause': Icons.pause,
    'stop': Icons.stop,
    'skip_next': Icons.skip_next,
    'skip_previous': Icons.skip_previous,
    'volume_up': Icons.volume_up,
    'volume_down': Icons.volume_down,
    'volume_off': Icons.volume_off,

    // Display types
    'videogame_asset': Icons.videogame_asset,
    'image': Icons.image,
    'photo': Icons.photo,
    'perm_media': Icons.perm_media,

    // Tools & settings
    'settings': Icons.settings,
    'build': Icons.build,
    'construction': Icons.construction,
    'handyman': Icons.handyman,
  };

  /// Returns the IconData for the given icon name, or null if not found
  static IconData? getIcon(String? iconName) {
    if (iconName == null || iconName.isEmpty) {
      return null;
    }
    return _iconMap[iconName.toLowerCase()];
  }

  /// Returns the IconData for the given icon name, or a default icon if not found
  static IconData getIconOrDefault(String? iconName, IconData defaultIcon) {
    return getIcon(iconName) ?? defaultIcon;
  }
}
