import 'package:flutter/material.dart';

void main() {
  // Check what codepoint Flutter uses for schedule
  print(
    "Icons.schedule codepoint: 0x${Icons.schedule.codePoint.toRadixString(16)} (${Icons.schedule.codePoint})",
  );
  print(
    "Icons.assignment codepoint: 0x${Icons.assignment.codePoint.toRadixString(16)} (${Icons.assignment.codePoint})",
  ); // clipboard-like icon

  // Manual test of the codepoint the user mentioned
  const manualIcon = IconData(0xe8b5, fontFamily: 'MaterialIcons');
  print("\nManual 0xe8b5 codepoint: ${manualIcon.codePoint}");
  print("Manual fontFamily: ${manualIcon.fontFamily}");
}
