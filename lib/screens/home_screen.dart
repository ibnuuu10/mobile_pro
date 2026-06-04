import 'package:flutter/material.dart';
import 'daftar_guru_screen.dart';
import 'jadwal_les_screen.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school_rounded, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text('Anak Pintar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(children: [
              const Icon(Icons.notifications_outlined, color: Colors.white),
              Positioned(right: 0, top: 0,
                child: Container(width: 8, height: 8,
                  decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle))),
            ]),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('🔔 Tidak ada notifikasi baru'),
                backgroundColor: AppColors.primaryDark,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeBanner(context),
              const SizedBox(height: 24),
              _sectionTitle('Menu Utama'),
              const SizedBox(height: 14),
              _buildMenuGrid(context),
              const SizedBox(height: 24),
              _sectionTitle('Statistik Belajar'),
              const SizedBox(height: 14),
              _buildStatRow(),
              const SizedBox(height: 24),
              _sectionTitle('Tips Belajar Hari Ini'),
              const SizedBox(height: 14),
              _buildTips(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Row(
    children: [
      Container(width: 4, height: 20,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryDeep, AppColors.primary],
            begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 10),
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
    ],
  );

  Widget _buildWelcomeBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDeep, AppColors.primaryDark, Color(0xFF1D4ED8)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppColors.primaryDark.withValues(alpha: 0.3),
            blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Stack(
        children: [
          // Dekorasi lingkaran
          Positioned(right: -20, top: -20,
            child: Container(width: 120, height: 120,
              decoration: BoxDecoration(shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05)))),
          Positioned(right: 40, bottom: -30,
            child: Container(width: 80, height: 80,
              decoration: BoxDecoration(shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04)))),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.35)),
                        ),
                        child: const Row(mainAxisSize: MainAxisSize.min, children: [
                          Text('👋', style: TextStyle(fontSize: 12)),
                          SizedBox(width: 4),
                          Text('Halo, Pelajar!',
                            style: TextStyle(color: AppColors.secondary, fontSize: 12, fontWeight: FontWeight.w600)),
                        ]),
                      ),
                      const SizedBox(height: 12),
                      const Text('Siap belajar\nbersama guru terbaik?',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3)),
                      const SizedBox(height: 6),
                      Text('Temukan guru terbaik\nuntuk masa depanmu!',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12, height: 1.4)),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const DaftarGuruScreen())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: AppColors.secondary.withValues(alpha: 0.4),
                              blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: const Row(mainAxisSize: MainAxisSize.min, children: [
                            Text('Cari Guru Sekarang',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(children: [
                  Container(padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Text('📚', style: TextStyle(fontSize: 36))),
                  const SizedBox(height: 8),
                  Container(padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), shape: BoxShape.circle),
                    child: const Text('✏️', style: TextStyle(fontSize: 24))),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    final menus = [
      _Menu(Icons.people_alt_rounded, 'Daftar Guru', 'Temukan guru terbaik',
        AppColors.primary, AppColors.surfaceAlt, '👨‍🏫',
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DaftarGuruScreen()))),
      _Menu(Icons.calendar_month_rounded, 'Jadwal Les', 'Lihat jadwal belajar',
        AppColors.success, AppColors.successLight, '📅',
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JadwalLesScreen()))),
    ];
    return Row(
      children: menus.asMap().entries.map((e) => Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: e.key == 0 ? 10 : 0),
          child: _menuCard(e.value),
        ),
      )).toList(),
    );
  }

  Widget _menuCard(_Menu m) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: m.onTap, borderRadius: BorderRadius.circular(20),
        splashColor: m.color.withValues(alpha: 0.08),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border, width: 1.5),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: m.bgColor, borderRadius: BorderRadius.circular(14)),
                child: Icon(m.icon, color: m.color, size: 24),
              ),
              const Spacer(),
              Text(m.emoji, style: const TextStyle(fontSize: 28)),
            ]),
            const SizedBox(height: 14),
            Text(m.label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: m.color)),
            const SizedBox(height: 4),
            Text(m.subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: m.bgColor, borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text('Lihat', style: TextStyle(fontSize: 10, color: m.color, fontWeight: FontWeight.w600)),
                const SizedBox(width: 2),
                Icon(Icons.arrow_forward_rounded, size: 10, color: m.color),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildStatRow() {
    final stats = [
      _Stat('3', 'Sesi Les', '📖', AppColors.warningLight, AppColors.warning),
      _Stat('2', 'Guru Aktif', '👩‍🏫', const Color(0xFFF3E8FF), const Color(0xFF7C3AED)),
      _Stat('12', 'Jam Belajar', '⏱️', AppColors.successLight, AppColors.success),
    ];
    return Row(
      children: stats.asMap().entries.map((e) => Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: e.key < 2 ? 10 : 0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: Column(children: [
              Container(padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: e.value.bgColor, shape: BoxShape.circle),
                child: Text(e.value.emoji, style: const TextStyle(fontSize: 20))),
              const SizedBox(height: 8),
              Text(e.value.value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: e.value.color)),
              const SizedBox(height: 3),
              Text(e.value.label,
                style: const TextStyle(fontSize: 10, color: AppColors.textGrey, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
            ]),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildTips() {
    final tips = [
      ('📚', 'Belajar 1 jam tiap hari lebih efektif dari belajar marathon!', AppColors.surfaceAlt, AppColors.primary),
      ('🎯', 'Tetapkan target mingguan agar belajar makin terarah.', AppColors.warningLight, AppColors.warning),
      ('💡', 'Jangan ragu tanya guru jika ada materi yang sulit.', AppColors.successLight, AppColors.success),
    ];
    return Column(
      children: tips.map((t) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Row(children: [
          Container(width: 44, height: 44,
            decoration: BoxDecoration(color: t.$3, borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(t.$1, style: const TextStyle(fontSize: 22)))),
          const SizedBox(width: 14),
          Expanded(child: Text(t.$2,
            style: const TextStyle(fontSize: 13, color: AppColors.textDark, height: 1.45))),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right_rounded, color: AppColors.textLight, size: 20),
        ]),
      )).toList(),
    );
  }
}

class _Menu {
  final IconData icon; final String label, subtitle, emoji;
  final Color color, bgColor; final VoidCallback onTap;
  const _Menu(this.icon, this.label, this.subtitle, this.color, this.bgColor, this.emoji, this.onTap);
}
class _Stat {
  final String value, label, emoji; final Color bgColor, color;
  const _Stat(this.value, this.label, this.emoji, this.bgColor, this.color);
}
