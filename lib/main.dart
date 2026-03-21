import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/theme_provider.dart';
import 'screens/scan_screen.dart';

void main() {
  runApp(const ProviderScope(child: EhDeviceScannerApp()));
}

class EhDeviceScannerApp extends ConsumerWidget {
  const EhDeviceScannerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'eh Device Scanner',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF003DA5), // Quebec Blue
          secondary: const Color(0xFFC80C02), // Canada Red
          surface: Colors.white,
          error: Colors.red,
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF003DA5), // Quebec Blue
          secondary: const Color(0xFFC80C02), // Canada Red
          surface: const Color(0xFF121212),
          error: Colors.redAccent,
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const ScanScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
