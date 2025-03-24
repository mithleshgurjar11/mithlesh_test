
import 'dart:io';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String verificationId = '';
  String errorMessage = '';
  String phoneNumber = '';
  String countryCode = '';

  String? _selectGender;


  String? get selectGender => _selectGender;

  void setGender(String selectedGender) {
    _selectGender = selectedGender;
    notifyListeners();
  }

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _passwordError;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String? get passwordError => _passwordError;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void validatePasswords(passwordController, confirmPasswordController) {
    if (passwordController.text != confirmPasswordController.text) {
      _passwordError = "Passwords do not match!";
    } else {
      _passwordError = null;
    }
    notifyListeners();
  }

  String? firstName;
  String? phone;
  String? email;
  String? password;
  String? gender;
  File? image;

  void updateUser({
    String? firstName,
    String? phone,
    String? email,
    String? password,
    String? gender,
    File? image,
  }) {
    this.firstName = firstName;
    this.phone = phone;
    this.email = email;
    this.password = password;
    this.gender = gender;
    this.image = image;
    notifyListeners();
  }

}