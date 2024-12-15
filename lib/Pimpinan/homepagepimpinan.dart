import 'package:flutter/material.dart';
import 'PelatihanListPage.dart';
import 'SertifikasiListPage.dart';
import 'Profile.dart';
import 'notification_page.dart';
import 'StatistikPage.dart'; 

class HomePagePimpinan extends StatefulWidget {
  final String username;

  const HomePagePimpinan({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePagePimpinan> createState() => _HomePagePimpinanState();
}

class _HomePagePimpinanState extends State<HomePagePimpinan> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StatistikPage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationPage(
              onBackToHome: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
          ),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(),
          ),
        );
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo_JTIpolinema.png', height: 40),
            Text(
              'Hi, ${widget.username}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF3F4F6),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'SIPaSTI',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 18, 78, 120),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Sistem Informasi Pelatihan & Sertifikasi Jurusan Teknologi Informasi',
              style: TextStyle(fontSize: 14, color: Color(0xFF4D4D4D)),
            ),
            const SizedBox(height: 20),

            // Statistik Cards
            buildStatisticCard('Total Pengguna', '150', Icons.people, 150),
            const SizedBox(height: 10),
            buildStatisticCard('Total Sertifikasi', '75', Icons.workspace_premium, 150),
            const SizedBox(height: 10),
            buildStatisticCard('Total Pelatihan', '45', Icons.article, 150),
            const SizedBox(height: 10),
            buildStatisticCard('Total Vendor', '20', Icons.apartment, 150),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF095592),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget buildStatisticCard(String title, String value, IconData icon, int maxValue) {
  double valueAsDouble = double.tryParse(value) ?? 0;
  double percentage = (valueAsDouble / maxValue).clamp(0, 1);

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
              Stack(
                children: [
                  Container(
                    height: 8,
                    width: 150, // Panjang tetap
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFE3E9F2), // Background progress bar
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 150 * percentage, // Panjang sesuai persentase
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 6, 90, 151),
                          Color.fromARGB(255, 94, 176, 237),
                        ],
                      ),
                    ),
                  ),
                ],
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
}
