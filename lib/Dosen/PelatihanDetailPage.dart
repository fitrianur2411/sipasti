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
        backgroundColor: const Color.fromARGB(255, 18, 62, 138),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Pelatihan
                        Center(
                          child: Text(
                            _trainingDetail['training_name'] ?? 'Nama Pelatihan',
                            style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(255, 22, 104, 171), 
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Informasi Umum
                        buildSectionCard(
                          title: 'Informasi Pelatihan',
                          children: [
                            buildInfoRow('ID Pelatihan',
                                _trainingDetail['training_id'] ?? '-'),
                            buildInfoRow('Tahun Periode',
                                _trainingDetail['period_year']?.toString() ??
                                    '-'),
                            buildInfoRow('Tanggal Pelaksanaan',
                                _trainingDetail['training_date'] ?? '-'),
                            buildInfoRow('Durasi (Jam)',
                                _trainingDetail['training_hours']?.toString() ??
                                    '-'),
                            buildInfoRow('Lokasi',
                                _trainingDetail['training_location'] ?? '-'),
                            buildInfoRow('Biaya',
                                'Rp. ${_trainingDetail['training_cost'] ?? 0}'),
                            buildInfoRow('Kuota Peserta',
                                _trainingDetail['training_quota']?.toString() ??
                                    '-'),
                            buildInfoRow('Vendor',
                                _trainingDetail['training_vendor_name'] ?? '-'),
                            buildInfoRow('Level',
                                _trainingDetail['training_level'] ?? '-'),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Bidang Minat
                        buildSectionCard(
                          title: 'Bidang Minat',
                          children: _interests.isNotEmpty
                              ? _interests
                                  .map((interest) => ListTile(
                                        leading: const Icon(Icons.star,
                                            color: Color.fromARGB(255, 218, 196, 7)),
                                        title:
                                            Text(interest['interest_name'] ?? '-'),
                                      ))
                                  .toList()
                              : [const Text('Tidak ada data bidang minat.')],
                        ),

                        const SizedBox(height: 20),

                        // Mata Kuliah
                        buildSectionCard(
                          title: 'Mata Kuliah',
                          children: _courses.isNotEmpty
                              ? _courses
                                  .map((course) => ListTile(
                                        leading: const Icon(Icons.book,
                                            color: Color.fromARGB(255, 12, 85, 163)),
                                        title:
                                            Text(course['course_name'] ?? '-'),
                                      ))
                                  .toList()
                              : [const Text('Tidak ada data mata kuliah.')],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  // Widget untuk membangun Card seksi
  Widget buildSectionCard(
    {required String title, required List<Widget> children}) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start, // Menyesuaikan posisi teks ke awal
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 22, 104, 171)),
          ),
          const Divider(),
          ...children,
        ],
      ),
    ),
  );
}

  // Widget untuk membuat baris informasi
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
}