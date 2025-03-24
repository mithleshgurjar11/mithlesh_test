import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void showLoader(){
    _isLoading = true;
    notifyListeners();
  }

  void hideLoader(){
    _isLoading = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> users = [];

  Future<void> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> usersData = prefs.getStringList('users') ?? [];
    users = usersData.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    notifyListeners(); // UI Refresh karega
  }

  Future<void> updateUser(Map<String, dynamic> updatedUser, int index) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> usersData = prefs.getStringList('users') ?? [];
    List<Map<String, dynamic>> userList = usersData.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

    userList[index] = updatedUser;

    List<String> updatedUsers = userList.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('users', updatedUsers);

    users = userList;
    notifyListeners(); // 🔹 UI update karega
  }
}