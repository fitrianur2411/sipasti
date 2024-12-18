import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
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

      print('Fetch Certification Detail: ${response.statusCode}');
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
        print('Error: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Exception: $e');
    }
  }

  // Fungsi untuk membuka URL di browser
  Future<void> _launchUrl(String url) async {
    final Uri fileUrl = Uri.parse(url);

    if (await canLaunchUrl(fileUrl)) {
      await launchUrl(fileUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka file sertifikat')),
      );
    }
  }

  // Fetch file PDF sertifikasi dan tampilkan dalam preview PDF
  Future<void> fetchCertificationFile(String certification_Id) async {
    try {
      final url = 'https://sipasti.cloud/api/certification/file/$certification_Id';
      print('Fetching PDF from: $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/certificate_$certification_Id.pdf');
        await file.writeAsBytes(bytes);

        print('File tersimpan di: ${file.path}');

        // Navigasi ke halaman preview PDF
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfPreviewPage(filePath: file.path),
          ),
        );
      } else {
        print('Gagal mengambil file sertifikat. Status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengakses file sertifikat')),
        );
      }
    } catch (e) {
      print('Error fetching PDF: $e');
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
                    Text(
                      certificationDetail['certification_name'] ??
                          'Tidak Ada Nama',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        'Nomor Sertifikasi: ${certificationDetail['certification_number'] ?? '-'}'),
                    Text(
                        'Vendor: ${certificationDetail['certification_vendor_name'] ?? '-'}'),
                    Text(
                        'Level: ${certificationDetail['certification_level'] ?? '-'}'),
                    Text(
                        'Jenis: ${certificationDetail['certification_type'] ?? '-'}'),
                    Text(
                        'Tanggal Mulai: ${certificationDetail['certification_date_start'] ?? '-'}'),
                    Text(
                        'Tanggal Berakhir: ${certificationDetail['certification_date_expired'] ?? '-'}'),
                    const SizedBox(height: 20),

                    // Interests Section
                    const Text(
                      'Bidang Minat:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    interests.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: interests.length,
                            itemBuilder: (context, index) {
                              return Text(
                                  '- ${interests[index]['interest_name']}');
                            },
                          )
                        : const Text('Tidak ada bidang minat.'),

                    const SizedBox(height: 20),

                    // Courses Section
                    const Text(
                      'Mata Kuliah:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    courses.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: courses.length,
                            itemBuilder: (context, index) {
                              return Text('- ${courses[index]['course_name']}');
                            },
                          )
                        : const Text('Tidak ada daftar kursus.'),

                    const SizedBox(height: 20),

                    // Sertifikat File Link
                    if (certificationDetail['certification_file'] != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'File Sertifikat:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => _launchUrl(
                                    certificationDetail['certification_file']),
                                child: const Text(
                                  'Buka di Browser',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                onPressed: () => fetchCertificationFile(
                                    widget.certificationId),
                                child: const Text(
                                  'Preview PDF',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
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
      appBar: AppBar(title: const Text("Preview PDF")),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
