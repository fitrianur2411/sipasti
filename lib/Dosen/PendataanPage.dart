import 'package:flutter/material.dart';
import 'inputpelatihanpage.dart';
import 'inputsertifikasipage.dart';
import 'notification_page.dart';
import 'Profil.dart';

class PendataanPage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const PendataanPage({super.key, required this.onBackToHome});

  @override
  _PendataanPageState createState() => _PendataanPageState();
}

class _PendataanPageState extends State<PendataanPage> {
  int _selectedIndex = 1; // Initially set to "Pendataan" (index 1)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    if (index == 0) {
      // Navigate to Home Page (trigger onBackToHome)
      widget.onBackToHome(); // This should trigger the navigation to the HomePage.
      Navigator.pop(context); // Close current page and return to the previous screen (HomePage)
    } else if (index == 1) {
      // Stay on the current Pendataan page
    } else if (index == 2) {
      // Navigate to NotificationPage when Notification icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationPage(
            onBackToHome: widget.onBackToHome, // Pass the callback
          ),
        ),
      );
    } else if (index == 3) {
      // Navigate to Profil page instead of ProfilePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profil(), // Updated to navigate to Profil page
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pendataan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the top
          children: [
            // Button for Pelatihan
            buildMenuButton(
              context,
              'Pelatihan',
              Icons.school, // Icon for Pelatihan
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => inputpelatihanpage()),
                );
              },
            ),
            const SizedBox(height: 20),
            // Button for Sertifikasi
            buildMenuButton(
              context,
              'Sertifikasi',
              Icons.card_membership, // Icon for Sertifikasi
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => inputsertifikasipage()),
                );
              },
            ),
            const SizedBox(height: 20),
            // Button for Riwayat
            buildMenuButton(
              context,
              'Riwayat',
              Icons.history, 
              () {
                // Navigate to Riwayat Page (implement this page if needed)
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // Set the selected index
        onTap: _onItemTapped, // Handle bottom navigation taps
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

  Widget buildMenuButton(
    BuildContext context,
    String title,
    IconData icon, // Parameter for the icon
    VoidCallback onPressed,
  ) {
    return Container(
      height: 60, // Height of the button
      decoration: BoxDecoration(
        color: const Color(0xFFBFC9D6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 18, 78, 120), // Icon color
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 18, 78, 120),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
