import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Home_Page.dart';
import 'SertifikasiListPage.dart';
import 'Profil.dart';
import 'pelatihandetailpage.dart';

class PelatihanListPage extends StatefulWidget {
  final String username;

  const PelatihanListPage({Key? key, required this.username}) : super(key: key);

  @override
  State<PelatihanListPage> createState() => _PelatihanListPageState();
}

class _PelatihanListPageState extends State<PelatihanListPage> {
  int _selectedIndex = 1;
  List<dynamic> _trainingList = [];
  List<dynamic> _filteredTrainingList = [];
  bool _isLoading = true;
  String _errorMessage = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTrainingHistory();
    _searchController.addListener(_filterTrainingList);
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(username: widget.username),
            ),
          );
          break;
        case 1:
          // Tetap di halaman Pelatihan
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SertifikasiListPage(username: widget.username),
            ),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Profil(username: widget.username),
            ),
          );
          break;
      }
    }
  }

  Future<void> fetchTrainingHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      if (userId != null && userId.isNotEmpty) {
        final response = await http.get(
          Uri.parse('https://sipasti.cloud/api/training_history/$userId'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          setState(() {
            _trainingList = jsonResponse;
            _filteredTrainingList = jsonResponse;
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage =
                'Gagal memuat data pelatihan. Status Code: ${response.statusCode}';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'User ID tidak valid.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error saat mengambil data: $e';
        _isLoading = false;
      });
    }
  }

  void _filterTrainingList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTrainingList = _trainingList.where((training) {
        final trainingName = training['training_name']?.toLowerCase() ?? '';
        return trainingName.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Pelatihan'),
        backgroundColor: const Color.fromARGB(255, 14, 91, 155),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator()) 
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                child: Text(
                  'Daftar Riwayat Pelatihan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 14, 91, 155), // Warna biru tua
                  ),
                ),
              ),

                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari Pelatihan',
                        suffixIcon: _searchController.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterTrainingList();
                                },
                              ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _errorMessage.isNotEmpty
                        ? Center(
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _filteredTrainingList.length,
                            itemBuilder: (context, index) {
                              final training = _filteredTrainingList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PelatihanDetailPage(
                                        trainingId: training['training_id'],
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: buildTrainingCard(
                                    title: training['training_name'] ??
                                        'Nama Pelatihan Tidak Tersedia',
                                    periodYear: training['period_year']?.toString() ?? '-',
                                    trainingLevel: training['training_level'] ?? '-',
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
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

  Card buildTrainingCard({
    required String title,
    required String periodYear,
    required String trainingLevel,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.article,
              size: 40, color: Color.fromARGB(255, 16, 94, 158)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text('Periode: $periodYear',
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text('Level: $trainingLevel',
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
