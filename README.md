# Anak Pintar 📚

Platform pencarian guru les privat — Tugas Mobile Programming Flutter.

## Cara Jalankan

```bash
flutter pub get
flutter run
```

## Struktur lib/

```
lib/
├── main.dart                   # Entry point & tema aplikasi
├── data/
│   └── dummy_data.dart         # Data statis (guru, paket, jadwal)
├── models/
│   ├── guru.dart
│   ├── paket_les.dart
│   └── jadwal_les.dart
└── screens/
    ├── splash_screen.dart      # Splash otomatis 3 detik
    ├── login_screen.dart       # Form login simulasi
    ├── register_screen.dart    # Form register simulasi
    ├── home_screen.dart        # Dashboard menu utama
    ├── daftar_guru_screen.dart # List + search guru
    ├── detail_guru_screen.dart # Profil lengkap guru
    ├── pilih_paket_screen.dart # Paket les & kalkulasi harga
    ├── pembayaran_screen.dart  # Simulasi pembayaran
    └── jadwal_les_screen.dart  # Jadwal aktif & riwayat
```
