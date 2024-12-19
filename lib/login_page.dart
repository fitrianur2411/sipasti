// import 'package:flutter/material.dart';
// import 'Dosen/home_page.dart'; // Import HomePage untuk Dosen
// import 'Pimpinan/homepagepimpinan.dart'; // Import HomePagePimpinan untuk Pimpinan

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   String _errorMessage = '';
//   bool _isLoading = false;

  
//   String _userRole = ''; 

//   void _login() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     await Future.delayed(const Duration(seconds: 1));

//     if (_userRole == 'Dosen' &&
//         _usernameController.text == 'Fitria' &&
//         _passwordController.text == 'kitabisa') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(username: _usernameController.text),
//         ),
//       ); 
//     } else if (_userRole == 'Pimpinan' &&
//         _usernameController.text == 'Nur' &&
//         _passwordController.text == '12345678') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePagePimpinan(username: _usernameController.text),
//         ),
//       );
//     } else {
//       setState(() {
//         _errorMessage = 'Username atau Password salah';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           height: MediaQuery.of(context).size.height,
//           color: Colors.white,
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/logo_JTIpolinema.png', 
//                   height: 100,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'SIPaSTI',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 75, 93, 104),
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // Kotak Login dengan Border Biru
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 9, 85, 146), 
//                       width: 1.0, // Ketebalan garis biru
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         spreadRadius: 3,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'LOGIN',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 75, 93, 104),
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Radio Button untuk memilih peran
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Expanded(
//                               child: RadioListTile<String>(
//                                 dense: true,
//                                 contentPadding: EdgeInsets.zero,
//                                 title: const Text(
//                                   'Dosen',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 value: 'Dosen',
//                                 groupValue: _userRole,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _userRole = value!;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Expanded(
//                               child: RadioListTile<String>(
//                                 dense: true,
//                                 contentPadding: EdgeInsets.zero,
//                                 title: const Text(
//                                   'Pimpinan',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 value: 'Pimpinan',
//                                 groupValue: _userRole,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _userRole = value!;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 20),

//                         TextField(
//                           controller: _usernameController,
//                           decoration: InputDecoration(
//                             labelText: 'Username',
//                             hintText: 'Masukkan Username',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         TextField(
//                           controller: _passwordController,
//                           obscureText: !_isPasswordVisible,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             hintText: 'Masukkan Password',
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isPasswordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isPasswordVisible = !_isPasswordVisible;
//                                 });
//                               },
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                         if (_errorMessage.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Text(
//                               _errorMessage,
//                               style: const TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _isLoading ? null : _login,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue.shade700,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: _isLoading
//                                 ? const CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.white,
//                                   )
//                                 : const Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dosen/home_page.dart'; // Halaman tujuan setelah login

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _login() async {
    // Validasi Input
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Username dan Password harus diisi';
      });
      return; // Keluar dari fungsi jika input kosong
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('https://sipasti.cloud/api/login'); // API Login URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final user = data['user'];
          final token = data['token'];

          final String userId = user['user_id'] ?? '';
          final String userName = user['username'] ?? '';
          final String fullName = user['user_fullname'] ?? '';
          final String authToken = token ?? '';

          if (userId.isNotEmpty && authToken.isNotEmpty) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_id', userId);
            await prefs.setString('token', authToken);
            await prefs.setString('username', userName);
            await prefs.setString('user_fullname', fullName);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(username: userName),
              ),
            );
          } else {
            setState(() {
              _errorMessage = 'Data tidak lengkap dari server.';
            });
          }
        } else {
          setState(() {
            _errorMessage = data['message'] ?? 'Login gagal. Periksa kredensial Anda.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Username atau Password Anda Salah';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal menghubungi server: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo_JTIpolinema.png',
                  height: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  'SIPaSTI',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 75, 93, 104),
                  ),
                ),
                const SizedBox(height: 30),

                // Login Form Container
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 75, 93, 104),
                          ),
                        ),
                        const SizedBox(height: 20),

                       // Username Field
                        const Text(
                          'Username',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Username',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        const Text(
                          'Password',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Error Message
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B5ED7),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}