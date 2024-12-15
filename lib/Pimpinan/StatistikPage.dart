import 'package:flutter/material.dart';
import 'HomePagePimpinan.dart'; // Import halaman utama
import 'notification_page.dart'; // Import halaman notifikasi
import 'Profile.dart'; // Import halaman profil

class StatistikPage extends StatefulWidget {
  const StatistikPage({Key? key}) : super(key: key);

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  int _selectedIndex = 1; // Indeks awal untuk halaman Statistik

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        // Navigasi ke halaman utama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePagePimpinan(username: 'Pimpinan')),
        );
      } else if (index == 2) {
        // Navigasi ke halaman notifikasi
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationPage(
              onBackToHome: () {
                setState(() {
                  _selectedIndex = 1; // Kembali ke Statistik
                });
              },
            ),
          ),
        );
      } else if (index == 3) {
        // Navigasi ke halaman profil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Statistik Dosen'),
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          buildStatistikCard('Rega Dane', 10, 25),
          const SizedBox(height: 10),
          buildStatistikCard('Agung Nugroho', 15, 20),
          const SizedBox(height: 10),
          buildStatistikCard('Fitria Nur', 20, 15),
          const SizedBox(height: 10),
          buildStatistikCard('Sheva Ananda', 15, 13),
        ],
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
            icon: Icon(Icons.bar_chart), // Ikon Statistik
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

  Widget buildStatistikCard(String name, int sertifikasi, int pelatihan) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 18, 78, 120),
              ),
            ),
            const SizedBox(height: 10),
            buildProgressRow('Total Sertifikasi', sertifikasi),
            const SizedBox(height: 10),
            buildProgressRow('Total Pelatihan', pelatihan),
          ],
        ),
      ),
    );
  }

  Widget buildProgressRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Row(
          children: [
            Container(
              width: 150,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(5),
              ),
              child: FractionallySizedBox(
                widthFactor: value / 100,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 6, 90, 151),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$value',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
