import 'package:flutter/material.dart';
import 'PelatihanListPage.dart';
import 'SertifikasiListPage.dart';

class HomePagePimpinan extends StatefulWidget {
  final String username;

  const HomePagePimpinan({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePagePimpinan> createState() => _HomePagePimpinanState();
}

class _HomePagePimpinanState extends State<HomePagePimpinan> {
  int _selectedIndex = 0; // Index untuk navigasi BottomNavigationBar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                              builder: (context) => const SertifikasiListPage()),
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
        selectedItemColor: const Color(0xFF095592),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget buildRecommendationCard(BuildContext context) {
    return _buildCard(
      title: 'Rekomendasi Sertifikasi AI',
      subtitle: 'Google',
      image: 'assets/rekomendasi.png',
    );
  }

  Widget buildTrainingCard(
      {required String title, required String subtitle, required String image}) {
    return _buildCard(title: title, subtitle: subtitle, image: image);
  }

  Widget buildCertificationCard(
      {required String title, required String subtitle, required String image}) {
    return _buildCard(title: title, subtitle: subtitle, image: image);
  }

  Widget _buildCard(
      {required String title, required String subtitle, required String image}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
