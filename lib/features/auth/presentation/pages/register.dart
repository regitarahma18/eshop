import 'package:eshop/core/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 1. Disesuaikan: Controller untuk setiap input field
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // 2. Disesuaikan: State visibilitas untuk kedua field password
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // State untuk mengelola apakah form sudah terisi atau belum
  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();
    // Disesuaikan: Tambahkan listener ke semua controller
    _emailController.addListener(_updateFormState);
    _usernameController.addListener(_updateFormState);
    _passwordController.addListener(_updateFormState);
    _confirmPasswordController.addListener(_updateFormState);
  }

  void _updateFormState() {
    setState(() {
      // Disesuaikan: Tombol akan aktif jika SEMUA field tidak kosong
      _isFormFilled = _emailController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Disesuaikan: Hapus semua listener dan dispose semua controller
    _emailController.removeListener(_updateFormState);
    _usernameController.removeListener(_updateFormState);
    _passwordController.removeListener(_updateFormState);
    _confirmPasswordController.removeListener(_updateFormState);
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackground(screenHeight),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  SvgPicture.asset(
                    'assets/images/eshop_logo.svg',
                    height: screenHeight * 0.20,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _buildRegisterCard(),
                  const SizedBox(height: 24),
                  _buildSignInText(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Register', // Diubah
              style: AppTypography.h3.copyWith(
                fontWeight: AppTypography.bold,
                color: AppColors.primary500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Umum', // Diubah
              style: AppTypography.body.copyWith(
                color: AppColors.grayscale200,
                  fontWeight: AppTypography.semiBold
              ),
            ),
            const SizedBox(height: 24),
            // Disesuaikan: Input fields untuk registrasi
            _buildTextField(
              controller: _emailController,
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _usernameController,
              hintText: 'Username',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              controller: _passwordController,
              isVisible: _isPasswordVisible,
              onToggleVisibility: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              isVisible: _isConfirmPasswordVisible,
              onToggleVisibility: () {
                setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
              },
            ),
            const SizedBox(height: 24),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.body.copyWith(color: AppColors.grayscale200),
        prefixIcon: Icon(prefixIcon, color: AppColors.primary300),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.grayscale50,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.grayscale50,
            width: 1.5,
          ),
        ),

      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    String hintText = 'Password',
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.body.copyWith(color: AppColors.grayscale200),
        prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary300),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.primary300,
          ),
          onPressed: onToggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            //borderSide: BorderSide.none,
            borderSide: BorderSide(
              color: AppColors.grayscale50,
            )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.grayscale50,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _isFormFilled ? () {
        // TODO: Logika Register
        print('Registering...');
      }  : null,
      style: ElevatedButton.styleFrom(
        // Diubah: Menggunakan warna dari theme
        backgroundColor: AppColors.primary500,
        disabledBackgroundColor: AppColors.grayscale100, // Warna disabled yang sesuai
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // Properti lain (padding, shape, elevation) diatur oleh AppTheme
      ),
      child: Text(
          'Register',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
      ), //
      ),
    );
  }

  Widget _buildSignInText() {
    return RichText(
      text: TextSpan(
        style: AppTypography.caption.copyWith(color: AppColors.grayscale400),
        children: [
          const TextSpan(text: 'Sudah punya akun? '),
          TextSpan(
            text: 'Sign in', // Diubah
            style: AppTypography.caption.copyWith(
              fontWeight: AppTypography.bold,
              color: AppColors.primary500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigasi kembali ke halaman login
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(double screenHeight) {
    // Fungsi ini sama persis dengan halaman login
    return ClipPath(
      clipper: _BackgroundClipper(),
      child: Container(
        height: screenHeight * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondary500.withOpacity(0.85),
              AppColors.secondary300.withOpacity(0.85),
              AppColors.primary300.withOpacity(0.85),
              AppColors.primary500.withOpacity(0.50),
            ],
            stops: const [0.0, 0.38, 0.72, 1.0],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  // Class ini sama persis dengan halaman login
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}