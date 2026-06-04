import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class TentangScreen extends StatelessWidget {
  const TentangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryDeep, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Tentang Aplikasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          // ── Logo & nama app ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryDeep,
                  AppColors.primaryDark,
                  Color(0xFF1D4ED8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                    color: AppColors.primaryDark.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6))
              ],
            ),
            child: Column(children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3), width: 2)),
                child: const Icon(Icons.school_rounded,
                    size: 42, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text('Les Private Anak Pintar',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 6),
              Text('Versi 1.0.0',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.7))),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.35))),
                child: const Text('Belajar Lebih Mudah & Menyenangkan 🎓',
                    style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
          const SizedBox(height: 20),

          // ── Tentang Kami ─────────────────────────────────────
          _buildCard(
            icon: Icons.info_outline_rounded,
            title: 'Tentang Kami',
            child: const Text(
                'Les Private Anak Pintar adalah platform yang menghubungkan siswa dengan guru les terbaik secara mudah, cepat, dan terpercaya. Kami hadir untuk membantu siswa meraih prestasi terbaik mereka.',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textGrey, height: 1.6)),
          ),
          const SizedBox(height: 14),

          // ── Fitur ────────────────────────────────────────────
          _buildCard(
            icon: Icons.star_outline_rounded,
            title: 'Fitur Unggulan',
            child: Column(children: [
              _featureRow('👨‍🏫', 'Guru Terverifikasi',
                  'Semua guru telah melalui seleksi ketat'),
              _featureRow('📅', 'Jadwal Fleksibel',
                  'Belajar kapan saja sesuai kebutuhanmu'),
              _featureRow(
                  '💳', 'Pembayaran Aman', 'Transaksi terjamin & transparan'),
              _featureRow(
                  '📊', 'Laporan Belajar', 'Pantau perkembangan belajarmu'),
            ]),
          ),
          const SizedBox(height: 14),

          // ── Kontak ───────────────────────────────────────────
          _buildCard(
            icon: Icons.contact_support_outlined,
            title: 'Hubungi Kami',
            child: Column(children: [
              _contactRow(
                  Icons.email_outlined, 'Email', 'support@anakpintar.id'),
              _contactRow(Icons.phone_outlined, 'Telepon', '+62 811 2345 6789'),
              _contactRow(
                  Icons.language_outlined, 'Website', 'www.anakpintar.id'),
              _contactRow(
                  Icons.location_on_outlined, 'Alamat', 'Jakarta, Indonesia'),
            ]),
          ),
          const SizedBox(height: 14),

          // ── Legal ────────────────────────────────────────────
          _buildCard(
            icon: Icons.gavel_outlined,
            title: 'Informasi Legal',
            child: Column(children: [
              _legalRow('Versi Aplikasi', '1.0.0'),
              _legalRow('Terakhir Diperbarui', 'Mei 2026'),
              _legalRow('Platform', 'Android & iOS'),
              _legalRow('Lisensi', '© 2026 Les Private Anak Pintar'),
            ]),
          ),
          const SizedBox(height: 24),

          Text('Dibuat dengan ❤️ untuk generasi pintar Indonesia',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  Widget _buildCard(
      {required IconData icon, required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: AppColors.primary, size: 18)),
          const SizedBox(width: 10),
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark)),
        ]),
        const SizedBox(height: 14),
        const Divider(color: AppColors.border, height: 1),
        const SizedBox(height: 14),
        child,
      ]),
    );
  }

  Widget _featureRow(String emoji, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 18)))),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 2),
          Text(desc,
              style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
        ])),
      ]),
    );
  }

  Widget _contactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500)),
        ]),
      ]),
    );
  }

  Widget _legalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: AppColors.textGrey)),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                color: AppColors.textDark,
                fontWeight: FontWeight.w500)),
      ]),
    );
  }
}
