import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';  // Import the file_picker package

class inputpelatihanpage extends StatefulWidget {
  @override
  _InputPelatihanPageState createState() => _InputPelatihanPageState();
}

class _InputPelatihanPageState extends State<inputpelatihanpage> {
  String? _fileName;  // To store the name of the uploaded file

  // Method to show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Color.fromARGB(255, 6, 90, 151),
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Berhasil Simpan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 6, 90, 151),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Close the dialog after a delay (optional)
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  // Method to pick a file for upload
  Future<void> _pickFile() async {
    // Pick a file using FilePicker
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        // Update the file name when a file is picked
        _fileName = result.files.single.name;
      });
    } else {
      // Handle case when no file is picked
      setState(() {
        _fileName = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendataan'),
        backgroundColor: const Color.fromARGB(255, 6, 90, 151),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload Pelatihan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 6, 90, 151),
              ),
            ),
            const SizedBox(height: 20),
            
            // Container Box around form inputs
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color.fromARGB(255, 204, 221, 230)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField('Nama Pelatihan', 'Masukkan Nama Pelatihan'),
                  buildTextField('Mandiri/Non Mandiri', 'Mandiri/Non Mandiri'),
                  buildTextField('Lembaga Penyelenggara', 'Lembaga Penyelenggara'),
                  buildTextField('Waktu Pelaksanaan', ''),
                  buildTextField('Bidang Minat', ''),
                  buildTextField('Jenis Pelatihan', ''),
                  buildTextField('Mata Kuliah', ''),
                  const SizedBox(height: 10),
                  const Text(
                    'Unggah Dokumen Pendukung:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _pickFile,  // Use the file picker method when pressed
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Unggah Dokumen'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 126, 160, 197),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  if (_fileName != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      'Dokumen Terpilih: $_fileName',  // Display selected file name
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 6, 90, 151),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 45),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showSuccessDialog(); // Show the success dialog when clicked
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 90, 151),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal:35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a styled text field
  Widget buildTextField(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              filled: true,
              fillColor: const Color.fromARGB(255, 235, 240, 245),
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(255, 204, 221, 230)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(255, 204, 221, 230)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(255, 6, 90, 151)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
