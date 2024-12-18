import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PelatihanDetailPage extends StatefulWidget {
  final String trainingId;

  const PelatihanDetailPage({super.key, required this.trainingId});

  @override
  State<PelatihanDetailPage> createState() => _PelatihanDetailPageState();
}

class _PelatihanDetailPageState extends State<PelatihanDetailPage> {
  Map<String, dynamic> _trainingDetail = {};
  List<dynamic> _interests = [];
  List<dynamic> _courses = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchTrainingDetail();
  }

  Future<void> fetchTrainingDetail() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://sipasti.cloud/api/training_history/show/${widget.trainingId}'),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        setState(() {
          _trainingDetail = jsonResponse[0] ?? {};
          _interests = jsonResponse[1] ?? [];
          _courses = jsonResponse[2] ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Gagal memuat detail pelatihan.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Detail Pelatihan'),
        backgroundColor: const Color.fromARGB(255, 14, 91, 155),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul Pelatihan
                        Text(
                          _trainingDetail['training_name'] ?? 'Nama Pelatihan',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),

                        // Informasi Umum Pelatihan
                        buildInfoRow('ID Pelatihan',
                            _trainingDetail['training_id'] ?? '-'),
                        buildInfoRow('Tahun Periode',
                            _trainingDetail['period_year']?.toString() ?? '-'),
                        buildInfoRow(
                            'Tanggal Pelaksanaan',
                            _trainingDetail['training_date'] ??
                                '-'), // Format tanggal bisa diatur
                        buildInfoRow(
                            'Durasi (Jam)',
                            _trainingDetail['training_hours']?.toString() ??
                                '-'),
                        buildInfoRow('Lokasi',
                            _trainingDetail['training_location'] ?? '-'),
                        buildInfoRow('Biaya',
                            'Rp. ${_trainingDetail['training_cost'] ?? 0}'),
                        buildInfoRow(
                            'Kuota Peserta',
                            _trainingDetail['training_quota']?.toString() ??
                                '-'),
                        buildInfoRow('Vendor',
                            _trainingDetail['training_vendor_name'] ?? '-'),
                        buildInfoRow('Level',
                            _trainingDetail['training_level'] ?? '-'),

                        const Divider(height: 30),

                        // Daftar Minat Pelatihan
                        const Text(
                          'Bidang Minat:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        _interests.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _interests.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(Icons.star,
                                        color: Colors.blueAccent),
                                    title: Text(
                                        _interests[index]['interest_name'] ??
                                            '-'),
                                  );
                                },
                              )
                            : const Text('Tidak ada data bidang minat.'),

                        const Divider(height: 30),

                        // Daftar Kursus
                        const Text(
                          'Mata Kuliah:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        _courses.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _courses.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(Icons.book,
                                        color: Colors.green),
                                    title: Text(
                                        _courses[index]['course_name'] ?? '-'),
                                  );
                                },
                              )
                            : const Text('Tidak ada data mata kuliah.'),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> e0c82417be6691291cfd7d69a9e6e627a7463253
