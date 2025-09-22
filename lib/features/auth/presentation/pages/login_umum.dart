import 'package:eshop/features/auth/presentation/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eshop/core/theme.dart';

class LoginUmumPage extends StatefulWidget {
  const LoginUmumPage({super.key});

  @override
  State<LoginUmumPage> createState() => _LoginUmumPageState();
}

class _LoginUmumPageState extends State<LoginUmumPage> {
  final _npmController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  // 3. State untuk mengelola apakah form sudah terisi atau belum
  bool _isFormFilled = false;

  // 4. initState dipanggil sekali saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    // Tambahkan listener ke kedua controller. Setiap kali teks berubah,
    // fungsi _updateFormState akan dipanggil.
    _npmController.addListener(_updateFormState);
    _passwordController.addListener(_updateFormState);
  }

  // 5. Fungsi untuk memperbarui state tombol login
  void _updateFormState() {
    setState(() {
      // Tombol akan aktif jika kedua field tidak kosong
      _isFormFilled =
          _npmController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  // 6. dispose untuk membersihkan controller saat widget dihancurkan
  @override
  void dispose() {
    _npmController.removeListener(_updateFormState);
    _passwordController.removeListener(_updateFormState);
    _npmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Hindari keyboard menutupi input fields
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Latar belakang gradien yang melengkung
          _buildBackground(screenHeight),

          // Konten utama (logo dan form)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Logo di bagian atas
                  SizedBox(height: screenHeight * 0.1),
                  SvgPicture.asset(
                    'assets/images/eshop_logo.svg',
                    height: screenHeight * 0.20,
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Kartu form login
                  _buildLoginCard(),
                  const SizedBox(height: 24),
                  _buildSignupText(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membangun kartu form login
  Widget _buildLoginCard() {
    return Card(
      elevation: 8,
      color: Colors.white,
      //shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Teks "Login"
            Text(
              'Login',
              style: AppTypography.h3.copyWith(
                fontWeight: AppTypography.bold,
                color: AppColors.primary500,
              ),
            ),
            const SizedBox(height: 4),
            // Teks Subtitle
            Text(
              'Umum',
              style: AppTypography.body.copyWith(
                color: AppColors.grayscale200,
                fontWeight: AppTypography.semiBold
              ),
            ),
            const SizedBox(height: 24),
            // Input field NPM/NIP
            _buildTextField(
              controller: _npmController,
              hintText: 'NPM/NIP',
              prefixIcon: Icons.vpn_key_outlined,
            ),
            const SizedBox(height: 16),
            // Input field Password
            _buildPasswordField(),
            const SizedBox(height: 12),
            // Tombol "Forgot Password?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: AppTypography.body.copyWith(
                    color: AppColors.primary500,
                    fontWeight: AppTypography.semiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Tombol Login
            _buildLoginButton(),

          ],
        ),
      ),
    );
  }

  // Widget untuk membangun input field biasa
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

  // Widget khusus untuk input field password
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible, // Teks disembunyikan jika true
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: AppTypography.body.copyWith(color: AppColors.grayscale200),
        prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary300),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primary300,
          ),
          onPressed: () {
            // Ubah state untuk menampilkan/menyembunyikan password
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
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

  // Widget untuk membangun tombol login
  Widget _buildLoginButton() {
    return ElevatedButton(
      // onPressed akan null jika form belum diisi, membuat tombol disabled
      onPressed: _isFormFilled
          ? () {
        // TODO: Logika login
        print('NPM: ${_npmController.text}');
        print('Password: ${_passwordController.text}');
      }
          : null,
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
        'Login',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSignupText() {
    return RichText(
      text: TextSpan(
        style: AppTypography.body.copyWith(
          color: AppColors.grayscale400,
          fontWeight: AppTypography.semiBold,
        ),
        children: [
          const TextSpan(text: 'Belum punya akun? '),
          TextSpan(
            text: 'Signup',
            style: AppTypography.body.copyWith(
              fontWeight: AppTypography.bold,
              color: AppColors.primary500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }


  // Widget untuk membangun latar belakang gradien yang melengkung
  Widget _buildBackground(double screenHeight) {
    return ClipPath(
      clipper: _BackgroundClipper(),
      child: Container(
        height: screenHeight * 0.7, // Latar belakang mengisi 50% layar
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

// Class CustomClipper untuk membuat bentuk melengkung
class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8); // Mulai dari kiri bawah kurva

    // Membuat kurva melengkung ke bawah
    path.quadraticBezierTo(
      size.width / 2, // Titik kontrol di tengah bawah
      size.height, // Titik akhir di dasar
      size.width, // Titik akhir kurva di kanan bawah
      size.height * 0.8,
    );

    path.lineTo(size.width, 0); // Garis ke kanan atas
    path.close(); // Tutup path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}