import 'package:eshop/core/theme.dart';
import 'package:eshop/features/katalog/presentation/pages/katalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


class GradientIcon extends StatelessWidget {
  const GradientIcon({
    super.key,
    required this.icon,
    this.size = 24.0,
    required this.gradient,
  });

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // --- 1. PERUBAHAN UTAMA: DAFTAR HALAMAN ---
  // Daftar ini sekarang berisi widget-widget KONTEN, bukan kerangka utama.
  static final List<Widget> _pages = <Widget>[
    const _BerandaContent(), // Halaman Beranda sekarang menggunakan widget konten
    const KatalogPage(),  // Halaman Katalog
    const Center(child: Text('Halaman Wishlist')),
    const Center(child: Text('Halaman Pesanan')),
    const Center(child: Text('Halaman Profile')),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: GradientIcon(icon: Icons.home, gradient: AppGradients.mainGradient),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: GradientIcon(icon: Icons.menu_book, gradient: AppGradients.mainGradient),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: GradientIcon(icon: Icons.favorite, gradient: AppGradients.mainGradient),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: GradientIcon(icon: Icons.receipt_long, gradient: AppGradients.mainGradient),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: GradientIcon(icon: Icons.person, gradient: AppGradients.mainGradient),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary500,
        unselectedItemColor: AppColors.grayscale200,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedLabelStyle: AppTypography.caption.copyWith(
          fontWeight: AppTypography.semiBold,
        ),
        unselectedLabelStyle: AppTypography.caption,
      ),
      // --- 2. PERUBAHAN UTAMA: BODY ---
      // Body sekarang secara dinamis menampilkan halaman dari daftar _pages.
      body: _pages.elementAt(_selectedIndex),
    );
  }
}


// =========================================================================
// WIDGET BARU: KONTEN HALAMAN BERANDA
// Semua kode UI Anda sebelumnya sekarang ada di dalam widget StatelessWidget ini.
// =========================================================================
class _BerandaContent extends StatelessWidget {
  const _BerandaContent();

