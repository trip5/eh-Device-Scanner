import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';
part 'device.g.dart';

/// Custom JSON converter for Material icon codepoints
/// Accepts both decimal integers (58287) and hex strings ("0xe3af")
class IconCodepointConverter implements JsonConverter<int?, Object?> {
  const IconCodepointConverter();

  @override
  int? fromJson(Object? json) {
    if (json == null) return null;

    if (json is int) {
      return json; // Already an integer
    }

    if (json is String) {
      // Handle hex strings like "0xe3af" or "0xE3AF"
      if (json.toLowerCase().startsWith('0x')) {
        // Strip the "0x" prefix before parsing
        return int.tryParse(json.substring(2), radix: 16);
      }
      // Handle decimal strings like "58287"
      return int.tryParse(json);
    }

    return null;
  }

  @override
  Object? toJson(int? value) => value;
}

/// Custom JSON converter for integer fields that may be sent as strings
/// Accepts both integers (80) and numeric strings ("80")
class FlexibleIntConverter implements JsonConverter<int?, Object?> {
  const FlexibleIntConverter();

  @override
  int? fromJson(Object? json) {
    if (json == null) return null;

    if (json is int) {
      return json;
    }

    if (json is String) {
      return int.tryParse(json);
    }

    return null;
  }

  @override
  Object? toJson(int? value) => value;
}

/// Custom JSON converter for string fields that may be sent as numbers
/// Accepts both strings ("1.0.0") and numbers (1.0) - converts to string
class FlexibleStringConverter implements JsonConverter<String?, Object?> {
  const FlexibleStringConverter();

  @override
  String? fromJson(Object? json) {
    if (json == null) return null;

    if (json is String) {
      return json;
    }

    if (json is num) {
      return json.toString();
    }

    return null;
  }

  @override
  Object? toJson(String? value) => value;
}

/// Represents an ehDP-compatible IoT device discovered on the local network
@freezed
class Device with _$Device {
  const Device._();

  const factory Device({
    /// Protocol identifier and version (must start with "ehdp/")
    required String proto,

    /// Device's current IPv4 address
    required String ip,

    /// Material Symbols icon codepoint (e.g., 0xe8b5 for schedule)
    /// Accepts decimal (59573) or hex string ("0xe8b5")
    @IconCodepointConverter()
    @JsonKey(name: 'material_symbol')
    int? materialSymbol,

    /// Project or software name (e.g., "ehRadio", "WLED")
    String? project,

    /// Firmware variant or build name (e.g., "ESP32S3OLED")
    String? firmware,

    /// User-given device label (e.g., "Kitchen Radio")
    String? name,

    /// Firmware or software version string
    /// Accepts both strings ("1.0.0") and numbers (1.0)
    @FlexibleStringConverter() String? version,

    /// mDNS hostname (e.g., "mydevice.local")
    String? mdns,

    /// Port of the web UI (0 or null means no web UI)
    /// Accepts both integers (80) and numeric strings ("80")
    @FlexibleIntConverter() @JsonKey(name: 'ui_port') int? uiPort,

    /// Array of extra capability tags
    List<String>? capabilities,
  }) = _Device;

  /// Creates a Device from JSON response
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  /// Returns the display name using fallback priority: name → project → firmware
  String get displayName {
    if (name != null && name!.isNotEmpty) {
      return name!;
    }
    if (project != null && project!.isNotEmpty) {
      return project!;
    }
    if (firmware != null && firmware!.isNotEmpty) {
      return firmware!;
    }
    return 'Unknown Device';
  }

  /// Checks if the device has a web UI available
  bool get hasWebUI {
    return uiPort != null && uiPort! > 0;
  }

  /// Constructs the URL for the device's web UI
  /// Always uses IP address for maximum compatibility
  String? get webUIUrl {
    if (!hasWebUI) {
      return null;
    }

    return 'http://$ip:$uiPort/';
  }
}
