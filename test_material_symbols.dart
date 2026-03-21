import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Material Symbols Test')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Using package's constant
              const Icon(Symbols.schedule, size: 48),
              const SizedBox(height: 20),
              const Text('schedule (package constant)'),
              const SizedBox(height: 40),

              // Using codepoint directly
              const Icon(
                IconData(0xe8b5, fontFamily: 'Material Symbols Outlined'),
                size: 48,
              ),
              const SizedBox(height: 20),
              const Text('0xe8b5 (Material Symbols Outlined)'),
              const SizedBox(height: 40),

              // Try without spaces
              const Icon(
                IconData(0xe8b5, fontFamily: 'MaterialSymbolsOutlined'),
                size: 48,
              ),
              const SizedBox(height: 20),
              const Text('0xe8b5 (MaterialSymbolsOutlined)'),
              const SizedBox(height: 40),

              // Check what the package uses
              Text('Package font family: ${Symbols.schedule.fontFamily}'),
              Text(
                'Package codepoint: 0x${Symbols.schedule.codePoint.toRadixString(16)}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
