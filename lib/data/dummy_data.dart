import '../models/guru.dart';
import '../models/jadwal_les.dart';
import '../models/paket_les.dart';

// ============================================================
// DATA DUMMY - Seluruh data statis aplikasi Anak Pintar
// PERUBAHAN: Tambah field 'kategori' & 'jumlahSiswa' di setiap guru
// ============================================================

// Kategori filter yang tersedia (dipakai di DaftarGuruScreen)
const List<String> kategoriFilter = [
  'Semua',
  'Matematika',
  'Sains',
  'Bahasa',
  'Teknologi',
];

final List<Guru> daftarGuru = [
  const Guru(
    id: 1,
    nama: 'Budi Santoso, S.Pd',
    mataPelajaran: 'Matematika',
    kategori: 'Matematika',
    rating: 4.9,
    foto: 'BS',
    lokasi: 'Jakarta Selatan',
    hargaPerSesi: 150000,
    jumlahSiswa: 142,
    deskripsi:
        'Lulusan S1 Pendidikan Matematika Universitas Indonesia. Berpengalaman lebih dari 8 tahun mengajar matematika untuk tingkat SD, SMP, dan SMA. Metode mengajar santai namun efektif, membuat siswa mudah memahami konsep yang sulit.',
  ),
  const Guru(
    id: 2,
    nama: 'Sari Dewi, M.Sc',
    mataPelajaran: 'Fisika & Kimia',
    kategori: 'Sains',
    rating: 4.8,
    foto: 'SD',
    lokasi: 'Jakarta Barat',
    hargaPerSesi: 175000,
    jumlahSiswa: 98,
    deskripsi:
        'Lulusan S2 Fisika ITB. Spesialis pelajaran IPA untuk SMP dan SMA. Menggunakan pendekatan eksperimen sederhana yang menyenangkan agar siswa mudah memahami materi sains secara mendalam.',
  ),
  const Guru(
    id: 3,
    nama: 'Andi Prasetyo, S.S',
    mataPelajaran: 'Bahasa Inggris',
    kategori: 'Bahasa',
    rating: 4.7,
    foto: 'AP',
    lokasi: 'Jakarta Pusat',
    hargaPerSesi: 130000,
    jumlahSiswa: 215,
    deskripsi:
        'Certified TEFL/TESOL teacher dengan pengalaman 5 tahun. Lulusan Sastra Inggris UI. Fokus pada kemampuan speaking, reading, dan grammar. Cocok untuk persiapan ujian TOEFL, IELTS, dan ujian sekolah.',
  ),
  const Guru(
    id: 4,
    nama: 'Rina Lestari, S.Pd',
    mataPelajaran: 'Bahasa Indonesia',
    kategori: 'Bahasa',
    rating: 4.6,
    foto: 'RL',
    lokasi: 'Jakarta Timur',
    hargaPerSesi: 120000,
    jumlahSiswa: 87,
    deskripsi:
        'Guru berpengalaman 6 tahun dalam bidang Bahasa Indonesia. Ahli dalam menulis esai, analisis sastra, dan persiapan UN/UTBK. Metode pengajaran kreatif melalui storytelling dan diskusi.',
  ),
  const Guru(
    id: 5,
    nama: 'Hendra Wijaya, S.Kom',
    mataPelajaran: 'Informatika & Coding',
    kategori: 'Teknologi',
    rating: 4.9,
    foto: 'HW',
    lokasi: 'Jakarta Utara',
    hargaPerSesi: 200000,
    jumlahSiswa: 176,
    deskripsi:
        'Software Engineer dengan 7 tahun pengalaman industri. Mengajar pemrograman dasar Python, Java, dan web development untuk pelajar SMP hingga mahasiswa. Kurikulum disesuaikan dengan kebutuhan siswa.',
  ),
  const Guru(
    id: 6,
    nama: 'Maya Kusuma, S.Pd',
    mataPelajaran: 'Biologi',
    kategori: 'Sains',
    rating: 4.5,
    foto: 'MK',
    lokasi: 'Depok',
    hargaPerSesi: 125000,
    jumlahSiswa: 63,
    deskripsi:
        'Lulusan Pendidikan Biologi UNESA. Berpengalaman 4 tahun mengajar biologi SMP dan SMA. Menggunakan media visual dan infografis yang menarik untuk memudahkan pemahaman siswa.',
  ),
];

final List<PaketLes> daftarPaket = [
  const PaketLes(
    nama: 'Paket Coba',
    jumlahPertemuan: 1,
    hargaTotal: 0,
    deskripsi: 'Cocok untuk kenalan dan uji coba',
  ),
  const PaketLes(
    nama: 'Paket Bulanan',
    jumlahPertemuan: 4,
    hargaTotal: 0,
    deskripsi: '4x pertemuan dalam sebulan, hemat 10%',
  ),
  const PaketLes(
    nama: 'Paket Intensif',
    jumlahPertemuan: 8,
    hargaTotal: 0,
    deskripsi: '8x pertemuan, hemat 15%',
  ),
  const PaketLes(
    nama: 'Paket Reguler',
    jumlahPertemuan: 12,
    hargaTotal: 0,
    deskripsi: '12x pertemuan, hemat 20%',
  ),
];

const Map<int, double> diskonPaket = {
  1: 0.0,
  4: 0.10,
  8: 0.15,
  12: 0.20,
};

// PERUBAHAN: daftarJadwal dijadikan mutable List agar bisa ditambah saat pemesanan
List<JadwalLes> daftarJadwal = [
  const JadwalLes(
    namaGuru: 'Budi Santoso, S.Pd',
    mataPelajaran: 'Matematika',
    hari: 'Senin',
    jam: '15:00 - 17:00',
    status: 'Terjadwal',
    lokasi: 'Jakarta Selatan',
  ),
  const JadwalLes(
    namaGuru: 'Sari Dewi, M.Sc',
    mataPelajaran: 'Fisika',
    hari: 'Rabu',
    jam: '16:00 - 18:00',
    status: 'Terjadwal',
    lokasi: 'Jakarta Barat',
  ),
  const JadwalLes(
    namaGuru: 'Andi Prasetyo, S.S',
    mataPelajaran: 'Bahasa Inggris',
    hari: 'Jumat',
    jam: '14:00 - 16:00',
    status: 'Selesai',
    lokasi: 'Jakarta Pusat',
  ),
];
