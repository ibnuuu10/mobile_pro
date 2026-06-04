import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'main_screen.dart';
import 'register_screen.dart';
import '../utils/animated_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPassVisible = false;
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 1500));
      setState(() => _isLoading = false);
      if (mounted) {
        await showSuccessDialog(
          context: context,
          title: 'Login Berhasil!',
          subtitle: 'Selamat datang kembali.\nSiap belajar hari ini? 🚀',
          onDone: () => Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
            (route) => false),
        );
      }
    }
  }

  @override
  void dispose() { _emailCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Header banner navy ───────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(28, 52, 28, 36),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryDeep, AppColors.primaryDark, Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                      ),
                      child: const Icon(Icons.school_rounded, size: 42, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text('Selamat Datang! 👋',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 6),
                    Text('Masuk dan mulai belajar bersama guru terbaik',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8))),
                  ],
                ),
              ),

              // ── Form ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _label('Email'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: AppColors.textDark),
                        decoration: const InputDecoration(
                          hintText: 'contoh@email.com',
                          prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Email tidak boleh kosong';
                          if (!v.contains('@')) return 'Format email tidak valid';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _label('Password'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: !_isPassVisible,
                        style: const TextStyle(color: AppColors.textDark),
                        decoration: InputDecoration(
                          hintText: 'Masukkan password',
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                          suffixIcon: IconButton(
                            icon: Icon(_isPassVisible ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.textGrey),
                            onPressed: () => setState(() => _isPassVisible = !_isPassVisible),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Password tidak boleh kosong';
                          if (v.length < 6) return 'Password minimal 6 karakter';
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // Tombol Masuk
                      SizedBox(
                        width: double.infinity, height: 54,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          child: _isLoading
                            ? const SizedBox(width: 22, height: 22,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                            : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(Icons.login_rounded, color: Colors.white),
                                SizedBox(width: 8),
                                Text('Masuk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Row(children: [
                        const Expanded(child: Divider(color: AppColors.border)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('atau', style: TextStyle(color: AppColors.textGrey)),
                        ),
                        const Expanded(child: Divider(color: AppColors.border)),
                      ]),
                      const SizedBox(height: 20),

                      // Tombol Daftar
                      SizedBox(
                        width: double.infinity, height: 54,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.person_add_rounded, color: AppColors.primary),
                          label: const Text('Buat Akun Baru'),
                          onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const RegisterScreen())),
                        ),
                      ),
                      const SizedBox(height: 24),
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

  Widget _label(String text) => Text(text,
    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark));
}
