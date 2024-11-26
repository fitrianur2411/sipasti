import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final VoidCallback onBackToHome; // Callback untuk kembali ke HomePage

  const NotificationPage({Key? key, required this.onBackToHome})
      : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isLatestSelected = true; // Track apakah "Terbaru" atau "Semua" dipilih
  int _selectedIndex = 2; // Default untuk ikon Notifikasi (posisi ke-2)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Navigasi antar halaman berdasarkan indeks
      switch (index) {
        case 0:
          widget.onBackToHome(); // Kembali ke Home
          Navigator.pop(context); // Tutup halaman notifikasi
          break;
        case 1:
          // Tambahkan navigasi ke halaman Dokumen jika ada
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Navigasi ke halaman Dokumen belum tersedia")));
          break;
        case 2:
          // Halaman Notifikasi saat ini
          break;
        case 3:
          // Tambahkan navigasi ke halaman Profil jika ada
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Navigasi ke halaman Profil belum tersedia")));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onBackToHome(); // Kembali ke halaman Home
        Navigator.pop(context); // Tutup halaman notifikasi
        return false; // Mencegah navigasi default
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifikasi'),
          backgroundColor: const Color.fromARGB(255, 6, 90, 151),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              widget.onBackToHome(); // Kembali ke halaman Home
              Navigator.pop(context); // Tutup halaman notifikasi
            },
          ),
        ),
        body: Column(
          children: [
            // Tabs "Terbaru" dan "Semua"
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLatestSelected = true; // Set "Terbaru" sebagai aktif
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      decoration: BoxDecoration(
                        color: isLatestSelected
                            ? const Color.fromARGB(255, 153, 177, 196)
                            : const Color.fromARGB(255, 204, 221, 230),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Terbaru',
                        style: TextStyle(
                          color: isLatestSelected ? Colors.white : Colors.blue,
                          fontWeight: isLatestSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLatestSelected = false; // Set "Semua" sebagai aktif
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      decoration: BoxDecoration(
                        color: !isLatestSelected
                            ? const Color.fromARGB(255, 153, 177, 196)
                            : const Color.fromARGB(255, 204, 221, 230),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Semua',
                        style: TextStyle(
                          color: !isLatestSelected ? Colors.white : Colors.blue,
                          fontWeight: !isLatestSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Daftar notifikasi
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  if (isLatestSelected) ...[
                    const NotificationCard(
                      title: 'Admin xxxxxxx',
                      message: 'Telah mengupload pelatihan baru',
                    ),
                    const NotificationCard(
                      title: 'Pimpinan xxxxxxx',
                      message: 'Merekomendasikan Anda untuk mengikuti pelatihan',
                    ),
                  ] else ...[
                    const NotificationCard(
                      title: 'Admin xxxxxxx',
                      message: 'Mengumumkan informasi terbaru.',
                    ),
                    const NotificationCard(
                      title: 'Admin xxxxxxx',
                      message: 'Memperbarui jadwal pelatihan.',
                    ),
                    const NotificationCard(
                      title: 'Pimpinan xxxxxxx',
                      message:
                          'Menyarankan mengikuti sertifikasi baru yang relevan.',
                    ),
                  ],
                ],
              ),
            ),
          ],
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
      ),
    );
  }
}

// Kartu Notifikasi
class NotificationCard extends StatelessWidget {
  final String title;
  final String message;

  const NotificationCard({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 168, 189, 206),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ikon profil
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Background putih untuk ikon
              ),
              child: const Icon(
                Icons.person, // Ikon profil
                size: 30,
                color: Color.fromARGB(255, 6, 90, 151), // Warna biru utama
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
