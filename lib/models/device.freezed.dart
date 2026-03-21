// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return _Device.fromJson(json);
}

/// @nodoc
mixin _$Device {
  /// Protocol identifier and version (must start with "ehdp/")
  String get proto => throw _privateConstructorUsedError;

  /// Device's current IPv4 address
  String get ip => throw _privateConstructorUsedError;

  /// Material Symbols icon codepoint (e.g., 0xe8b5 for schedule)
  /// Accepts decimal (59573) or hex string ("0xe8b5")
  @IconCodepointConverter()
  @JsonKey(name: 'material_symbol')
  int? get materialSymbol => throw _privateConstructorUsedError;

  /// Project or software name (e.g., "ehRadio", "WLED")
  String? get project => throw _privateConstructorUsedError;

  /// Firmware variant or build name (e.g., "ESP32S3OLED")
  String? get firmware => throw _privateConstructorUsedError;

  /// User-given device label (e.g., "Kitchen Radio")
  String? get name => throw _privateConstructorUsedError;

  /// Firmware or software version string
  /// Accepts both strings ("1.0.0") and numbers (1.0)
  @FlexibleStringConverter()
  String? get version => throw _privateConstructorUsedError;

  /// mDNS hostname (e.g., "mydevice.local")
  String? get mdns => throw _privateConstructorUsedError;

  /// Port of the web UI (0 or null means no web UI)
  /// Accepts both integers (80) and numeric strings ("80")
  @FlexibleIntConverter()
  @JsonKey(name: 'ui_port')
  int? get uiPort => throw _privateConstructorUsedError;

  /// Array of extra capability tags
  List<String>? get capabilities => throw _privateConstructorUsedError;

  /// Serializes this Device to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceCopyWith<Device> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceCopyWith<$Res> {
  factory $DeviceCopyWith(Device value, $Res Function(Device) then) =
      _$DeviceCopyWithImpl<$Res, Device>;
  @useResult
  $Res call({
    String proto,
    String ip,
    @IconCodepointConverter()
    @JsonKey(name: 'material_symbol')
    int? materialSymbol,
    String? project,
    String? firmware,
    String? name,
    @FlexibleStringConverter() String? version,
    String? mdns,
    @FlexibleIntConverter() @JsonKey(name: 'ui_port') int? uiPort,
    List<String>? capabilities,
  });
}

/// @nodoc
class _$DeviceCopyWithImpl<$Res, $Val extends Device>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proto = null,
    Object? ip = null,
    Object? materialSymbol = freezed,
    Object? project = freezed,
    Object? firmware = freezed,
    Object? name = freezed,
    Object? version = freezed,
    Object? mdns = freezed,
    Object? uiPort = freezed,
    Object? capabilities = freezed,
  }) {
    return _then(
      _value.copyWith(
            proto: null == proto
                ? _value.proto
                : proto // ignore: cast_nullable_to_non_nullable
                      as String,
            ip: null == ip
                ? _value.ip
                : ip // ignore: cast_nullable_to_non_nullable
                      as String,
            materialSymbol: freezed == materialSymbol
                ? _value.materialSymbol
                : materialSymbol // ignore: cast_nullable_to_non_nullable
                      as int?,
            project: freezed == project
                ? _value.project
                : project // ignore: cast_nullable_to_non_nullable
                      as String?,
            firmware: freezed == firmware
                ? _value.firmware
                : firmware // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            version: freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String?,
            mdns: freezed == mdns
                ? _value.mdns
                : mdns // ignore: cast_nullable_to_non_nullable
                      as String?,
            uiPort: freezed == uiPort
                ? _value.uiPort
                : uiPort // ignore: cast_nullable_to_non_nullable
                      as int?,
            capabilities: freezed == capabilities
                ? _value.capabilities
                : capabilities // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceImplCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$$DeviceImplCopyWith(
    _$DeviceImpl value,
    $Res Function(_$DeviceImpl) then,
  ) = __$$DeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String proto,
    String ip,
    @IconCodepointConverter()
    @JsonKey(name: 'material_symbol')
    int? materialSymbol,
    String? project,
    String? firmware,
    String? name,
    @FlexibleStringConverter() String? version,
    String? mdns,
    @FlexibleIntConverter() @JsonKey(name: 'ui_port') int? uiPort,
    List<String>? capabilities,
  });
}

