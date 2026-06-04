// Model data untuk Jadwal Les
class JadwalLes {
  final String namaGuru;
  final String mataPelajaran;
  final String hari;
  final String jam;
  final String status;
  final String lokasi;

  const JadwalLes({
    required this.namaGuru,
    required this.mataPelajaran,
    required this.hari,
    required this.jam,
    required this.status,
    required this.lokasi,
  });
}
