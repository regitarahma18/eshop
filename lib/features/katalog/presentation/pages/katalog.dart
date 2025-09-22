import 'package:eshop/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';


class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  int _indeksKategoriTerpilih = 0;
  int _indeksFilterTerpilih = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Katalog', style: AppTypography.h4.copyWith(fontWeight: AppTypography.bold, color: AppColors.primary500)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildTabKategori(),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildSearchBar(),
                  ),
                  const SizedBox(height: 16),
                  _buildFilterChips(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ];
        },
        body: _buildKontenTerpilih(),
      ),
    );
  }

  Widget _buildKontenTerpilih() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: switch (_indeksKategoriTerpilih) {
      // Dihapus 'const' dari pemanggilan widget
        0 => _GridBarang(),
        1 => _GridPelatihan(),
        2 => _GridPenyewaan(),
        3 => _GridPengujian(),
        _ => _GridBarang(),
      },
    );
  }

  Widget _buildTabKategori() {
    final daftarKategori = [
      {'ikon': Ph.package, 'label': 'Barang'},
      {'ikon': Ph.bookmark_simple, 'label': 'Pelatihan'},
      {'ikon': Ph.map_pin, 'label': 'Penyewaan'},
      {'ikon': Ph.drop, 'label': 'Pengujian'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(daftarKategori.length, (index) {
        final kategori = daftarKategori[index];
        final bool terpilih = _indeksKategoriTerpilih == index;
        return InkWell(
          onTap: () => setState(() => _indeksKategoriTerpilih = index),
          child: Column(
            children: [
              Iconify(kategori['ikon'] as String, color: terpilih ? AppColors.primary500 : AppColors.grayscale300, size: 28),
              const SizedBox(height: 8),
              Text(kategori['label'] as String, style: AppTypography.caption.copyWith(fontWeight: AppTypography.semiBold, color: terpilih ? AppColors.primary500 : AppColors.grayscale300)),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                width: terpilih ? 50 : 0,
                decoration: BoxDecoration(color: AppColors.secondary500, borderRadius: BorderRadius.circular(2)),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Cari',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Iconify(Ph.magnifying_glass, color: AppColors.grayscale200),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.grayscale100, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.primary300, width: 1.0),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final daftarFilter = [
      {'label': 'Semua', 'ikon': null},
      {'label': 'Promo', 'ikon': Ph.smiley},
      {'label': 'Baru', 'ikon': Ph.sparkle},
      {'label': 'Terbatas', 'ikon': Ph.lightning},
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: daftarFilter.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = daftarFilter[index];
          final bool terpilih = _indeksFilterTerpilih == index;
          return ChoiceChip(
            label: Text(filter['label'] as String),
            avatar: filter['ikon'] != null ? Iconify(filter['ikon'] as String, size: 18, color: terpilih ? Colors.white : AppColors.grayscale500) : null,
            selected: terpilih,
            onSelected: (selected) {
              if (selected) {
                setState(() => _indeksFilterTerpilih = index);
              }
            },
            showCheckmark: filter['ikon'] == null && terpilih,
            labelPadding: filter['ikon'] != null ? const EdgeInsets.only(left: 6) : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            labelStyle: AppTypography.caption.copyWith(fontWeight: AppTypography.semiBold, color: terpilih ? Colors.white : AppColors.grayscale500),
            backgroundColor: AppColors.grayscale50,
            selectedColor: AppColors.primary500,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: terpilih ? AppColors.primary500 : AppColors.grayscale100)),
          );
        },
      ),
    );
  }
}


class _GridBarang extends StatelessWidget {
  // Dihapus: 'const' dari constructor
  _GridBarang();

  final List<Map<String, dynamic>> daftarItem = const [
    {"gambar": "https://placehold.co/400x400/E0E0E0/31343C?text=Power+Supply","tag": "Preorder","tagBgColor": AppColors.secondary100,"tagTextColor": AppColors.secondary700,"judul": "Dual DC Power Supply","harga": "500.000","unit": "Unit","rating": 4.0,"jumlahUlasan": "100 reviews",},
    {"gambar": "https://placehold.co/400x400/E0E0E0/31343C?text=Product+2","tag": "Preorder","tagBgColor": AppColors.secondary100,"tagTextColor": AppColors.secondary700,"judul": "Digital Multimeter","harga": "350.000","unit": "Unit","rating": 4.2,"jumlahUlasan": "88 reviews",},
    {"gambar": "https://placehold.co/400x400/E0E0E0/31343C?text=Product+3","tag": "Ready","tagBgColor": AppColors.secondary100,"tagTextColor": AppColors.secondary700,"judul": "Soldering Iron Kit","harga": "150.000","unit": "Unit","rating": 3.8,"jumlahUlasan": "120 reviews",},
    {"gambar": "https://placehold.co/400x400/E0E0E0/31343C?text=Product+4","tag": "Ready","tagBgColor": AppColors.secondary100,"tagTextColor": AppColors.secondary700,"judul": "Oscilloscope Digital","harga": "1.200.000","unit": "Unit","rating": 4.8,"jumlahUlasan": "250 reviews",},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, mainAxisExtent: 295,
      ),
      itemCount: daftarItem.length,
      itemBuilder: (context, index) => _KatalogCard(item: daftarItem[index]),
    );
  }
}


