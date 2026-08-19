import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:my_first_app/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'registration.dart';
import 'home.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
var store = GetStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    usernameController.text = store.read("username") ?? "";
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text("Calorie app"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image.asset("logo.png", height: 200, width: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://th.bing.com/th/id/OIP.lVCKwwCQi5a8ZJpqKk-KpAAAAA?w=161&h=180&c=7&r=0&o=7&pid=1.7&rm=300",
                  height: 200,
                  width: 400,
                ),
              ],
            ),
            Text(
              "Username:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.teal.shade700,
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  tooltip: _showPassword ? 'Hide password' : 'Show password',
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() => _showPassword = !_showPassword);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () async {
                    final email = usernameController.text;
                    final password = passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                        ),
                      );
                      return;
                    }

                    try {
                      final response = await http.post(
                        Uri.parse('http://127.0.0.1:80/my_first_app/login.php'),
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({
                          'email': email,
                          'password': password,
                        }),
                      );

                      final serverResponse = jsonDecode(response.body);
                      if (serverResponse['success'] == true) {
                        // Store user data
                        store.write(
                          'username',
                          serverResponse['user']['firstname'] ?? email,
                        );
                        store.write('userid', serverResponse['user']['id']);
                        store.write('email', serverResponse['user']['email']);
                        store.write('isLoggedIn', true);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Welcome ${serverResponse['user']['firstname']}!',
                            ),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Login failed: ${serverResponse['message']}',
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  color: Colors.teal,
                  textColor: Colors.white,
                  height: 50,
                  minWidth: 200,
                  child: const Text("Login"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Not registered? Sign Up",
                    style: TextStyle(color: secondaryColor),
                  ),
                ),
                Spacer(),
                Text(
                  "Forgot Password? Reset",
                  style: TextStyle(color: secondaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
