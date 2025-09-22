import 'package:eshop/features/auth/presentation/pages/login_upn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/auth/presentation/pages/choose_role.dart';
import 'features/splash/presentation/pages/splashscreen.dart';

// --- Catatan Penting ---
// Untuk menggunakan Google Fonts, tambahkan package-nya ke file pubspec.yaml Anda:
//
// dependencies:
//   flutter:
//     sdk: flutter
//   google_fonts: ^6.2.1
//
// Lalu jalankan `flutter pub get` di terminal.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Shop Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Gunakan Google Fonts sebagai tema teks default aplikasi Anda
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
