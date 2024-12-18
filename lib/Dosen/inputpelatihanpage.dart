import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';  // Import the file_picker package

class inputpelatihanpage extends StatefulWidget {
  @override
  _InputPelatihanPageState createState() => _InputPelatihanPageState();
}

class _InputPelatihanPageState extends State<inputpelatihanpage> {
  String? _fileName;  // To store the name of the uploaded file
  DateTime? _startDate; // Date for 'Waktu Mulai Berlaku'
  DateTime? _endDate; // Date for 'Waktu Akhir Berlaku'
  
  // Controllers to manage form input
  final TextEditingController _namaPelatihanController = TextEditingController();
  final TextEditingController _nomorPelatihanController = TextEditingController();
  final TextEditingController _lembagaPenyelenggaraController = TextEditingController();
  final TextEditingController _levelPelatihanController = TextEditingController();
  final TextEditingController _bidangMinatController = TextEditingController();
  final TextEditingController _jenisPelatihanController = TextEditingController();
  final TextEditingController _mataKuliahController = TextEditingController();

  // Error messages for form validation
  String? _namaPelatihanError;
  String? _nomorPelatihanError;
  String? _lembagaPenyelenggaraError;
  String? _levelPelatihanError;
  String? _bidangMinatError;
  String? _jenisPelatihanError;
  String? _mataKuliahError;

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

  // Method to open the date picker and set the date
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  // Method to validate the form
  bool _validateForm() {
    bool isValid = true;

    // Reset error messages
    setState(() {
      _namaPelatihanError = null;
      _nomorPelatihanError = null;
      _lembagaPenyelenggaraError = null;
      _levelPelatihanError = null;
      _bidangMinatError = null;
      _jenisPelatihanError = null;
      _mataKuliahError = null;
    });

    // Validate each field
    if (_namaPelatihanController.text.isEmpty) {
      _namaPelatihanError = 'Nama Pelatihan tidak boleh kosong';
      isValid = false;
    }
    if (_nomorPelatihanController.text.isEmpty) {
      _nomorPelatihanError = 'Nomor Pelatihan tidak boleh kosong';
      isValid = false;
    }
    if (_lembagaPenyelenggaraController.text.isEmpty) {
      _lembagaPenyelenggaraError = 'Lembaga Penyelenggara tidak boleh kosong';
      isValid = false;
    }
    if (_levelPelatihanController.text.isEmpty) {
      _levelPelatihanError = 'Level Pelatihan tidak boleh kosong';
      isValid = false;
    }
    if (_bidangMinatController.text.isEmpty) {
      _bidangMinatError = 'Bidang Minat tidak boleh kosong';
      isValid = false;
    }
    if (_jenisPelatihanController.text.isEmpty) {
      _jenisPelatihanError = 'Jenis Pelatihan tidak boleh kosong';
      isValid = false;
    }
    if (_mataKuliahController.text.isEmpty) {
      _mataKuliahError = 'Mata Kuliah tidak boleh kosong';
      isValid = false;
    }
    if (_startDate == null || _endDate == null) {
      // Additional validation for date fields
      isValid = false;
    }

    return isValid;
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
              'Pelatihan',
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
                  buildTextField('Nama Pelatihan', 'Masukkan Nama Pelatihan', _namaPelatihanController, _namaPelatihanError),
                  buildTextField('Nomor Pelatihan', 'Masukkan Nomor Pelatihan', _nomorPelatihanController, _nomorPelatihanError),
                  buildTextField('Lembaga Penyelenggara', '', _lembagaPenyelenggaraController, _lembagaPenyelenggaraError),
                  buildTextField('Level Pelatihan', 'Masukkan Level Pelatihan', _levelPelatihanController, _levelPelatihanError),
                  
                  // Waktu Mulai Berlaku and Waktu Akhir Berlaku with Date Picker
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Waktu Mulai Berlaku
                      Expanded(
                        child: buildDatePicker(
                          label: 'Waktu Mulai Berlaku',
                          selectedDate: _startDate,
                          onTap: () => _selectDate(context, true),
                        ),
                      ),
                      const SizedBox(width: 10), // Spacing between the inputs
                      // Waktu Akhir Berlaku
                      Expanded(
                        child: buildDatePicker(
                          label: 'Waktu Akhir Berlaku',
                          selectedDate: _endDate,
                          onTap: () => _selectDate(context, false),
                        ),
                      ),
                    ],
                  ),
                  
                  buildTextField('Bidang Minat', '', _bidangMinatController, _bidangMinatError),
                  buildTextField('Jenis Pelatihan', '', _jenisPelatihanController, _jenisPelatihanError),
                  buildTextField('Mata Kuliah', '', _mataKuliahController, _mataKuliahError),
                  const SizedBox(height: 10),
                  const Text(
                    'Unggah Dokumen Pendukung: ',
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
                  if (_validateForm()) {
                    _showSuccessDialog(); // Show the success dialog when clicked
                  } else {
                    setState(() {}); // Trigger UI update to show error messages
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 90, 151),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 35),
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

  // Helper method to create a styled text field with error handling
  Widget buildTextField(String label, String placeholder, TextEditingController controller, String? errorText) {
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
            controller: controller,
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
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create the date picker with icon
  Widget buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 240, 245),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color.fromARGB(255, 204, 221, 230)),
              ),
              child: Row(
                children: [
                  Text(
                    selectedDate != null
                        ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                        : 'Pilih Tanggal',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  const Icon(Icons.calendar_today, color: Color.fromARGB(255, 6, 90, 151)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
