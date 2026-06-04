// Model data Guru Les
// PERUBAHAN: Tambah field 'kategori' untuk fitur filter mata pelajaran
class Guru {
  final int id;
  final String nama;
  final String mataPelajaran;
  final String kategori; // ← BARU: untuk filter (Matematika, Bahasa, Sains, dll)
  final double rating;
  final String deskripsi;
  final String foto;
  final String lokasi;
  final int hargaPerSesi;
  final int jumlahSiswa; // ← BARU: untuk info tambahan di card

  const Guru({
    required this.id,
    required this.nama,
    required this.mataPelajaran,
    required this.kategori,
    required this.rating,
    required this.deskripsi,
    required this.foto,
    required this.lokasi,
    required this.hargaPerSesi,
    required this.jumlahSiswa,
  });
}
