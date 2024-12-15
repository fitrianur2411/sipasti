import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const ProfilePage({super.key, required this.onBackToHome});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nipController = TextEditingController(text: "199205142023052008");
  final TextEditingController _usernameController = TextEditingController(text: "Pimpinan99");
  final TextEditingController _nameController = TextEditingController(text: "Arhan Pratama, S.Tr S.I.B, M.T");
  final TextEditingController _addressController = TextEditingController(text: "Jl. Semanggi Barat No 23B");
  final TextEditingController _emailController = TextEditingController(text: "Arhan123@gmail.com");
  final TextEditingController _phoneController = TextEditingController(text: "08123456789");
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isEditProfileSelected = true;
  File? _profileImage;
  int _selectedIndex = 3; 

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  // Function to show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog tidak bisa ditutup dengan klik di luar
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 64, color: Color(0xFF065A97)),
              const SizedBox(height: 10),
              const Text(
                "Berhasil Update",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF065A97)),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF065A97),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
                child: const Text("OK"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Color(0xFF065A97),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // CircleAvatar with Editable Image
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) as ImageProvider
                        : AssetImage('assets/profile.jpg') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: InkWell(
                      onTap: _pickImage,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Pimpinan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Edit Profile"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Edit Password"),
                  ),
                ],
                isSelected: [isEditProfileSelected, !isEditProfileSelected],
                onPressed: (index) {
                  setState(() {
                    isEditProfileSelected = index == 0;
                  });
                },
              ),
              const SizedBox(height: 20),
              isEditProfileSelected ? buildEditProfile() : buildEditPassword(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF065A97),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                ),
                onPressed: () {
                  // Panggil dialog sukses
                  _showSuccessDialog();
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditProfile() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromARGB(255, 204, 221, 230)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "NIP",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _nipController,
                  readOnly: true, // Membuat NIP hanya dapat dibaca
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 204, 221, 230)),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 235, 240, 245),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          buildTextField("Username", _usernameController),
          buildTextField("Nama", _nameController),
          buildTextField("Email", _emailController),
          buildTextField("No.Telp/HP", _phoneController),
          buildTextField("Alamat", _addressController),
        ],
      ),
    );
  }

  Widget buildEditPassword() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromARGB(255, 204, 221, 230)),
      ),
      child: Column(
        children: [
          buildTextField("Password Lama", _oldPasswordController, isPassword: true),
          buildTextField("Password Baru", _newPasswordController, isPassword: true),
          buildTextField("Ulangi Password Baru", _confirmPasswordController, isPassword: true),
        ],
      ),
    );
  }

  // Helper function to create a text field with optional password input
  Widget buildTextField(String labelText, TextEditingController controller, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color.fromARGB(255, 235, 240, 245),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
