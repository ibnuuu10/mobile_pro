import 'package:flutter/material.dart';
import '../models/guru.dart';
import '../models/paket_les.dart';
import '../data/dummy_data.dart';
import '../models/jadwal_les.dart';
import '../utils/app_theme.dart';
import 'jadwal_les_screen.dart';

class PembayaranScreen extends StatefulWidget {
  final Guru guru;
  final PaketLes paket;
  final int totalHarga;
  const PembayaranScreen(
      {super.key,
      required this.guru,
      required this.paket,
      required this.totalHarga});
  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen>
    with SingleTickerProviderStateMixin {
  String _metode = 'Transfer Bank';
  bool _isProses = false;
  late AnimationController _loadingCtrl;

  final List<Map<String, dynamic>> _metodeList = [
    {
      'nama': 'Transfer Bank',
      'icon': Icons.account_balance_rounded,
      'color': AppColors.primaryDark
    },
    {
      'nama': 'GoPay',
      'icon': Icons.motorcycle_rounded,
      'color': Color(0xFF00897B)
    },
    {'nama': 'OVO', 'icon': Icons.wallet_rounded, 'color': Color(0xFF7C3AED)},
    {
      'nama': 'Dana',
      'icon': Icons.phonelink_rounded,
      'color': AppColors.primary
    },
    {
      'nama': 'QRIS',
      'icon': Icons.qr_code_rounded,
      'color': AppColors.textDark
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadingCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
  }

  @override
  void dispose() {
    _loadingCtrl.dispose();
    super.dispose();
  }

  void _prosesBayar() async {
    setState(() => _isProses = true);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(children: [
        SizedBox(
            width: 20,
            height: 20,
            child:
                CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
        SizedBox(width: 12),
        Text('Memproses pembayaran...'),
      ]),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      backgroundColor: AppColors.primaryDark,
    ));
    await Future.delayed(const Duration(seconds: 2));
    final hariOpts = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    final hariIndex = DateTime.now().weekday % hariOpts.length;
    daftarJadwal.add(JadwalLes(
        namaGuru: widget.guru.nama,
        mataPelajaran: widget.guru.mataPelajaran,
        hari: hariOpts[hariIndex],
        jam: '16:00 - 18:00',
        status: 'Terjadwal',
        lokasi: widget.guru.lokasi));
    setState(() => _isProses = false);
    if (mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => _SuksesScreen(
                  guru: widget.guru,
                  paket: widget.paket,
                  totalHarga: widget.totalHarga)),
          (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Pembayaran'),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.primaryDeep, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight))),
      ),
      bottomNavigationBar: _buildBottomBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _sectionTitle('📋 Ringkasan Pesanan'),
          const SizedBox(height: 12),
          _buildRingkasanCard(),
          const SizedBox(height: 22),
          _sectionTitle('💳 Metode Pembayaran'),
          const SizedBox(height: 12),
          ..._metodeList.map((m) => _buildMetodeCard(m)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3))),
            child: const Row(children: [
              Icon(Icons.security_rounded, color: AppColors.success, size: 20),
              SizedBox(width: 10),
              Expanded(
                  child: Text('Transaksi aman & terenkripsi 🔒',
                      style:
                          TextStyle(fontSize: 12, color: AppColors.success))),
            ]),
          ),
          const SizedBox(height: 100),
        ]),
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Text(t,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textMid)),
      );

  Widget _buildRingkasanCard() {
    final diskon = (widget.guru.hargaPerSesi * widget.paket.jumlahPertemuan -
            widget.totalHarga)
        .abs();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border)),
      child: Column(children: [
        Row(children: [
          Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  color: AppColors.primaryDark, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(widget.guru.foto,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.guru.nama,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark)),
            Text(widget.guru.mataPelajaran,
                style:
                    const TextStyle(fontSize: 12, color: AppColors.textGrey)),
            Text(widget.paket.nama,
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
          ]),
        ]),
        const Divider(height: 20),
        _row('Harga/Sesi', 'Rp ${_fmt(widget.guru.hargaPerSesi)}'),
        _row('Jumlah Sesi', '${widget.paket.jumlahPertemuan}x'),
        _row('Subtotal',
            'Rp ${_fmt(widget.guru.hargaPerSesi * widget.paket.jumlahPertemuan)}'),
        if (diskon > 0)
          _row('Diskon', '- Rp ${_fmt(diskon)}', valueColor: AppColors.success),
        const Divider(height: 16),
        _row('Total', 'Rp ${_fmt(widget.totalHarga)}',
            bold: true, valueColor: AppColors.primary, fontSize: 16),
      ]),
    );
  }

  Widget _row(String label, String val,
          {bool bold = false, Color? valueColor, double fontSize = 13}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: TextStyle(fontSize: fontSize, color: AppColors.textGrey)),
          Text(val,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                  color: valueColor ?? AppColors.textDark)),
        ]),
      );

  Widget _buildMetodeCard(Map<String, dynamic> m) {
    final isSel = _metode == m['nama'];
    final color = m['color'] as Color;
    return GestureDetector(
      onTap: () => setState(() => _metode = m['nama']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
            color: isSel ? AppColors.surfaceAlt : AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: isSel ? AppColors.primary : AppColors.border,
                width: isSel ? 2 : 1)),
        child: Row(children: [
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: isSel
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(m['icon'] as IconData,
                  color: isSel ? AppColors.primary : AppColors.textGrey,
                  size: 20)),
          const SizedBox(width: 12),
          Text(m['nama'] as String,
              style: TextStyle(
                  fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                  color: isSel ? AppColors.primary : AppColors.textDark,
                  fontSize: 14)),
          const Spacer(),
          if (isSel)
            const Icon(Icons.check_circle_rounded,
                color: AppColors.primary, size: 22),
        ]),
      ),
    );
  }

  Widget _buildBottomBar() => Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
            color: AppColors.surface,
            border: const Border(top: BorderSide(color: AppColors.border)),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Total Pembayaran',
                style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
            Text('Rp ${_fmt(widget.totalHarga)}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
          ]),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              icon: _isProses
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2.5))
                  : const Icon(Icons.lock_rounded, size: 18),
              label: Text(_isProses ? 'Memproses...' : '🔒 Bayar Sekarang'),
              onPressed: _isProses ? null : _prosesBayar,
            ),
          ),
        ]),
      );

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

