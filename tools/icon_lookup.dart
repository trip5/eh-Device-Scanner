import 'package:flutter/material.dart';
import 'dart:mirrors';

/// Helper tool to find Material Icon codepoints used by Flutter
/// This shows the ACTUAL codepoints that Flutter's Material Icons font uses,
/// NOT the Material Symbols codepoints shown on fonts.google.com
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Material Icons Codepoint Lookup Tool');
    print('=====================================');
    print('Usage: dart run tools/icon_lookup.dart <icon_name>');
    print('');
    print('Examples:');
    print('  dart run tools/icon_lookup.dart schedule');
    print('  dart run tools/icon_lookup.dart radio');
    print('  dart run tools/icon_lookup.dart lightbulb');
    print('');
    print(
      'This tool shows the codepoints from Flutter\'s Material Icons font,',
    );
    print('which are DIFFERENT from the Material Symbols on fonts.google.com!');
    print('');
    print('Common Icons:');
    _printIcon('schedule', Icons.schedule);
    _printIcon('radio', Icons.radio);
    _printIcon('lightbulb', Icons.lightbulb);
    _printIcon('camera', Icons.camera);
    _printIcon('speaker', Icons.speaker);
    _printIcon('access_time', Icons.access_time);
    _printIcon('thermostat', Icons.thermostat);
    _printIcon('sensors', Icons.sensors);
    _printIcon('power', Icons.power);
    _printIcon('tv', Icons.tv);
    _printIcon('devices', Icons.devices);
    return;
  }

  final iconName = arguments[0].toLowerCase();

  // Try to find the icon by name
  final iconsClass = reflectClass(Icons);
  bool found = false;

  for (var declaration in iconsClass.declarations.values) {
    if (declaration is VariableMirror && declaration.isStatic) {
      final name = MirrorSystem.getName(declaration.simpleName);
      if (name.toLowerCase() == iconName) {
        final iconData =
            iconsClass.getField(declaration.simpleName).reflectee as IconData;
        print('Found: Icons.$name');
        _printIcon(name, iconData);
        found = true;
        break;
      }
    }
  }

  if (!found) {
    print('Icon "$iconName" not found in Flutter\'s Icons class.');
    print(
      'Try searching: https://api.flutter.dev/flutter/material/Icons-class.html',
    );
  }
}

void _printIcon(String name, IconData icon) {
  final hex = icon.codePoint.toRadixString(16);
  print(
    '  $name: 0x$hex (${icon.codePoint}) - Use "0x$hex" or ${icon.codePoint}',
  );
}
