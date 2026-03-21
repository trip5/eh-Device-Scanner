// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceImpl _$$DeviceImplFromJson(Map<String, dynamic> json) => _$DeviceImpl(
  proto: json['proto'] as String,
  ip: json['ip'] as String,
  materialSymbol: const IconCodepointConverter().fromJson(
    json['material_symbol'],
  ),
  project: json['project'] as String?,
  firmware: json['firmware'] as String?,
  name: json['name'] as String?,
  version: const FlexibleStringConverter().fromJson(json['version']),
  mdns: json['mdns'] as String?,
  uiPort: const FlexibleIntConverter().fromJson(json['ui_port']),
  capabilities: (json['capabilities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$DeviceImplToJson(_$DeviceImpl instance) =>
    <String, dynamic>{
      'proto': instance.proto,
      'ip': instance.ip,
      'material_symbol': const IconCodepointConverter().toJson(
        instance.materialSymbol,
      ),
      'project': instance.project,
      'firmware': instance.firmware,
      'name': instance.name,
      'version': const FlexibleStringConverter().toJson(instance.version),
      'mdns': instance.mdns,
      'ui_port': const FlexibleIntConverter().toJson(instance.uiPort),
      'capabilities': instance.capabilities,
    };
