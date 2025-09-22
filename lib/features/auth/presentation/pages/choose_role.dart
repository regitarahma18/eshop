import 'package:eshop/core/theme.dart';
import 'package:eshop/features/auth/presentation/pages/login_umum.dart';
import 'package:eshop/features/auth/presentation/pages/login_upn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Dapatkan ukuran layar untuk membuat UI proporsional
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              // 2. Diubah: Ukuran logo dibuat proporsional
              SvgPicture.asset(
                'assets/images/eshop_logo_black.svg', // Logo berwarna lebih cocok di sini
                height: screenHeight * 0.18, // 18% dari tinggi layar
              ),
              const Spacer(flex: 1),
              _buildInfoCard(context),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        // 3. Diubah: Padding horizontal dikurangi agar lebih fleksibel
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text(
              'Selamat Datang,',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.bold,
                color: AppColors.primary500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'UPN-SHOP adalah tempat penyewaan dan pembelian produk yang disediakan oleh UPN "Veteran" Jawa Timur.',
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(
                color: AppColors.grayscale400,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Pilih Role yang sesuai',
              style: AppTypography.body.copyWith(
                fontWeight: AppTypography.semiBold,
                color: AppColors.grayscale500,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 4. SOLUSI UTAMA: Gunakan Expanded agar tombol mengisi ruang secara fleksibel
                Expanded(
                  child: _AnimatedRoleButton(
                    icon: Icons.school_outlined,
                    title: 'Civitas\nUPNVJT',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginUpnPage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16), // Jarak antar tombol
                Expanded(
                  child: _AnimatedRoleButton(
                    icon: Icons.groups_outlined,
                    title: 'Umum',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginUmumPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AnimatedRoleButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AnimatedRoleButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<_AnimatedRoleButton> createState() => _AnimatedRoleButtonState();
}

class _AnimatedRoleButtonState extends State<_AnimatedRoleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        transformAlignment: Alignment.center,
        // 5. Diubah: Hapus 'width' agar ukuran ditentukan oleh Expanded
        height: 110, // Tinggi tetap dipertahankan
        padding: const EdgeInsets.symmetric(horizontal: 8), // Padding agar konten tidak mepet
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grayscale50),
          boxShadow: [
            BoxShadow(
              color: AppColors.grayscale100.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 40,
              color: AppColors.primary300,
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: AppTypography.caption.copyWith(
                fontWeight: AppTypography.semiBold,
                color: AppColors.grayscale500,
              ),
            )
          ],
        ),
      ),
    );
  }
}