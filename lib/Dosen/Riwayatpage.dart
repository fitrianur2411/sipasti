import 'package:flutter/material.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  int _selectedTabIndex = 0; // 0 untuk Pelatihan, 1 untuk Sertifikasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
      body: Column(
        children: [
          // Tab untuk Pelatihan dan Sertifikasi
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton(
                  title: 'Pelatihan',
                  isSelected: _selectedTabIndex == 0,
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 0;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _buildTabButton(
                  title: 'Sertifikasi',
                  isSelected: _selectedTabIndex == 1,
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
          // Konten berdasarkan tab yang dipilih
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildPelatihanList()
                : _buildSertifikasiList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 6, 90, 151)
              : const Color(0xFFBFC9D6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPelatihanList() {
    final pelatihanData = [
      {'title': 'Pelatihan Artificial Intellegent', 'tahun': '2023'},
      {'title': 'Pelatihan Data Science', 'tahun': '2024'},
      {'title': 'Pelatihan Java Development', 'tahun': '2024'},
    ];

    return ListView.builder(
      itemCount: pelatihanData.length,
      itemBuilder: (context, index) {
        final item = pelatihanData[index];
        return _buildRiwayatCard(item['title']!, item['tahun']!);
      },
    );
  }

  Widget _buildSertifikasiList() {
    final sertifikasiData = [
      {'title': 'Sertifikasi Cyber Security', 'tahun': '2022'},
      {'title': 'Sertifikasi Cloud Computing', 'tahun': '2023'},
    ];

    return ListView.builder(
      itemCount: sertifikasiData.length,
      itemBuilder: (context, index) {
        final item = sertifikasiData[index];
        return _buildRiwayatCard(item['title']!, item['tahun']!);
      },
    );
  }

  Widget _buildRiwayatCard(String title, String tahun) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFBFC9D6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tahun Periode $tahun',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