// ── Sukses Screen ─────────────────────────────────────────────
class _SuksesScreen extends StatefulWidget {
  final Guru guru;
  final PaketLes paket;
  final int totalHarga;
  const _SuksesScreen(
      {required this.guru, required this.paket, required this.totalHarga});
  @override
  State<_SuksesScreen> createState() => _SuksesScreenState();
}

class _SuksesScreenState extends State<_SuksesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim, _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _scaleAnim = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(children: [
          Icon(Icons.check_circle_rounded, color: Colors.white),
          SizedBox(width: 10),
          Text('✅ Berhasil memesan les! Jadwal sudah ditambahkan.',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ]),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 4),
      ));
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              const SizedBox(height: 40),
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [AppColors.success, Color(0xFF4ADE80)]),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.success.withValues(alpha: 0.35),
                              blurRadius: 24,
                              offset: const Offset(0, 8))
                        ]),
                    child: const Icon(Icons.check_rounded,
                        size: 64, color: Colors.white)),
              ),
              const SizedBox(height: 24),
              const Text('Pembayaran Berhasil! 🎉',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMid),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                  'Les dengan ${widget.guru.nama} telah terjadwal.\nSelamat belajar!',
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.textGrey, height: 1.5),
                  textAlign: TextAlign.center),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border)),
                child: Column(children: [
                  const Text('Detail Pesanan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.textMid)),
                  const Divider(height: 20),
                  _drow('👨‍🏫 Guru', widget.guru.nama),
                  _drow('📚 Mata Pelajaran', widget.guru.mataPelajaran),
                  _drow('📦 Paket', widget.paket.nama),
                  _drow('🔢 Pertemuan', '${widget.paket.jumlahPertemuan}x'),
                  const Divider(height: 16),
                  _drow('💰 Total Bayar', 'Rp ${_fmt(widget.totalHarga)}',
                      bold: true, valueColor: AppColors.primary),
                ]),
              ),
              const SizedBox(height: 32),
              SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_month_rounded),
                    label: const Text('Lihat Jadwal Les'),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const JadwalLesScreen()),
                        (route) => route.isFirst),
                  )),
              const SizedBox(height: 12),
              SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('Kembali ke Beranda'),
                    onPressed: () =>
                        Navigator.popUntil(context, (r) => r.isFirst),
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _drow(String label, String value,
          {bool bold = false, Color? valueColor}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: AppColors.textGrey)),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w600,
                  color: valueColor ?? AppColors.textDark)),
        ]),
      );
}
