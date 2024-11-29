import 'package:flutter/material.dart';
import 'package:sipasti/Pimpinan/SertifikasiListPage.dart';
import 'PelatihanListPage.dart';
import 'SertifikasiListPage.dart';
import 'PendataanPage.dart';
import 'ProfilePage.dart';
import 'notification_page.dart';
import 'rekomendasidetalpage.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Current index untuk navigasi

  // Fungsi untuk navigasi BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PendataanPage(
            onBackToHome: () {
              setState(() {
                _selectedIndex = 0; // Kembali ke Home
              });
            },
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationPage(
            onBackToHome: () {
              setState(() {
                _selectedIndex = 0; // Kembali ke ikon Home
              });
            },
          ),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            onBackToHome: () {
              setState(() {
                _selectedIndex = 0; // Kembali ke Home
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo_JTIpolinema.png', height: 40),
            const SizedBox(width: 10),
          ],
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
      ),
      body: _selectedIndex == 0
          ? Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF3F4F6), // Light grey background
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'SIPaSTI',
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 18, 78, 120),
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Sistem Informasi Pelatihan & Sertifikasi Jurusan Teknologi Informasi',
                    style: TextStyle(fontSize: 14, color: Color(0xFF4D4D4D)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Rekomendasi Pelatihan & Sertifikasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 18, 78, 120),
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildRecommendationCard(context),

                  // Pelatihan Section
                  const SizedBox(height: 20),
                  const Text(
                    'Pelatihan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 18, 78, 120),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: buildTrainingCard(
                          title: 'Pelatihan Digitalis Data',
                          subtitle: 'UNS',
                          image: 'assets/pelatihan_1.png',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildTrainingCard(
                          title: 'Data Analyst with Excel',
                          subtitle: 'DoLap',
                          image: 'assets/pelatihan_2.jpg',
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PelatihanListPage()),
                        );
                      },
                      child: const Text(
                        'Lebih Banyak',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  // Sertifikasi Section
                  const SizedBox(height: 20),
                  const Text(
                    'Sertifikasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 18, 78, 120),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: buildCertificationCard(
                          title: 'WEB Development',
                          subtitle: 'BNSP',
                          image: 'assets/Sertifikasi_1.jpg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildCertificationCard(
                          title: 'Software Engineer',
                          subtitle: 'Jagoan Hosting',
                          image: 'assets/Sertifikasi_2.png',
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SertifikasiListPage()),
                        );
                      },
                      child: const Text(
                        'Lebih Banyak',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('Other Page Content'),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '', // Home
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: '', // Pendataan
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '', // Notifikasi
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '', // Profil
          ),
        ],
      ),
    );
  }

  // Function to build recommendation card
  Card buildRecommendationCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/Rekomendasi.png',
                height: 100, width: 100, fit: BoxFit.cover),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Program Non-Degree Peningkatan Kompetensi Dosen Vokasi 2024',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Program Non-Degree ini mendukung dosen vokasi untuk meningkatkan kompetensi dengan pengalaman global.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Rekomendasidetailpage()),
                        );
                      },
                      child: const Text(
                        'Lihat selengkapnya',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Training Card Widget
  Card buildTrainingCard({
    required String title,
    required String subtitle,
    required String image,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(image,
                height: 80, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Certification Card Widget
  Card buildCertificationCard({
    required String title,
    required String subtitle,
    required String image,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(image,
                height: 80, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