/// @nodoc
class __$$DeviceImplCopyWithImpl<$Res>
    extends _$DeviceCopyWithImpl<$Res, _$DeviceImpl>
    implements _$$DeviceImplCopyWith<$Res> {
  __$$DeviceImplCopyWithImpl(
    _$DeviceImpl _value,
    $Res Function(_$DeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proto = null,
    Object? ip = null,
    Object? materialSymbol = freezed,
    Object? project = freezed,
    Object? firmware = freezed,
    Object? name = freezed,
    Object? version = freezed,
    Object? mdns = freezed,
    Object? uiPort = freezed,
    Object? capabilities = freezed,
  }) {
    return _then(
      _$DeviceImpl(
        proto: null == proto
            ? _value.proto
            : proto // ignore: cast_nullable_to_non_nullable
                  as String,
        ip: null == ip
            ? _value.ip
            : ip // ignore: cast_nullable_to_non_nullable
                  as String,
        materialSymbol: freezed == materialSymbol
            ? _value.materialSymbol
            : materialSymbol // ignore: cast_nullable_to_non_nullable
                  as int?,
        project: freezed == project
            ? _value.project
            : project // ignore: cast_nullable_to_non_nullable
                  as String?,
        firmware: freezed == firmware
            ? _value.firmware
            : firmware // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        version: freezed == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String?,
        mdns: freezed == mdns
            ? _value.mdns
            : mdns // ignore: cast_nullable_to_non_nullable
                  as String?,
        uiPort: freezed == uiPort
            ? _value.uiPort
            : uiPort // ignore: cast_nullable_to_non_nullable
                  as int?,
        capabilities: freezed == capabilities
            ? _value._capabilities
            : capabilities // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceImpl extends _Device {
  const _$DeviceImpl({
    required this.proto,
    required this.ip,
    @IconCodepointConverter()
    @JsonKey(name: 'material_symbol')
    this.materialSymbol,
    this.project,
    this.firmware,
    this.name,
    @FlexibleStringConverter() this.version,
    this.mdns,
    @FlexibleIntConverter() @JsonKey(name: 'ui_port') this.uiPort,
    final List<String>? capabilities,
  }) : _capabilities = capabilities,
       super._();

  factory _$DeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceImplFromJson(json);

  /// Protocol identifier and version (must start with "ehdp/")
  @override
  final String proto;

  /// Device's current IPv4 address
  @override
  final String ip;

  /// Material Symbols icon codepoint (e.g., 0xe8b5 for schedule)
  /// Accepts decimal (59573) or hex string ("0xe8b5")
  @override
  @IconCodepointConverter()
  @JsonKey(name: 'material_symbol')
  final int? materialSymbol;

  /// Project or software name (e.g., "ehRadio", "WLED")
  @override
  final String? project;

  /// Firmware variant or build name (e.g., "ESP32S3OLED")
  @override
  final String? firmware;

  /// User-given device label (e.g., "Kitchen Radio")
  @override
  final String? name;

  /// Firmware or software version string
  /// Accepts both strings ("1.0.0") and numbers (1.0)
  @override
  @FlexibleStringConverter()
  final String? version;

  /// mDNS hostname (e.g., "mydevice.local")
  @override
  final String? mdns;

  /// Port of the web UI (0 or null means no web UI)
  /// Accepts both integers (80) and numeric strings ("80")
  @override
  @FlexibleIntConverter()
  @JsonKey(name: 'ui_port')
  final int? uiPort;

  /// Array of extra capability tags
  final List<String>? _capabilities;

  /// Array of extra capability tags
  @override
  List<String>? get capabilities {
    final value = _capabilities;
    if (value == null) return null;
    if (_capabilities is EqualUnmodifiableListView) return _capabilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Device(proto: $proto, ip: $ip, materialSymbol: $materialSymbol, project: $project, firmware: $firmware, name: $name, version: $version, mdns: $mdns, uiPort: $uiPort, capabilities: $capabilities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceImpl &&
            (identical(other.proto, proto) || other.proto == proto) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.materialSymbol, materialSymbol) ||
                other.materialSymbol == materialSymbol) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.firmware, firmware) ||
                other.firmware == firmware) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.mdns, mdns) || other.mdns == mdns) &&
            (identical(other.uiPort, uiPort) || other.uiPort == uiPort) &&
            const DeepCollectionEquality().equals(
              other._capabilities,
              _capabilities,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    proto,
    ip,
    materialSymbol,
    project,
    firmware,
    name,
    version,
    mdns,
    uiPort,
    const DeepCollectionEquality().hash(_capabilities),
  );

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceImplCopyWith<_$DeviceImpl> get copyWith =>
      __$$DeviceImplCopyWithImpl<_$DeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceImplToJson(this);
  }
}

abstract class _Device extends Device {
  const factory _Device({
    required final String proto,
    required final String ip,
    @IconCodepointConverter()
    @JsonKey(name: 'material_symbol')
    final int? materialSymbol,
    final String? project,
    final String? firmware,
    final String? name,
    @FlexibleStringConverter() final String? version,
    final String? mdns,
    @FlexibleIntConverter() @JsonKey(name: 'ui_port') final int? uiPort,
    final List<String>? capabilities,
  }) = _$DeviceImpl;
  const _Device._() : super._();

  factory _Device.fromJson(Map<String, dynamic> json) = _$DeviceImpl.fromJson;

  /// Protocol identifier and version (must start with "ehdp/")
  @override
  String get proto;

  /// Device's current IPv4 address
  @override
  String get ip;

  /// Material Symbols icon codepoint (e.g., 0xe8b5 for schedule)
  /// Accepts decimal (59573) or hex string ("0xe8b5")
  @override
  @IconCodepointConverter()
  @JsonKey(name: 'material_symbol')
  int? get materialSymbol;

  /// Project or software name (e.g., "ehRadio", "WLED")
  @override
  String? get project;

  /// Firmware variant or build name (e.g., "ESP32S3OLED")
  @override
  String? get firmware;

  /// User-given device label (e.g., "Kitchen Radio")
  @override
  String? get name;

  /// Firmware or software version string
  /// Accepts both strings ("1.0.0") and numbers (1.0)
  @override
  @FlexibleStringConverter()
  String? get version;

  /// mDNS hostname (e.g., "mydevice.local")
  @override
  String? get mdns;

  /// Port of the web UI (0 or null means no web UI)
  /// Accepts both integers (80) and numeric strings ("80")
  @override
  @FlexibleIntConverter()
  @JsonKey(name: 'ui_port')
  int? get uiPort;

  /// Array of extra capability tags
  @override
  List<String>? get capabilities;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceImplCopyWith<_$DeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
