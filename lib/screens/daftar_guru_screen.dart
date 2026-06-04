import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/guru.dart';
import '../utils/app_theme.dart';
import 'detail_guru_screen.dart';

class DaftarGuruScreen extends StatefulWidget {
  const DaftarGuruScreen({super.key});
  @override
  State<DaftarGuruScreen> createState() => _DaftarGuruScreenState();
}

class _DaftarGuruScreenState extends State<DaftarGuruScreen> {
  String _searchQuery = '';
  String _selectedKategori = 'Semua';
  final Set<int> _favorites = {};

  List<Guru> get _filteredGuru => daftarGuru.where((g) {
        final matchSearch = _searchQuery.isEmpty ||
            g.nama.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            g.mataPelajaran.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchKat =
            _selectedKategori == 'Semua' || g.kategori == _selectedKategori;
        return matchSearch && matchKat;
      }).toList();

  void _toggleFavorit(int id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
        _snack('Dihapus dari favorit', AppColors.textGrey);
      } else {
        _favorites.add(id);
        _snack('❤️ Ditambahkan ke favorit!', AppColors.danger);
      }
    });
  }

  void _snack(String msg, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    ));
  }

  @override
  Widget build(BuildContext context) {
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
          Text('Daftar Guru',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Text('Temukan guru terbaikmu 🎓',
              style: TextStyle(fontSize: 11, color: Colors.white70)),
        ]),
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, Color(0xFF1D4ED8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '  Cari nama guru atau mata pelajaran...',
                hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6), fontSize: 14),
                prefixIcon: Icon(Icons.search_rounded,
                    color: Colors.white.withValues(alpha: 0.8)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.white70),
                        onPressed: () => setState(() => _searchQuery = ''))
                    : null,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 1.5)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // Filter chips
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: kategoriFilter.map((kat) {
                  final isSel = _selectedKategori == kat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedKategori = kat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              isSel ? AppColors.primary : AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color:
                                  isSel ? AppColors.primary : AppColors.border),
                        ),
                        child: Text(kat,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                    isSel ? FontWeight.bold : FontWeight.normal,
                                color:
                                    isSel ? Colors.white : AppColors.textGrey)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Jumlah hasil
          Container(
            color: AppColors.background,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(children: [
              const Icon(Icons.people_outline_rounded,
                  size: 16, color: AppColors.textGrey),
              const SizedBox(width: 6),
              Text('${_filteredGuru.length} guru ditemukan',
                  style: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              if (_favorites.isNotEmpty) ...[
                const Spacer(),
                const Icon(Icons.favorite_rounded,
                    size: 14, color: AppColors.danger),
                const SizedBox(width: 4),
                Text('${_favorites.length} favorit',
                    style: const TextStyle(
                        color: AppColors.danger,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ],
            ]),
          ),

          Expanded(
            child: _filteredGuru.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: _filteredGuru.length,
                    itemBuilder: (ctx, i) => _buildCard(ctx, _filteredGuru[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
              color: AppColors.surfaceAlt, shape: BoxShape.circle),
          child: const Text('🔍', style: TextStyle(fontSize: 52)),
        ),
        const SizedBox(height: 20),
        const Text('Guru tidak ditemukan',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textMid)),
        const SizedBox(height: 8),
        Text(
            _searchQuery.isNotEmpty
                ? 'Coba kata kunci lain atau ganti filter'
                : 'Belum ada guru di kategori ini',
            style: const TextStyle(fontSize: 13, color: AppColors.textGrey)),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Reset Filter'),
          onPressed: () => setState(() {
            _searchQuery = '';
            _selectedKategori = 'Semua';
          }),
        ),
      ]),
    );
  }

  Widget _buildCard(BuildContext context, Guru guru) {
    final color =
        AppColors.avatarColors[guru.id % AppColors.avatarColors.length];
    final isFav = _favorites.contains(guru.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
              color: AppColors.primaryDeep.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => DetailGuruScreen(guru: guru))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              // Avatar + badge rating
              Stack(children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [color, color.withValues(alpha: 0.75)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: color.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(guru.foto,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 1.5)),
                      child: Text('⭐${guru.rating}',
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )),
              ]),
              const SizedBox(width: 14),

              // Info guru
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                            child: Text(guru.nama,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.textDark),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)),
                        // Favorit
                        GestureDetector(
                          onTap: () => _toggleFavorit(guru.id),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: Icon(
                                isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                key: ValueKey(isFav),
                                color: isFav
                                    ? AppColors.danger
                                    : AppColors.textLight,
                                size: 22),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: color.withValues(alpha: 0.2))),
                        child: Text(guru.mataPelajaran,
                            style: TextStyle(
                                fontSize: 11,
                                color: color,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 7),
                      Row(children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: AppColors.textLight),
                        const SizedBox(width: 2),
                        Text(guru.lokasi,
                            style: const TextStyle(
                                fontSize: 11, color: AppColors.textGrey)),
                        const SizedBox(width: 10),
                        const Icon(Icons.people_outline,
                            size: 12, color: AppColors.textLight),
                        const SizedBox(width: 2),
                        Text('${guru.jumlahSiswa} siswa',
                            style: const TextStyle(
                                fontSize: 11, color: AppColors.textGrey)),
                      ]),
                      const SizedBox(height: 7),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rp ${_fmt(guru.hargaPerSesi)}/sesi',
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.success,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text('Lihat',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ]),
                    ]),
              ),
            ]),
          ),
        ),
      ),
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
