import 'dart:io';

import 'package:flutter/Material.dart';

class EditUserScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final int index;
  final Function(Map<String, dynamic>, int) onUpdate; // Callback to update user

  EditUserScreen({required this.user, required this.index, required this.onUpdate});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController firstNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late String gender;
  late String? imagePath;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user['firstName']);
    phoneController = TextEditingController(text: widget.user['phone']);
    emailController = TextEditingController(text: widget.user['email']);
    gender = widget.user['gender'];
    imagePath = widget.user['imagePath'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Show User Image
            CircleAvatar(
              radius: 50,
              backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
              child: imagePath == null ? Icon(Icons.person, size: 50) : null,
            ),
            SizedBox(height: 20),

            // Name Field
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            SizedBox(height: 10),

            // Phone Field
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),

            // Email Field (Disabled)
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              enabled: false, // Email should not be editable
            ),
            SizedBox(height: 10),

            // Gender Selection
            DropdownButton<String>(
              value: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
              items: ["Male", "Female"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
            SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> updatedUser = {
                  'firstName': firstNameController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                  'gender': gender,
                  'imagePath': imagePath, // Keep existing image
                };
                widget.onUpdate(updatedUser, widget.index);
                Navigator.pop(context);
              },
              child: Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}


class EditUserDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final int index;
  final Function(Map<String, dynamic>, int) onUpdate;

  EditUserDetailsScreen({required this.user, required this.index, required this.onUpdate});

  @override
  _EditUserDetailsScreenState createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  late TextEditingController firstNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  String? gender;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user['firstName']);
    phoneController = TextEditingController(text: widget.user['phone']);
    emailController = TextEditingController(text: widget.user['email']);
    gender = widget.user['gender'];
    imagePath = widget.user['imagePath'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 🖼 Profile Image
            CircleAvatar(
              radius: 40,
              backgroundImage: imagePath != null && imagePath!.isNotEmpty
                  ? FileImage(File(imagePath!))
                  : AssetImage('assets/default_user.png') as ImageProvider,
            ),
            SizedBox(height: 10),

            // 📛 First Name
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),

            // 📞 Phone Number
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),

            // 📧 Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),

            // 🚻 Gender Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text("Male"),
                Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text("Female"),
              ],
            ),

            SizedBox(height: 20),

            // ✅ Save Button
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> updatedUser = {
                  'firstName': firstNameController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                  'gender': gender,
                  'imagePath': imagePath,
                };

                widget.onUpdate(updatedUser, widget.index);
                Navigator.pop(context);
              },
              child: Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}
