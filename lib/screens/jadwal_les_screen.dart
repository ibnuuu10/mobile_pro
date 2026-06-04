import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/jadwal_les.dart';
import '../utils/app_theme.dart';

class JadwalLesScreen extends StatelessWidget {
  const JadwalLesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aktif = daftarJadwal
        .where((j) => j.status.toLowerCase() != 'selesai')
        .toList();
    final selesai = daftarJadwal
        .where((j) => j.status.toLowerCase() == 'selesai')
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryDeep, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(children: [
          Text('Jadwal Les Saya',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Text('Pantau progres belajarmu 📈',
              style: TextStyle(fontSize: 11, color: Colors.white70)),
        ]),
      ),
      body: aktif.isEmpty && selesai.isEmpty
          ? _buildEmptyState(context)
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBanner(aktif.length, selesai.length),
                  const SizedBox(height: 22),
                  if (aktif.isNotEmpty) ...[
                    _sectionHeader('🗓️ Jadwal Aktif', AppColors.primary),
                    const SizedBox(height: 12),
                    ...aktif.map((j) => _buildCard(j, isAktif: true)),
                  ],
                  if (selesai.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    _sectionHeader('✅ Riwayat Les', AppColors.textGrey),
                    const SizedBox(height: 12),
                    ...selesai.map((j) => _buildCard(j, isAktif: false)),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: const Text('📭', style: TextStyle(fontSize: 60)),
            ),
            const SizedBox(height: 24),
            const Text('Belum ada jadwal',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMid)),
            const SizedBox(height: 10),
            const Text(
              'Kamu belum memiliki jadwal les.\nYuk, pesan les sekarang!',
              style:
                  TextStyle(fontSize: 14, color: AppColors.textGrey, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              icon: const Icon(Icons.search_rounded),
              label: const Text('Cari Guru Les'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, Color color) {
    return Row(children: [
      Container(
        width: 4,
        height: 20,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      ),
      const SizedBox(width: 10),
      Text(title,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: color)),
    ]);
  }

  Widget _buildBanner(int aktif, int selesai) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDeep, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(children: [
        _statItem('$aktif', 'Les Aktif', Icons.calendar_today_rounded),
        _divider(),
        _statItem('$selesai', 'Selesai', Icons.check_circle_rounded),
        _divider(),
        _statItem('${aktif + selesai}', 'Total Sesi', Icons.bar_chart_rounded),
      ]),
    );
  }

  // Pakai Icon widget, bukan emoji string — lebih reliable di semua device
  Widget _statItem(String val, String label, IconData icon) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 22),
          const SizedBox(height: 6),
          Text(val,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _divider() => Container(width: 1, height: 50, color: Colors.white24);

  Widget _buildCard(JadwalLes jadwal, {required bool isAktif}) {
    const hariColors = {
      'Senin': AppColors.primary,
      'Selasa': Color(0xFF7C3AED),
      'Rabu': AppColors.success,
      'Kamis': AppColors.warning,
      'Jumat': Color(0xFF0891B2),
      'Sabtu': AppColors.danger,
    };

    final hariColor = hariColors[jadwal.hari] ?? AppColors.primary;
    final statusColor = isAktif ? AppColors.primary : AppColors.textGrey;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      // ✅ FIX: Tidak pakai Border() campur width berbeda.
      // Bungkus dua layer: luar untuk shadow+rounded, dalam untuk stripe kiri.
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border), // semua sisi sama
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // ✅ Stripe kiri sebagai widget terpisah — bukan border
              Container(
                width: 5,
                color: hariColor,
              ),

              // Konten card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      // Blok hari
                      Container(
                        width: 58,
                        height: 68,
                        decoration: BoxDecoration(
                          color: hariColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              jadwal.hari.substring(0, 3).toUpperCase(),
                              style: TextStyle(
                                color: hariColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Icon(Icons.calendar_month_rounded,
                                color: hariColor, size: 24),
                          ],
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Info jadwal
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jadwal.mataPelajaran,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              jadwal.namaGuru,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textGrey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(children: [
                              Icon(Icons.access_time_rounded,
                                  size: 13, color: statusColor),
                              const SizedBox(width: 4),
                              Text(jadwal.jam,
                                  style: TextStyle(
                                      fontSize: 12, color: statusColor)),
                            ]),
                            const SizedBox(height: 3),
                            Row(children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 13, color: AppColors.textGrey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  jadwal.lokasi,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textGrey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Badge status
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isAktif
                              ? AppColors.surfaceAlt
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: statusColor.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          jadwal.status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}