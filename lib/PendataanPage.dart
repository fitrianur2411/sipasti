import 'package:flutter/material.dart';
import 'inputpelatihanpage.dart';
import 'inputsertifikasipage.dart';
import 'notification_page.dart';

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
      // Navigate to Home
      widget.onBackToHome();
      Navigator.pop(context);
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
      // Navigate to Profile (not implemented yet)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Placeholder(), // Placeholder for Profile page
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pendataan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            widget.onBackToHome(); // Call the callback to go back to Home
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button for Pelatihan
              buildMenuButton(context, 'Pelatihan', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => inputpelatihanpage()),
                );
              }),
              const SizedBox(width: 20),
              // Button for Sertifikasi
              buildMenuButton(context, 'Sertifikasi', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => inputsertifikasipage()),
                );
              }),
            ],
          ),
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
      BuildContext context, String title, VoidCallback onPressed) {
    return Container(
      width: 138,
      height: 140,
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
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 18, 78, 120),
            ),
          ),
        ),
      ),
    );
  }
}
