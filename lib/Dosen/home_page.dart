import 'package:flutter/material.dart';
import 'PelatihanListPage.dart';
import 'SertifikasiListPage.dart';
import 'Profil.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PelatihanListPage(username: widget.username),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SertifikasiListPage(username: widget.username),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profil(username: widget.username),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/logo_JTIpolinema.png', height: 40),
                const SizedBox(width: 10),
              ],
            ),
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
      body: _selectedIndex == 0
          ? Container(
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
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Sistem Informasi Pelatihan & Sertifikasi Jurusan Teknologi Informasi',
                    style: TextStyle(fontSize: 14, color: Color(0xFF4D4D4D)),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      buildStatisticCard('Total Riwayat Pelatihan', '5', Icons.article,
                          100),
                      const SizedBox(height: 10),
                      buildStatisticCard('Total Riwayat Sertifikasi', '5',
                          Icons.workspace_premium, 100),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(''),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Pelatihan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: 'Sertifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget buildStatisticCard(String title, String value, IconData icon,
      int total) {
    double progress = int.parse(value) / total;

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
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFE3E9F2),
                      ),
                    ),
                    Container(
                      height: 8,
                      width: 150 * progress,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 6, 90, 151),
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