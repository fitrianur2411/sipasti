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
import 'Dosen/home_page.dart';
import 'Pimpinan/homepagepimpinan.dart';

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
  String _userRole = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('https://sipasti.cloud/api/login');

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

          // Simpan user_id dan token ke SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', user['user_id']); // user_id disimpan sebagai String
          await prefs.setString('token', token);

          // Navigasi berdasarkan peran pengguna
          if (_userRole == 'Dosen') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(username: user['username']),
              ),
            );
          } else if (_userRole == 'Pimpinan') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePagePimpinan(username: user['username']),
              ),
            );
          } else {
            setState(() {
              _errorMessage = 'Silakan pilih peran user terlebih dahulu.';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Login gagal. Periksa kredensial Anda.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server Error. Coba lagi nanti.';
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
                Image.asset(
                  'assets/logo_JTIpolinema.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'SIPaSTI',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 75, 93, 104),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 9, 85, 146),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
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
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 75, 93, 104),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text(
                                  'Dosen',
                                  style: TextStyle(fontSize: 15), 
                                ),
                                value: 'Dosen',
                                groupValue: _userRole,
                                onChanged: (value) {
                                  setState(() => _userRole = value!);
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text(
                                  'Pimpinan',
                                  style: TextStyle(fontSize: 14), 
                                ),
                                value: 'Pimpinan',
                                groupValue: _userRole,
                                onChanged: (value) {
                                  setState(() => _userRole = value!);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
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
                                      fontSize: 18,
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
