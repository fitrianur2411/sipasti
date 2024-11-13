import 'package:flutter/material.dart';
import 'inputpelatihanpage.dart';
import 'inputsertifikasipage.dart'; // Import the new page

class PendataanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pendataan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
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
              // Pelatihan button
              buildMenuButton(context, 'Pelatihan', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => inputpelatihanpage()), 
                );
              }),
              const SizedBox(width: 20),
              // Sertifikasi button
              buildMenuButton(context, 'Sertifikasi', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => inputsertifikasipage()),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
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

  Widget buildMenuButton(BuildContext context, String title, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        backgroundColor: const Color(0xFFBFC9D6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 18, 78, 120),
        ),
      ),
    );
  }
}
