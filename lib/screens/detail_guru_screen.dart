import 'package:flutter/material.dart';
import '../models/guru.dart';
import '../utils/app_theme.dart';
import 'pilih_paket_screen.dart';

class DetailGuruScreen extends StatelessWidget {
  final Guru guru;
  const DetailGuruScreen({super.key, required this.guru});

  @override
  Widget build(BuildContext context) {
    final color =
        AppColors.avatarColors[guru.id % AppColors.avatarColors.length];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('📤 Link profil guru disalin!'),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2))),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  shape: BoxShape.circle),
              child: const Icon(Icons.share_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context, color),
      body: SingleChildScrollView(
        child: Column(children: [
          _buildHeader(color),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(children: [
              _buildInfoRow(),
              const SizedBox(height: 18),
              _buildDeskripsiCard(),
              const SizedBox(height: 14),
              _buildKeunggulanCard(),
              const SizedBox(height: 80),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeader(Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 90, bottom: 28, left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.primaryDeep, color.withValues(alpha: 0.85)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3.5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 6))
            ],
          ),
          alignment: Alignment.center,
          child: Text(guru.foto,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32)),
        ),
        const SizedBox(height: 14),
        Text(guru.nama,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Wrap(
            spacing: 8,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: [
              _pill(Icons.menu_book_rounded, guru.mataPelajaran),
              _pill(Icons.location_on_rounded, guru.lokasi),
            ]),
      ]),
    );
  }

  Widget _pill(IconData icon, String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: Colors.white, size: 13),
          const SizedBox(width: 5),
          Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ]),
      );

  Widget _buildInfoRow() {
    final items = [
      ('⭐', guru.rating.toString(), 'Rating'),
      ('👥', '${guru.jumlahSiswa}', 'Siswa'),
      ('💰', 'Rp ${_fmt(guru.hargaPerSesi)}', 'Per Sesi'),
    ];
    return Row(
      children: items
          .asMap()
          .entries
          .map((e) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: e.key > 0 ? 8 : 0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primaryDeep.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Column(children: [
                    Text(e.value.$1, style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 4),
                    Text(e.value.$2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.textMid)),
                    Text(e.value.$3,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textGrey)),
                  ]),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDeskripsiCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [
            Icon(Icons.person_outline_rounded,
                color: AppColors.primary, size: 20),
            SizedBox(width: 8),
            Text('Tentang Guru',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textMid)),
          ]),
          const Divider(height: 16),
          Text(guru.deskripsi,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textGrey, height: 1.6)),
        ]),
      );

  Widget _buildKeunggulanCard() {
    const items = [
      ('🗓️', 'Jadwal fleksibel sesuai kebutuhan'),
      ('🎮', 'Metode pengajaran interaktif'),
      ('📊', 'Laporan perkembangan berkala'),
      ('🎁', 'Gratis konsultasi pertama'),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.star_rounded, color: AppColors.primary, size: 20),
          SizedBox(width: 8),
          Text('Keunggulan',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.textMid)),
        ]),
        const SizedBox(height: 12),
        ...items.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(children: [
                Text(e.$1, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Text(e.$2,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textDark)),
              ]),
            )),
      ]),
    );
  }

  Widget _buildBottomBar(BuildContext context, Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(top: BorderSide(color: AppColors.border)),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(children: [
        Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mulai dari',
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
              Text('Rp ${_fmt(guru.hargaPerSesi)}',
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
            ]),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.shopping_cart_rounded, size: 18),
            label: const Text('Pesan Les'),
            onPressed: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary)));
              await Future.delayed(const Duration(milliseconds: 600));
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PilihPaketScreen(guru: guru)));
              }
            },
          ),
        ),
      ]),
    );
  }

  String _fmt(int h) {
    String s = h.toString();
    final r = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if ((s.length - i) % 3 == 0 && i != 0) r.write('.');
      r.write(s[i]);
    }
    return r.toString();
  }
}
