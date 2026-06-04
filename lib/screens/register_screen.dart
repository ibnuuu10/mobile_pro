import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'main_screen.dart';
import '../utils/animated_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _konfCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPassVisible = false;
  bool _isKonfVisible = false;

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 1500));
      setState(() => _isLoading = false);
      if (mounted) {
        await showSuccessDialog(
          context: context,
          title: 'Registrasi Berhasil!',
          subtitle: 'Akun kamu sudah dibuat.\nSelamat belajar bersama kami! 🎉',
          onDone: () => Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
            (route) => false),
        );
      }
    }
  }

  @override
  void dispose() {
    _namaCtrl.dispose(); _emailCtrl.dispose();
    _passCtrl.dispose(); _konfCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint, IconData icon, {Widget? suffix}) =>
    InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary),
      suffixIcon: suffix,
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Daftar Akun'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(14),
                    border: const Border(left: BorderSide(color: AppColors.primary, width: 4)),
                  ),
                  child: const Row(children: [
                    Icon(Icons.person_add_rounded, color: AppColors.primary, size: 26),
                    SizedBox(width: 12),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Buat Akun Baru',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      Text('Isi data diri untuk mulai belajar',
                        style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                    ]),
                  ]),
                ),
                const SizedBox(height: 24),

                _label('Nama Lengkap'), const SizedBox(height: 8),
                TextFormField(
                  controller: _namaCtrl,
                  style: const TextStyle(color: AppColors.textDark),
                  decoration: _dec('Nama lengkap kamu', Icons.person_outline),
                  validator: (v) => (v == null || v.isEmpty) ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),

                _label('Email'), const SizedBox(height: 8),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: AppColors.textDark),
                  decoration: _dec('contoh@email.com', Icons.email_outlined),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email tidak boleh kosong';
                    if (!v.contains('@')) return 'Format email tidak valid';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _label('Password'), const SizedBox(height: 8),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: !_isPassVisible,
                  style: const TextStyle(color: AppColors.textDark),
                  decoration: _dec('Minimal 6 karakter', Icons.lock_outline,
                    suffix: IconButton(
                      icon: Icon(_isPassVisible ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textGrey),
                      onPressed: () => setState(() => _isPassVisible = !_isPassVisible),
                    )),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password tidak boleh kosong';
                    if (v.length < 6) return 'Password minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _label('Konfirmasi Password'), const SizedBox(height: 8),
                TextFormField(
                  controller: _konfCtrl,
                  obscureText: !_isKonfVisible,
                  style: const TextStyle(color: AppColors.textDark),
                  decoration: _dec('Ulangi password', Icons.lock_outline,
                    suffix: IconButton(
                      icon: Icon(_isKonfVisible ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textGrey),
                      onPressed: () => setState(() => _isKonfVisible = !_isKonfVisible),
                    )),
                  validator: (v) => v != _passCtrl.text ? 'Password tidak cocok' : null,
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity, height: 54,
                  child: ElevatedButton.icon(
                    icon: _isLoading
                      ? const SizedBox(width: 20, height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.how_to_reg_rounded),
                    label: Text(_isLoading ? 'Mendaftarkan...' : 'Daftar Sekarang'),
                    onPressed: _isLoading ? null : _handleRegister,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text,
    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark));
}
