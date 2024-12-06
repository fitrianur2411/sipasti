import 'package:flutter/material.dart';

class Rekomendasidetailpage extends StatelessWidget {
  const Rekomendasidetailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Informasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
        leading: IconButton(
           icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, 
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Header
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/Rekomendasi.png',
                height: 350,
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Judul Program
            Center(
              child: Text(
                'Program Non-Degree Peningkatan Kompetensi Dosen Vokasi 2024',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 6, 90, 151),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Subjudul
            const Text(
              'Tentang Program Ini',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:  Color.fromARGB(255, 6, 90, 151),
              ),
            ),
            const SizedBox(height: 8),

            // Deskripsi Program
            const Text(
              'Program Non Degree Peningkatan Kompetensi Dosen (Program-NDPKD) '
              'merupakan program yang mendorong dan memfasilitasi pendidikan '
              'tinggi vokasi membangun ekosistem dalam menyiapkan SDM menyongsong '
              'Indonesia Emas 2045, melalui pelatihan dan sertifikasi kompetensi, '
              'profesi, dan industri serta peningkatan tata kelola pendidikan tinggi melalui '
              'pelatihan industri (magang) pada industri dan perguruan tinggi luar negeri yang '
              'bereputasi global. Upaya fasilitasi tersebut adalah bentuk komitmen pemerintah '
              'membangun SDM Indonesia yang Unggul, Berbudaya dan Menguasai Ilmu Pengetahuan '
              'dan Teknologi.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),

            // Tombol Daftar Sekarang
            Center(
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 90, 151),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  'Daftar Sekarang',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
