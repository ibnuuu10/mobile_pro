import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/guru.dart';
import '../models/paket_les.dart';
import '../utils/app_theme.dart';
import 'pembayaran_screen.dart';
import '../utils/helpers.dart';

class PilihPaketScreen extends StatefulWidget {
  final Guru guru;
  const PilihPaketScreen({super.key, required this.guru});
  @override
  State<PilihPaketScreen> createState() => _PilihPaketScreenState();
}

class _PilihPaketScreenState extends State<PilihPaketScreen> {
  int _selectedIndex = 0;
  bool _isLoading = false;

  int _hitungHarga() => _hitungHargaPaket(daftarPaket[_selectedIndex]);
  int _hitungHargaPaket(PaketLes p) {
    final d = diskonPaket[p.jumlahPertemuan] ?? 0;
    return (widget.guru.hargaPerSesi * p.jumlahPertemuan * (1 - d)).toInt();
  }

  void _lanjutPembayaran() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isLoading = false);
    if (mounted) {
      showInfoSnackbar(context, 'Paket dipilih, lanjut ke pembayaran 💳');
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => PembayaranScreen(
          guru: widget.guru,
          paket: daftarPaket[_selectedIndex],
          totalHarga: _hitungHarga(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pilih Paket Les'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context)),
      ),
      bottomNavigationBar: _buildBottomBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildGuruInfo(),
          const SizedBox(height: 20),
          const Row(children: [
            Icon(Icons.local_offer_rounded, color: AppColors.primary, size: 20),
            SizedBox(width: 8),
            Text('Pilih Paket Les',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ]),
          const SizedBox(height: 6),
          const Text('Semakin banyak pertemuan, semakin hemat!',
            style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
          const SizedBox(height: 16),
          ...daftarPaket.asMap().entries.map((e) {
            final isSelected = _selectedIndex == e.key;
            final harga = _hitungHargaPaket(e.value);
            final diskon = diskonPaket[e.value.jumlahPertemuan] ?? 0;
            return _buildPaketCard(e.value, harga, diskon, isSelected,
              () => setState(() => _selectedIndex = e.key));
          }),
        ]),
      ),
    );
  }

  Widget _buildGuruInfo() {
    final color = AppColors.avatarColors[widget.guru.id % AppColors.avatarColors.length];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(children: [
        CircleAvatar(backgroundColor: color, radius: 24,
          child: Text(widget.guru.foto,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14))),
        const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.guru.nama,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
          Text(widget.guru.mataPelajaran,
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
          Text('Rp ${formatHarga(widget.guru.hargaPerSesi)}/sesi',
            style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
        ]),
      ]),
    );
  }

  Widget _buildPaketCard(PaketLes paket, int harga, double diskon,
      bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceAlt : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1),
        ),
        child: Row(children: [
          // Radio custom
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24, height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.textLight, width: 2),
              color: isSelected ? AppColors.primary : Colors.transparent),
            child: isSelected
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 15)
              : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(paket.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
                if (diskon > 0) ...[ const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.danger, borderRadius: BorderRadius.circular(6)),
                    child: Text('Hemat ${(diskon * 100).toInt()}%',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                ],
              ]),
              const SizedBox(height: 3),
              Text('${paket.jumlahPertemuan}x pertemuan • ${paket.deskripsi}',
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            if (diskon > 0)
              Text('Rp ${formatHarga(widget.guru.hargaPerSesi * paket.jumlahPertemuan)}',
                style: const TextStyle(fontSize: 11, color: AppColors.textLight,
                  decoration: TextDecoration.lineThrough)),
            Text('Rp ${formatHarga(harga)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,
                color: isSelected ? AppColors.primary : AppColors.textDark)),
          ]),
        ]),
      ),
    );
  }

  Widget _buildBottomBar() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: const Border(top: BorderSide(color: AppColors.border)),
    ),
    child: SafeArea(
      child: Row(children: [
        Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Total Harga:', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
          Text('Rp ${formatHarga(_hitungHarga())}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ]),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              icon: _isLoading
                ? const SizedBox(width: 18, height: 18,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Icon(Icons.payment_rounded),
              label: Text(_isLoading ? 'Memuat...' : 'Lanjut Bayar'),
              onPressed: _isLoading ? null : _lanjutPembayaran,
            ),
          ),
        ),
      ]),
    ),
  );
}
