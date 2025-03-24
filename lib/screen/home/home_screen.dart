import 'dart:convert';
import 'dart:io';

import 'package:demo/constants/color_resources.dart';
import 'package:demo/provider/home_provider.dart';
import 'package:demo/widgets/custom_app_bar.dart';
import 'package:demo/widgets/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

/*  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('user_data');
    if (data != null) {
      setState(() {
        userData = jsonDecode(data);
      });
    }
  }*/

  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Future<void> _loadUsers() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> usersData = prefs.getStringList('users') ?? [];
  //
  //   setState(() {
  //     users = usersData.map<Map<String, dynamic>>((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  //   });
  // }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> usersData = prefs.getStringList('users') ?? [];
    setState(() {
      users = usersData.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    });

    for (var user in users) {
      print("User: ${user['firstName']}, ImagePath: ${user['imagePath']}");
    }
  }




  Future<void> _deleteUser(int index) async {
    final prefs = await SharedPreferences.getInstance();
    users.removeAt(index);
    prefs.setStringList('users', users.map((e) => jsonEncode(e)).toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, HomeProvider provider, _) {
      return Scaffold(
        appBar: customTitleAppBar(context,"User List"),
      body: ListView.builder(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
              padding: customPadding(10),
              margin: customPadding(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorResources.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                    color: ColorResources.blackColor.withOpacity(0.1),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: user['imagePath'] != null
                        ? FileImage(File(user['imagePath']))
                        : null,
                    key: UniqueKey(),
                    child: user['imagePath'] == null ? Icon(Icons.person) : null,
                  ),
                  widthSizedBox(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${user['firstName']}", style: TextStyle(fontSize: 18)),
                      Text("${user['phone']}", style: TextStyle(fontSize: 18)),
                      Text("${user['email']}", style: TextStyle(fontSize: 18)),
                      Text("${user['gender']}", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Icon(Icons.edit),
                      heightSizedBox(30),
                      InkWell(
                        onTap: () => _deleteUser(index),
                          child: Icon(Icons.delete_forever,color: Colors.red,)
                      ),
                    ],
                  )
                ],
              )
          );
        },
      ),

      /*  body: users == null
            ? Center(child: Text("No Data Available"))
            : ListView(
          padding: EdgeInsets.all(16),
          children: [
            */
        /*Container(
              padding: customPadding(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorResources.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                    color: ColorResources.blackColor.withOpacity(0.1),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  userData!['imagePath'] != null
                      ? CircleAvatar(radius: 35, backgroundImage: FileImage(File(userData!['imagePath'])))
                      : CircleAvatar(radius: 35, child: Icon(Icons.person)),
                  widthSizedBox(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Name: ${userData!['firstName']}", style: TextStyle(fontSize: 18)),
                      Text("Phone: ${userData!['phone']}", style: TextStyle(fontSize: 18)),
                      Text("Email: ${userData!['email']}", style: TextStyle(fontSize: 18)),
                      Text("Gender: ${userData!['gender']}", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.edit),
                      Icon(Icons.delete_forever),
                    ],
                  )
                ],
              )
            ),*/
        /*
            ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: user['imagePath'] != null ? CircleAvatar(backgroundImage: FileImage(File(user['imagePath']))) : CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user['firstName']),
                  subtitle: Text(user['email']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteUser(index),
                  ),
                );
              },
            ),
          ],
        ),*/
      );
    }
    );
  }
}
