import 'package:material_symbols_icons/material_symbols_icons.dart';

void main() {
  print('Font family: ${Symbols.schedule.fontFamily}');
  print(
    'Schedule codepoint: 0x${Symbols.schedule.codePoint.toRadixString(16)} (${Symbols.schedule.codePoint})',
  );
  print(
    'Radio codepoint: 0x${Symbols.radio.codePoint.toRadixString(16)} (${Symbols.radio.codePoint})',
  );
  print(
    'Devices codepoint: 0x${Symbols.devices.codePoint.toRadixString(16)} (${Symbols.devices.codePoint})',
  );
}
