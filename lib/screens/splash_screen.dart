import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _starsController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _slideAnim;
  late Animation<double> _starsAnim;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1400), vsync: this);
    _starsController = AnimationController(
      duration: const Duration(milliseconds: 1800), vsync: this)
      ..repeat(reverse: true);

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn)));
    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController,
          curve: const Interval(0.0, 0.7, curve: Curves.elasticOut)));
    _slideAnim = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: _logoController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));
    _starsAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _starsController, curve: Curves.easeInOut));

    _logoController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _starsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryDeep,  // #0F172A navy
              AppColors.primaryDark,  // #1E3A8A
              Color(0xFF1D4ED8),      // biru medium
            ],
          ),
        ),
        child: Stack(
          children: [
            // Lingkaran dekoratif kanan atas
            Positioned(
              top: -80, right: -80,
              child: AnimatedBuilder(
                animation: _starsAnim,
                builder: (_, __) => Opacity(
                  opacity: _starsAnim.value * 0.08,
                  child: Container(width: 300, height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle)),
                ),
              ),
            ),
            // Lingkaran dekoratif kiri bawah
            Positioned(
              bottom: -120, left: -60,
              child: AnimatedBuilder(
                animation: _starsAnim,
                builder: (_, __) => Opacity(
                  opacity: (1 - _starsAnim.value) * 0.06,
                  child: Container(width: 280, height: 280,
                    decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle)),
                ),
              ),
            ),
            // Bintang-bintang kecil
            ..._buildFloatingStars(),
            // Konten utama
            Center(
              child: AnimatedBuilder(
                animation: _logoController,
                builder: (_, __) => FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Container(
                          width: 130, height: 130,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: AppColors.secondary.withValues(alpha: 0.45),
                                blurRadius: 30, offset: const Offset(0, 10)),
                              BoxShadow(color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 20, offset: const Offset(0, 6)),
                            ],
                          ),
                          child: const Icon(Icons.school_rounded, size: 70, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: const Text('Anak Pintar',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900,
                            color: Colors.white, letterSpacing: 2,
                            shadows: [Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))])),
                      ),
                      const SizedBox(height: 8),
                      Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                          ),
                          child: Text('🎓 Platform Les Privat Terpercaya',
                            style: TextStyle(fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.9), letterSpacing: 0.5)),
                        ),
                      ),
                      const SizedBox(height: 70),
                      _buildLoadingDots(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFloatingStars() {
    final positions = [
      const Offset(40, 120), const Offset(320, 80), const Offset(80, 400),
      const Offset(340, 350), const Offset(160, 650), const Offset(280, 580),
    ];
    final sizes = [16.0, 12.0, 18.0, 14.0, 10.0, 16.0];
    return List.generate(positions.length, (i) => Positioned(
      left: positions[i].dx, top: positions[i].dy,
      child: AnimatedBuilder(animation: _starsAnim,
        builder: (_, __) => Opacity(
          opacity: i.isEven ? _starsAnim.value * 0.5 : (1 - _starsAnim.value) * 0.5,
          child: Icon(Icons.star_rounded, color: AppColors.secondary, size: sizes[i]))),
    ));
  }

  Widget _buildLoadingDots() {
    return AnimatedBuilder(
      animation: _starsController,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          final delay = i * 0.33;
          final value = (_starsController.value - delay).clamp(0.0, 1.0);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8 + value * 4, height: 8 + value * 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4 + value * 0.6),
              shape: BoxShape.circle),
          );
        }),
      ),
    );
  }
}
