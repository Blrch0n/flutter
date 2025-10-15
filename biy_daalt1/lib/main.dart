import 'package:flutter/material.dart';
import 'screens/form_screen.dart';

void main() => runApp(const PrescriptionApp());

class PrescriptionApp extends StatelessWidget {
  const PrescriptionApp({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: scheme),
      home: const FormScreen(),
    );
  }
}
