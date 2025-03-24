import 'dart:convert';
import 'dart:io';
import 'package:demo/constants/app_constant.dart';
import 'package:demo/constants/color_resources.dart';
import 'package:demo/provider/user_provider.dart';
import 'package:demo/screen/auth/signup/sigup_widget.dart';
import 'package:demo/screen/home/home_screen.dart';
import 'package:demo/service/service.dart';
import 'package:demo/utils/styles.dart';
import 'package:demo/widgets/custom_app_bar.dart';
import 'package:demo/widgets/custom_button.dart';
import 'package:demo/widgets/custom_methods.dart';
import 'package:flutter/Material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode focusNodeFirstName = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeConfirmPassword = FocusNode();

  String? gender;
  File? _image;
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';
      final imageFile = await File(pickedFile.path).copy(imagePath);
      setState(() {
        _image = imageFile;
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /*Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final userData = {
        'firstName': firstNameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'gender': gender,
        'imagePath': _image?.path,
      };
      await prefs.setString('user_data', jsonEncode(userData));
      Provider.of<UserProvider>(context, listen: false).updateUser(
        firstName: firstNameController.text,
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
        gender: gender,
        image: _image,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }*/

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      List<String> users = prefs.getStringList('users') ?? [];
      List<Map<String, dynamic>> userList = users.map<Map<String, dynamic>>((e) => jsonDecode(e) as Map<String, dynamic>).toList();

      if (userList.any((user) => user['email'] == emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already registered. Please use another email.')),
        );
        return;
      }

      final newUser = {
        'firstName': firstNameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'gender': gender,
        'imagePath': _image?.path,
      };

      userList.add(newUser);
      prefs.setStringList('users', userList.map((e) => jsonEncode(e)).toList());
      print("Saved User: ${jsonEncode(newUser)}");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }




  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, UserProvider provider, _) {
      return Scaffold(
        appBar: customTitleAppBar(context,AppConstants.signup),
        body: SafeArea(
          child: Padding(
            padding: customPadding(),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: _showImagePicker,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null ? Icon(Icons.camera_alt, size: 50) : null,
                    ),
                  ),
                  heightSizedBox(20),
                  firstNameWidget(context, firstNameController, focusNodeFirstName),
                  heightSizedBox(20),
                  phoneNumberWidget(context, phoneController, focusNodePhone),
                  heightSizedBox(20),
                  emailWidget(context, emailController, focusNodeEmail),
                  heightSizedBox(20),
                  passwordWidget(context, provider, passwordController,focusNodePassword),
                  heightSizedBox(20),
                  confirmPasswordWidget(context, provider, confirmPasswordController, passwordController,focusNodeConfirmPassword),
                  heightSizedBox(20),
                  DropdownButtonFormField<String>(
                    value: gender,
                    decoration: InputDecoration(labelText: "Gender"),
                    items: ['Male', 'Female', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (value) => setState(() => gender = value),
                    validator: (value) => value == null ? 'Please select a gender' : null,
                  ),
                  heightSizedBox(70),
                  CustomButton(
                    textStyle: textXB.copyWith(color: ColorResources.whiteColor),
                    btnTxt: AppConstants.signup,
                    backgroundColor: ColorResources.primaryColor,
                    onTap: _saveData
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}


class SignupOneScreen extends StatefulWidget {
  const SignupOneScreen({super.key});

  @override
  State<SignupOneScreen> createState() => _SignupOneScreenState();
}

class _SignupOneScreenState extends State<SignupOneScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? gender;
  File? _image;
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      bool emailExists = await dbHelper.emailExists(emailController.text);

      if (emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already registered. Please use another email.')),
        );
        return;
      }

      final newUser = {
        'firstName': firstNameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'gender': gender,
        'imagePath': _image?.path,
      };

      await dbHelper.insertUser(newUser);
      print("Saved User: $newUser");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeOneScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: "First Name"),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone"),
                validator: (value) => value!.isEmpty ? "Enter phone number" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Enter email" : null,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) => value!.isEmpty ? "Enter password" : null,
              ),
              DropdownButtonFormField<String>(
                value: gender,
                decoration: InputDecoration(labelText: "Gender"),
                items: ['Male', 'Female', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => gender = value),
                validator: (value) => value == null ? 'Please select a gender' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



