import 'package:flutter/material.dart';
import 'package:pigym/router.dart';

void main() {
  runApp(const PiGym());
}

class PiGym extends StatelessWidget {
  const PiGym({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF436655),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF436655),
          onPrimary: Color(0xFFF5F5F5),
          secondary: Color(0xFF4A85B2),
          onSecondary: Color(0xFFF5F5F5),
          error: Color(0xFFA95C59),
          onError: Color(0xFFF5F5F5),
          surface: Color(0xFF2B3A4A),
          onSurface: Color(0xFFF5F5F5),
        ),
        scaffoldBackgroundColor: const Color(0xFF222E3A),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFF5F5F5),
            fontFamily: 'MadimiOne',
            fontSize: 52,
          ),
          displayMedium: TextStyle(
            color: Color(0xFFF5F5F5),
            fontFamily: 'MadimiOne',
            fontSize: 45,
          ),
          displaySmall: TextStyle(color: Color(0xFFF5F5F5)),
          headlineLarge: TextStyle(
            color: Color(0xFFF5F5F5),
            fontWeight: FontWeight.bold,
            fontFamily: 'MadimiOne',
          ),
          headlineMedium: TextStyle(
            color: Color(0xFFF5F5F5),
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            color: Color(0xFFF5F5F5),
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Color(0xFFF5F5F5),
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(color: Color(0xFFF5F5F5)),
          titleSmall: TextStyle(color: Color(0xFFF5F5F5)),
          bodyLarge: TextStyle(color: Color(0xFFF5F5F5)),
          bodyMedium: TextStyle(color: Color(0xFFF5F5F5)),
          bodySmall: TextStyle(color: Color(0xFFF5F5F5)),
          labelLarge: TextStyle(
            color: Color(0xFFF5F5F5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ), // For button text
          labelMedium: TextStyle(color: Color(0xFFF5F5F5)),
          labelSmall: TextStyle(color: Color(0xFFF5F5F5)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2B3A4A),
            foregroundColor: const Color(0xFFF5F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF5F5F5), size: 28),
      ),
    );
  }
}