  // Data palsu dipindahkan ke sini
  final List<Map<String, dynamic>> popularCourses = const [
    {
      "image": "https://placehold.co/600x400/E2D2B2/31343C?text=UI/UX+Course",
      "title": "Womenland Summer: UI/UX Design",
      "instructor": "Sri Indarti (Designer at Gojek)",
      "price": "50.000",
      "rating": 4.0,
      "reviewCount": "100+",
    },
    {
      "image": "https://placehold.co/600x400/B2C4E2/31343C?text=Flutter+Course",
      "title": "Flutter Basic for Beginner",
      "instructor": "Budi Doremi (Mobile Dev at eShop)",
      "price": "75.000",
      "rating": 4.5,
      "reviewCount": "200+",
    },
    {
      "image": "https://placehold.co/600x400/DDB2E2/31343C?text=Marketing",
      "title": "Digital Marketing 101",
      "instructor": "Cahyo (Marketer at UPN)",
      "price": "50.000",
      "rating": 4.2,
      "reviewCount": "150+",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // UI ListView Anda sekarang ada di sini
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(context),
        const SizedBox(height: 60),
        _buildServiceIcons(),
        const SizedBox(height: 20),
        _buildPopularSection(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // 1. Diubah: Tinggi SizedBox diperbesar untuk memberi ruang bagi semua elemen,
    // termasuk bagian Card yang meluber ke bawah.
    return SizedBox(
      height: screenHeight * 0.27,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: _HeaderClipper(),
            child: Container(
              // 2. Diubah: Tinggi Container disamakan dengan tinggi background yang diinginkan,
              // bukan lebih besar dari parent-nya.
              height: screenHeight * 0.35,
              width: screenHeight * 10,
              // 3. Dihapus: 'width' tidak perlu diatur manual, biarkan Stack yang mengaturnya.
              child: SvgPicture.asset(
                'assets/images/eshop_header.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: Row(
              children: [
                _buildHeaderIconButton(
                  icon: Icons.email_outlined,
                  backgroundColor: AppColors.secondary50,
                  iconColor: AppColors.secondary900,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _buildHeaderIconButton(
                  icon: Icons.calendar_today_outlined,
                  backgroundColor: AppColors.primary50,
                  iconColor: AppColors.primary900,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _buildHeaderIconButton(
                  icon: Icons.notifications_none_outlined,
                  backgroundColor: Colors.white,
                  iconColor: AppColors.grayscale300,
                  onTap: () {},
                ),
              ],
            ),
          ),
          // 4. Diubah: Posisi Card disesuaikan agar pas dengan background baru.
          Positioned(
            top: screenHeight * 0.20,
            left: 24,
            right: 24,
            child: _buildWelcomeCard(),
          ),
        ],
      ),
    );
  }

// Di dalam class _HomePageState atau HomePage

  /// Widget helper untuk membangun tombol ikon di header
  Widget _buildHeaderIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color backgroundColor, // Parameter untuk warna background
    required Color iconColor,       // 1. Ditambahkan: Parameter untuk warna ikon
  }) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: backgroundColor,
      child: IconButton(
        // 2. Diubah: Menggunakan parameter 'iconColor'
        icon: Icon(icon, color: iconColor, size: 20),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selamat Datang,', style: AppTypography.caption.copyWith(color: AppColors.grayscale400)),
                  const SizedBox(height: 5),
                  Text(
                    'aghniqisthi',
                    style: AppTypography.title1.copyWith(
                      fontWeight: AppTypography.semiBold,
                      color: AppColors.primary500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('example@gmail.com', style: AppTypography.caption.copyWith(color: AppColors.grayscale300)),
                ],
              ),
            ),
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("https://placehold.co/100x100/A8D5BA/31343C?text=A"),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildServiceIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildServiceItem(icon: Icons.inventory_2_outlined, label: "Barang"),
          _buildServiceItem(icon: Icons.bookmark_border, label: "Latihan"),
          _buildServiceItem(icon: Icons.location_on_outlined, label: "Sewa"),
          _buildServiceItem(icon: Icons.science_outlined, label: "Uji"),
        ],
      ),
    );
  }

  Widget _buildServiceItem({required IconData icon, required String label}) {
    return Column(
      children: [
        const SizedBox(height: 15),
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.grayscale50,
          child:
          CircleAvatar(
            radius: 26.5,
            backgroundColor: Colors.white,
            child: Icon(icon, color: AppColors.primary500, size: 28),
          ),
        ),
        const SizedBox(height: 10),
        Text(label, style: AppTypography.caption.copyWith(fontWeight: AppTypography.semiBold, color: AppColors.grayscale400)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Yang Menarik Perhatianmu',
            style: AppTypography.title1.copyWith(fontWeight: AppTypography.bold),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Ayo ikut pelatihan ini', style: AppTypography.body.copyWith(color: AppColors.grayscale400)),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: popularCourses.length,
            itemBuilder: (context, index) {
              final course = popularCourses[index];
              return _PopularCourseCard(course: course);
            },
          ),
        ),
      ],
    );
  }
}

class _PopularCourseCard extends StatefulWidget {
  final Map<String, dynamic> course;
  const _PopularCourseCard({required this.course});

  @override
  State<_PopularCourseCard> createState() => _PopularCourseCardState();
}

class _PopularCourseCardState extends State<_PopularCourseCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 226,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.course['image'],
                  height: 133,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 133,
                    color: AppColors.grayscale50,
                    child: const Center(child: Icon(Icons.image_not_supported_outlined)),
                  ),
                ),
                Positioned(
                  top: 10, left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Text('Rp${widget.course['price']}', style: AppTypography.caption.copyWith(fontWeight: AppTypography.bold)),
                  ),
                ),
                Positioned(
                  top: 10, right: 10,
                  child: CircleAvatar(
                    radius: 16, backgroundColor: Colors.white,
                    child: IconButton(
                      iconSize: 18,
                      icon: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited ? Colors.redAccent : AppColors.grayscale300,
                      ),
                      onPressed: () => setState(() => _isFavorited = !_isFavorited),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10, left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 14),
                        const SizedBox(width: 4),
                        Text('${widget.course['rating']} (${widget.course['reviewCount']})', style: AppTypography.caption.copyWith(fontWeight: AppTypography.regular)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course['title'],
                      style: AppTypography.body.copyWith(fontWeight: AppTypography.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.course['instructor'],
                      style: AppTypography.caption.copyWith(color: AppColors.grayscale400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}