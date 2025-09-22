import 'dart:async'; // 1. Diperlukan untuk menggunakan Timer/Future.delayed
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eshop/core/theme.dart';
import 'package:eshop/features/auth/presentation/pages/choose_role.dart';

// 2. Diubah dari StatelessWidget menjadi StatefulWidget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // 3. initState() dipanggil sekali saat halaman ini pertama kali dibuat
  @override
  void initState() {
    super.initState();
    _startTimerAndNavigate();
  }

  // 4. Fungsi untuk memulai timer dan navigasi
  void _startTimerAndNavigate() async {
    // Tunggu selama 3 detik
    await Future.delayed(const Duration(seconds: 3));

    // 'mounted' adalah properti untuk mengecek apakah halaman ini masih ada di layar.
    // Ini adalah best practice untuk menghindari error jika pengguna menutup aplikasi
    // sebelum 3 detik selesai.
    if (mounted) {
      // Navigasi ke ChooseRolePage, dan hapus SplashScreen dari riwayat navigasi
      // agar pengguna tidak bisa kembali ke sini dengan tombol "back".
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChooseRolePage()),
      );
    }
  }


  // 5. Seluruh UI dari kode Anda sebelumnya sekarang ada di dalam State object
  @override
  Widget build(BuildContext context) {
    // Dapatkan ukuran layar untuk penempatan elemen yang responsif
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final logoHeight = screenHeight * 0.2;
    final circleSize = screenHeight * 0.55;

    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary500.withOpacity(0.75),
                  AppColors.secondary300.withOpacity(0.75),
                  AppColors.primary300.withOpacity(0.75),
                  AppColors.primary500.withOpacity(0.75),
                ],
                stops: const [0.0, 0.38, 0.72, 1.0],
                begin: Alignment.topRight,
                end: const Alignment(1.0, 1.5),
              ),
            ),
          ),

          // Layer 2: Lingkaran-lingkaran dekoratif
          Positioned(
            top: screenHeight * -0.15,
            left: screenWidth * -0.3,
            child: _buildDecorativeCircle(circleSize),
          ),
          Positioned(
            bottom: screenHeight * -0.10,
            right: screenWidth * -0.3,
            child: _buildDecorativeCircle(circleSize),
          ),

          // Layer 3: Konten Utama (Logo)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/eshop_logo.svg',
                  height: logoHeight,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.primary300.withOpacity(0.25),
            AppColors.primary500.withOpacity(0.25),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}