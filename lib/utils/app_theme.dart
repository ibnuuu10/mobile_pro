import 'package:flutter/material.dart';

// ============================================================
// APP COLORS — Palet warna navy konsisten seluruh aplikasi
// Primary/Navy : #0F172A  (teks utama, elemen bold)
// Secondary    : #1E3A8A  (komponen biru gelap)
// Accent       : #2563EB  (tombol, highlight, icon aktif)
// Background   : #F8FAFC  (scaffold background)
// Card/Surface : #FFFFFF  (card, input field)
// Text primer  : #0F172A
// Text sekunder: #64748B
// ============================================================
class AppColors {
  // ── Core Brand ─────────────────────────────────────────────
  static const Color primary      = Color(0xFF2563EB); // accent blue — tombol, chip aktif, icon
  static const Color primaryDark  = Color(0xFF1E3A8A); // secondary blue — AppBar, banner
  static const Color primaryDeep  = Color(0xFF0F172A); // navy — teks utama, elemen bold
  static const Color primaryLight = Color(0xFF3B82F6); // medium blue — hover/gradient

  // ── Background & Surface ───────────────────────────────────
  static const Color background   = Color(0xFFF8FAFC); // scaffold bg
  static const Color surface      = Color(0xFFFFFFFF); // card, input
  static const Color surfaceAlt   = Color(0xFFEFF6FF); // biru sangat muda — chip bg, banner tint
  static const Color border       = Color(0xFFDBEAFE); // border biru muda

  // ── Text ───────────────────────────────────────────────────
  static const Color textDark     = Color(0xFF0F172A); // teks utama
  static const Color textMid      = Color(0xFF1E3A8A); // heading section, label penting
  static const Color textGrey     = Color(0xFF64748B); // teks sekunder
  static const Color textLight    = Color(0xFF94A3B8); // placeholder, hint

  // ── Status ─────────────────────────────────────────────────
  static const Color success      = Color(0xFF16A34A); // hijau sukses
  static const Color successLight = Color(0xFFDCFCE7); // bg sukses
  static const Color warning      = Color(0xFFD97706); // amber warning
  static const Color warningLight = Color(0xFFFEF3C7); // bg warning
  static const Color danger       = Color(0xFFDC2626); // merah error/favorit
  static const Color secondary    = Color(0xFFD97706); // amber aksen (badge, CTA sekunder)

  // ── Avatar warna per guru ──────────────────────────────────
  static const List<Color> avatarColors = [
    Color(0xFF2563EB), // biru
    Color(0xFF7C3AED), // ungu
    Color(0xFF059669), // hijau
    Color(0xFFD97706), // amber
    Color(0xFF0891B2), // cyan
    Color(0xFFDC2626), // merah
  ];
}
