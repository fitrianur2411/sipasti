import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class CertificationDetailPage extends StatefulWidget {
  final String certificationId;

  const CertificationDetailPage({super.key, required this.certificationId});

  @override
  State<CertificationDetailPage> createState() =>
      _CertificationDetailPageState();
}

class _CertificationDetailPageState extends State<CertificationDetailPage> {
  Map<String, dynamic> certificationDetail = {};
  List<dynamic> interests = [];
  List<dynamic> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCertificationDetail();
  }

  // Fetch detail sertifikasi dari API
  Future<void> fetchCertificationDetail() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://sipasti.cloud/api/certification/show/${widget.certificationId}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        setState(() {
          certificationDetail = jsonResponse[0] ?? {};
          interests = jsonResponse[1] ?? [];
          courses = jsonResponse[2] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch file PDF sertifikasi dan tampilkan dalam preview PDF
  Future<void> fetchCertificationFile(String certificationId) async {
    try {
      final url =
          'https://sipasti.cloud/api/certification/file/$certificationId';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/certificate_$certificationId.pdf');
        await file.writeAsBytes(bytes);

        // Navigasi ke halaman preview PDF
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfPreviewPage(filePath: file.path),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengakses file sertifikat')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat memuat file PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Detail Sertifikasi'),
        backgroundColor: const Color.fromARGB(255, 18, 62, 138),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Sertifikasi
                   Center( // Membuat judul di tengah
                      child: Text(
                        certificationDetail['certification_name'] ?? 'Tidak Ada Nama',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(255, 22, 104, 171), 
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),

                    buildSectionCard(
                      title: 'Informasi Sertifikasi',
                      children: [
                        buildInfoRow('Nomor Sertifikasi',
                            certificationDetail['certification_number'] ?? '-'),
                        buildInfoRow('Vendor',
                            certificationDetail['certification_vendor_name'] ??
                                '-'),
                        buildInfoRow('Level',
                            certificationDetail['certification_level'] ?? '-'),
                        buildInfoRow('Jenis',
                            certificationDetail['certification_type'] ?? '-'),
                        buildInfoRow('Tanggal Mulai',
                            certificationDetail['certification_date_start'] ??
                                '-'),
                        buildInfoRow(
                            'Tanggal Berakhir',
                            certificationDetail['certification_date_expired'] ??
                                '-'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    buildSectionCard(
                      title: 'Bidang Minat',
                      children: interests.isNotEmpty
                          ? interests
                              .map((interest) => ListTile(
                                    leading: const Icon(Icons.star,
                                        color: Color.fromARGB(255, 218, 196, 7)),
                                    title: Text(interest['interest_name'] ?? '-'),
                                  ))
                              .toList()
                          : [const Text('Tidak ada data bidang minat.')],
                    ),

                    const SizedBox(height: 20),

                    buildSectionCard(
                      title: 'Mata Kuliah',
                      children: courses.isNotEmpty
                          ? courses
                              .map((course) => ListTile(
                                    leading: const Icon(Icons.book,
                                        color: Color.fromARGB(255, 12, 85, 163)),
                                    title: Text(course['course_name'] ?? '-'),
                                  ))
                              .toList()
                          : [const Text('Tidak ada data mata kuliah.')],
                    ),

                    const SizedBox(height: 20),

                    // Sertifikat File Link
                    if (certificationDetail['certification_file'] != null)
                      buildSectionCard(
                        title: 'File Sertifikat',
                        children: [
                          Center(
                            child: TextButton(
                              onPressed: () => fetchCertificationFile(
                                  widget.certificationId),
                              child: const Text(
                                'Lihat Sertifikat',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  // Widget untuk membangun card seksi
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

// Halaman Preview PDF
class PdfPreviewPage extends StatelessWidget {
  final String filePath;

  const PdfPreviewPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Preview File"),
        backgroundColor: const Color.fromARGB(255, 18, 62, 138),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}