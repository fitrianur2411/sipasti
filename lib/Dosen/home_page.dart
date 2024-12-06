import 'package:flutter/material.dart';
import 'package:sipasti/Pimpinan/SertifikasiListPage.dart';
import 'PelatihanListPage.dart';
import 'PendataanPage.dart';
import 'notification_page.dart';
import 'Profil.dart';

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
      // Jika ikon profil ditekan, langsung navigasi ke Profil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Mencegah ikon back muncul
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

                  // Statistik bagian atas (vertikal)
                  Column(
                    children: [
                      buildStatisticCard('Total Sertifikasi', '50',
                          Icons.workspace_premium), // Ikon sertifikasi
                      const SizedBox(height: 10),
                      buildStatisticCard('Total Pelatihan', '50',
                          Icons.article), // Ikon pelatihan
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'Informasi Pelatihan',
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
                    'Informasi Sertifikasi',
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

  Widget buildStatisticCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 18, 78, 120),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 18, 78, 120),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 8,
                  width: 150, // Fixed width for progress bar
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 6, 90, 151),
                        Color(0xFFE3E9F2),
                      ],
                      stops: [0.5, 0.5],
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              icon,
              size: 30,
              color: const Color.fromARGB(255, 6, 90, 151),
            ),
          ],
        ),
      ),
    );
  }

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
