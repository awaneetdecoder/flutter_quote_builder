import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifiers/quote_notifier.dart';
import 'screens/quote_form_screen.dart'; // Corrected: "quote_form_screen"

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuoteNotifier(),
      child: const QuoteBuilderApp(),
    ),
  );
}

class QuoteBuilderApp extends StatelessWidget {
  const QuoteBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote Builder',
      debugShowCheckedModeBanner: false,
      // FIX: The _buildTheme function is provided below
      theme: _buildTheme(context), 
      // FIX: Make sure your file is named 'quote_form_screen.dart'
      home: const QuoteFormScreen(), 
    );
  }

  // --- FIX: REPLACE YOUR FUNCTION WITH THIS ---
  ThemeData _buildTheme(BuildContext context) {
    final baseTheme = ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: Colors.blue,
      useMaterial3: true,
    );

    // Use .copyWith() to correctly override parts of the theme
    return baseTheme.copyWith(
      // This is the fix: baseTheme.cardTheme.copyWith()
      cardTheme: baseTheme.cardTheme.copyWith(
        elevation: 8.0,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F3F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        labelStyle: const TextStyle(color: Color(0xFF495057)),
      ),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1.0,
        shadowColor: Colors.black26,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    );
  }
  // --- END OF FIX ---
}