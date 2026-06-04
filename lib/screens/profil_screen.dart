import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

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
        title: const Text('Profil Siswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          // ── Avatar & nama ────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryDeep, AppColors.primaryDark],
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
              Stack(children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3), width: 2.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Center(
                      child: Text('A',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold))),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)),
                      child: const Icon(Icons.edit_rounded,
                          color: Colors.white, size: 13),
                    )),
              ]),
              const SizedBox(height: 14),
              const Text('Syahrul Romadhon',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25))),
                child: const Text('Siswa Aktif',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
          const SizedBox(height: 20),

          // ── Info pribadi ─────────────────────────────────────
          _buildSectionCard(
            title: 'Informasi Pribadi',
            icon: Icons.person_outline_rounded,
            children: [
              _buildInfoRow(
                  Icons.badge_outlined, 'Nama Lengkap', 'Syahrul Romadhon'),
              _buildInfoRow(Icons.email_outlined, 'Email', 'arul@email.com'),
              _buildInfoRow(
                  Icons.phone_outlined, 'No. Telepon', '+62 812 3456 7890'),
              _buildInfoRow(
                  Icons.cake_outlined, 'Tanggal Lahir', '10 Januari 2008'),
              _buildInfoRow(Icons.location_on_outlined, 'Alamat', 'Bekasi'),
            ],
          ),
          const SizedBox(height: 16),

          // ── Info belajar ─────────────────────────────────────
          _buildSectionCard(
            title: 'Info Belajar',
            icon: Icons.school_outlined,
            children: [
              _buildInfoRow(Icons.class_outlined, 'Kelas', 'SMA Kelas 12'),
              _buildInfoRow(Icons.menu_book_outlined, 'Mata Pelajaran',
                  'Matematika, IPA'),
              _buildInfoRow(
                  Icons.calendar_today_outlined, 'Bergabung', 'Juni 2026'),
              _buildInfoRow(Icons.stars_outlined, 'Total Sesi', '3 Sesi'),
            ],
          ),
          const SizedBox(height: 16),

          // ── Statistik mini ───────────────────────────────────
          Row(children: [
            Expanded(
                child: _buildStatCard('3', 'Total\nSesi', '📚',
                    AppColors.surfaceAlt, AppColors.primary)),
            const SizedBox(width: 12),
            Expanded(
                child: _buildStatCard('1', 'Hari\nAktif', '🗓️',
                    AppColors.warningLight, AppColors.warning)),
            const SizedBox(width: 12),
            Expanded(
                child: _buildStatCard('2', 'Guru\nDiikuti', '👨‍🏫',
                    AppColors.successLight, AppColors.success)),
          ]),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
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
        const SizedBox(height: 16),
        const Divider(color: AppColors.border, height: 1),
        const SizedBox(height: 12),
        ...children,
      ]),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500)),
        ])),
      ]),
    );
  }

  Widget _buildStatCard(
      String value, String label, String emoji, Color bgColor, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5)),
      child: Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 10, color: AppColors.textGrey, height: 1.3)),
      ]),
    );
  }
}
