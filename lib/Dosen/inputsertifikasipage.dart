import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class InputSertifikasiPage extends StatefulWidget {
  @override
  _InputSertifikasiPageState createState() => _InputSertifikasiPageState();
}

class _InputSertifikasiPageState extends State<InputSertifikasiPage> {
  String? _fileName;
  DateTime? _startDate;
  DateTime? _endDate;

  final _formKey = GlobalKey<FormState>();

  // Controllers for TextFields
  final _namaSertifikasiController = TextEditingController();
  final _nomorSertifikasiController = TextEditingController();
  final _lembagaController = TextEditingController();
  final _levelController = TextEditingController();
  final _bidangMinatController = TextEditingController();
  final _jenisSertifikasiController = TextEditingController();
  final _mataKuliahController = TextEditingController();

  // Error states
  String? _fileError;
  String? _startDateError;
  String? _endDateError;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
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

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _fileError = null; // Clear error when a file is selected
      });
    }
  }

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
          _startDateError = null; // Clear error when a date is selected
        } else {
          _endDate = pickedDate;
          _endDateError = null; // Clear error when a date is selected
        }
      });
    }
  }

  void _validateAndSave() {
    setState(() {
      // Reset errors
      _fileError = null;
      _startDateError = null;
      _endDateError = null;
    });

    bool isValid = _formKey.currentState!.validate();

    if (_fileName == null) {
      setState(() {
        _fileError = 'Harap unggah dokumen.';
      });
      isValid = false;
    }

    if (_startDate == null) {
      setState(() {
        _startDateError = 'Pilih waktu mulai berlaku.';
      });
      isValid = false;
    }

    if (_endDate == null) {
      setState(() {
        _endDateError = 'Pilih waktu akhir berlaku.';
      });
      isValid = false;
    }

    if (isValid) {
      _showSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sertifikasi'),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sertifikasi',
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
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextField('Nama Sertifikasi', 'Masukkan Nama Sertifikasi',
                        _namaSertifikasiController),
                    buildTextField('Nomor Sertifikasi', 'Masukkan Nomor Sertifikasi',
                        _nomorSertifikasiController),
                    buildTextField('Lembaga Penyelenggara', '',
                        _lembagaController),
                    buildTextField('Level Sertifikasi', 'Masukkan Level Sertifikasi',
                        _levelController),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: buildDatePicker(
                            label: 'Waktu Mulai Berlaku',
                            selectedDate: _startDate,
                            errorText: _startDateError,
                            onTap: () => _selectDate(context, true),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: buildDatePicker(
                            label: 'Waktu Akhir Berlaku',
                            selectedDate: _endDate,
                            errorText: _endDateError,
                            onTap: () => _selectDate(context, false),
                          ),
                        ),
                      ],
                    ),
                    buildTextField('Bidang Minat', '', _bidangMinatController),
                    buildTextField('Jenis Sertifikasi', '',
                        _jenisSertifikasiController),
                    buildTextField('Mata Kuliah', '', _mataKuliahController),

                    const SizedBox(height: 10),
                    const Text(
                      'Unggah Dokumen Pendukung:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Unggah Dokumen'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 126, 160, 197),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    if (_fileError != null)
                      Text(
                        _fileError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    if (_fileName != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        'Dokumen Terpilih: $_fileName',
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
                  onPressed: _validateAndSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 6, 90, 151),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 35),
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
      ),
    );
  }

  Widget buildTextField(String label, String placeholder,
      TextEditingController controller) {
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
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              filled: true,
              fillColor: const Color.fromARGB(255, 235, 240, 245),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 204, 221, 230)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 204, 221, 230)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 6, 90, 151)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label Tidak Boleh Kosong';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required String? errorText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 235, 240, 245),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: const Color.fromARGB(255, 204, 221, 230)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                      : 'Pilih Tanggal',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Color.fromARGB(255, 6, 90, 151),
                ),
              ],
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                errorText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
