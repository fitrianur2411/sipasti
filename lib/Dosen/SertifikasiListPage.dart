import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'certificationdetailpage.dart';
import 'Home_Page.dart';
import 'PelatihanListPage.dart';
import 'Profil.dart';

class SertifikasiListPage extends StatefulWidget {
  final String username;

  const SertifikasiListPage({super.key, required this.username});

  @override
  State<SertifikasiListPage> createState() => _SertifikasiListPageState();
}

class _SertifikasiListPageState extends State<SertifikasiListPage> {
  int _selectedIndex = 2;
  String? userId;
  List<dynamic> _certificationList = [];
  List<dynamic> _filteredCertificationList = [];
  bool _isLoading = true;
  String _errorMessage = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _searchController.addListener(_filterCertificationList);
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id');
    });
    if (userId != null) {
      fetchCertificationHistory(userId!);
    } else {
      setState(() {
        _errorMessage = 'User ID tidak valid.';
        _isLoading = false;
      });
    }
  }

  Future<void> fetchCertificationHistory(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('https://sipasti.cloud/api/certification/$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        setState(() {
          _certificationList = jsonResponse;
          _filteredCertificationList = jsonResponse;
        });
      } else {
        setState(() {
          _errorMessage =
              'Gagal memuat data sertifikasi. Status Code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error saat mengambil data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterCertificationList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCertificationList = _certificationList.where((certification) {
        final certificationName =
            certification['certification_name']?.toLowerCase() ?? '';
        return certificationName.contains(query);
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(username: widget.username)),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PelatihanListPage(username: widget.username)),
        );
        break;
      case 2:
        // Tetap di halaman Sertifikasi
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Profil(username: widget.username)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sertifikasi'),
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
                        hintText: 'Cari Sertifikasi',
                        suffixIcon: _searchController.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterCertificationList();
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
                            child: Text(_errorMessage,
                                style: const TextStyle(color: Colors.red)),
                          )
                        : ListView.builder(
                            itemCount: _filteredCertificationList.length,
                            itemBuilder: (context, index) {
                              final certification =
                                  _filteredCertificationList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CertificationDetailPage(
                                        certificationId:
                                            certification['certification_id'] ??
                                                '',
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: buildCertificationCard(
                                    title: certification[
                                            'certification_name'] ??
                                        'Nama Sertifikasi Tidak Tersedia',
                                    periodYear: certification['period_year']
                                            ?.toString() ??
                                        '-',
                                    certificationLevel:
                                        certification['certification_level'] ??
                                            '-',
                                    certificationType:
                                        certification['certification_type'] ??
                                            '-',
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

  Card buildCertificationCard({
    required String title,
    required String periodYear,
    required String certificationLevel,
    required String certificationType,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.workspace_premium,
                size: 40, color: Color.fromARGB(255, 21, 93, 152)),
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
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text('Level: $certificationLevel',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}