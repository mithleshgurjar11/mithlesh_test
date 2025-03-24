import 'package:demo/provider/user_provider.dart';
import 'package:demo/screen/auth/signup/signup_screen.dart';
import 'package:demo/screen/home/home_screen.dart';
import 'package:demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');

    if (userDataString != null) {
      final userData = jsonDecode(userDataString);
      if (userData['email'] == emailController.text && userData['password'] == passwordController.text) {
        // Fluttertoast.showToast(msg: "Login Successful");
        customSnackBar(context, "Login Successful",);

        Provider.of<UserProvider>(context, listen: false).updateUser(
          firstName: userData['firstName'],
          phone: userData['phone'],
          email: userData['email'],
          password: userData['password'],
          gender: userData['gender'],
          image: userData['imagePath'] != null ? File(userData['imagePath']) : null,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        customSnackBar(context, "Invalid Email or Password",iSError: true);
      }
    } else {
      // Fluttertoast.showToast(msg: "Please Sign Up First");
      customSnackBar(context, "Please Sign Up First",iSError: true);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Enter email" : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) => value!.isEmpty ? "Enter password" : null,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _login,
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                ),
                child: Text("Don't have an account? Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