class _GridPelatihan extends StatelessWidget {
  // Dihapus: 'const' dari constructor
  _GridPelatihan();

  final List<Map<String, dynamic>> daftarItem = const [
    {"gambar": "https://placehold.co/400x400/E2D2B2/31343C?text=UI/UX+Course","tag": "Offline Event","tagBgColor": AppColors.secondary100,"tagTextColor": AppColors.secondary700,"judul": "Womenland Summer: UI/UX...","harga": "50.000","unit": "Peserta","deskripsi": "Sri Indarti (Designer at Gojek)",},
    {"gambar": "https://placehold.co/400x400/B2C4E2/31343C?text=Flutter+Course","tag": "Online Event","tagBgColor": Color(0xFFFFECD7),"tagTextColor": Colors.orange,"judul": "Womenland Summer: UI/UX...","harga": "50.000","unit": "Peserta","deskripsi": "Sri Indarti (Designer at Gojek)",},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, mainAxisExtent: 295,
      ),
      itemCount: daftarItem.length,
      itemBuilder: (context, index) => _KatalogCard(item: daftarItem[index]),
    );
  }
}


class _GridPenyewaan extends StatelessWidget {
  // Dihapus: 'const' dari constructor
  _GridPenyewaan();

  final List<Map<String, dynamic>> daftarItem = const [
    {"gambar": "https://placehold.co/400x400/D2B48C/31343C?text=Tennis+Court","tag": "Outdoor Space","tagBgColor": AppColors.secondary100,"tagTextColor": AppColors.secondary700,"judul": "Lapangan Tenis UPN 'Veteran' Jaw..","harga": "250.000","unit": "3 Jam","rating": 4.0,"jumlahUlasan": "100 reviews",},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, mainAxisExtent: 295,
      ),
      itemCount: daftarItem.length,
      itemBuilder: (context, index) => _KatalogCard(item: daftarItem[index]),
    );
  }
}


class _GridPengujian extends StatelessWidget {
  // Dihapus: 'const' dari constructor
  _GridPengujian();

  final List<Map<String, dynamic>> daftarItem = const [
    {"gambar": "https://placehold.co/400x400/B0C4DE/31343C?text=Microscope","judul": "Analisis Jaringan Hewan/Tumbuhan","rating": 4.0,"jumlahUlasan": "100 reviews",},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, mainAxisExtent: 295,
      ),
      itemCount: daftarItem.length,
      itemBuilder: (context, index) => _KatalogCard(item: daftarItem[index]),
    );
  }
}


class _KatalogCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const _KatalogCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final String tag = item['tag'] ?? '';
    final Color? tagBgColor = item['tagBgColor'];
    final Color? tagTextColor = item['tagTextColor'];
    final String harga = item['harga'] ?? '';
    final String unit = item['unit'] ?? '';
    final String? deskripsi = item['deskripsi'];
    final double? rating = item['rating'];
    final String? jumlahUlasan = item['jumlahUlasan'];

    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      shadowColor: AppColors.grayscale500.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            item['gambar'],
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 140,
              color: AppColors.grayscale50,
              child: const Center(child: Icon(Icons.image_not_supported_outlined)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tag.isNotEmpty && tagBgColor != null && tagTextColor != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: tagBgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tag,
                        style: AppTypography.caption.copyWith(
                          fontWeight: AppTypography.bold,
                          color: tagTextColor,
                        ),
                      ),
                    ),
                  if (tag.isNotEmpty) const SizedBox(height: 8),
                  Text(
                    item['judul'],
                    style: AppTypography.body.copyWith(fontWeight: AppTypography.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (deskripsi != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        deskripsi,
                        style: AppTypography.caption.copyWith(color: AppColors.grayscale300),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const Spacer(),
                  if (harga.isNotEmpty)
                    Text(
                      'Rp$harga/${unit}',
                      style: AppTypography.body.copyWith(
                        fontWeight: AppTypography.semiBold,
                        color: AppColors.primary500,
                      ),
                    ),
                  if (rating != null && jumlahUlasan != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '$rating ($jumlahUlasan)',
                            style: AppTypography.caption.copyWith(color: AppColors.grayscale300),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}