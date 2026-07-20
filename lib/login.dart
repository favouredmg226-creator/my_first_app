import 'package:my_first_app/configs/colors.dart';
import 'package:flutter/material.dart';
import 'registration.dart';
import 'dashboard.dart';
import 'home.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calorie app"),
          backgroundColor: primaryColor,
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
                  color: secondaryColor,
                ),
              ),
              TextField(
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
                  color: secondaryColor,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    color: primaryColor,
                    height: 50,
                    minWidth: 200,
                    child: Text("Login"),
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
                        MaterialPageRoute(builder: (context) => const RegistrationPage()),
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
        )
        );
        }
}