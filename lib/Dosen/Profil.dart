import 'package:flutter/material.dart';
import 'package:sipasti/landing_page.dart';
import 'EditProfilePage.dart'; // Import your EditProfilePage
import 'Home_Page.dart'; // Import HomePage
import 'PendataanPage.dart';
import 'Notification_Page.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  int _selectedIndex = 3; // Default to Profile page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    if (index == 0) {
      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: 'User'),
        ),
      );
    } else if (index == 1) {
      // Navigate to PendataanPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PendataanPage(
            onBackToHome: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else if (index == 2) {
      // Navigate to NotificationPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationPage(
            onBackToHome: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else if (index == 3) {
      // Stay on ProfilePage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Dosen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            buildProfileButton(
              icon: Icons.person_outline,
              label: 'Edit Profil',
              onTap: () {
                // Navigate to EditProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      onBackToHome: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            buildProfileButton(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () {
                // Navigate to LandingPage on Logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 6, 90, 151),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
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
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildProfileButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 233, 242),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 15),
            Icon(
              icon,
              color: const Color.fromARGB(255, 6, 90, 151),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 6, 90, 151),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
