import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoof24/models/user.dart'; // Import UserInfo class
import 'package:shoof24/screens/main/home.dart';
import 'package:shoof24/utils/colors.dart';
import 'package:shoof24/widgets/custom_input_field.dart';
import 'package:shoof24/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
  setState(() => isLoading = true);

  if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
    _showDialog(title: 'Error', message: 'Username and password are required.');
    setState(() => isLoading = false);
    return;
  }

  try {
    final response = await http.get(Uri.parse('http://shoof.watch:8000/player_api.php?username=${usernameController.text}&password=${passwordController.text}'));
    print(usernameController.text);
    print(passwordController.text);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['user_info']['auth'] == 1) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', usernameController.text);
        await prefs.setString('password', passwordController.text);

        final loginResponse = LoginResponse.fromJson(responseData);

        // Encode the UserInfo and ServerInfo objects using toJson before saving
        await prefs.setString('userData', json.encode(loginResponse.userInfo.toJson()));
        await prefs.setString('serverData', json.encode(loginResponse.serverInfo.toJson()));

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home())); // Make sure 'Home' is the correct class name
      } else {
        _showDialog(title: 'Error', message: 'Invalid username or password. Please try again.');
      }
    } else {
      _showDialog(title: 'Error', message: 'Failed to connect to the server. Please try again later.');
    }
  } catch (e) {
    _showDialog(title: 'Error', message: 'An error occurred: $e');
  } finally {
    setState(() => isLoading = false);
  }
}


  void _showDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.all(20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'أهلاً وسهلاً بكـ',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo',
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'في افضل منصة تلفزيون تفاعلي',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'cairo',
                          color: AppColors.textColor),
                    ),
                    const SizedBox(height: 50),
                    CustomInputField(
                      controller: usernameController,
                      hintText: '059* *** ***',
                      label: 'إسم المستخدم',
                      focusNode: usernameFocusNode,
                    ),
                    const SizedBox(height: 40),
                    CustomInputField(
                      controller: passwordController,
                      hintText: '*******',
                      label: 'كلمة المرور',
                      obscureText: true,
                      focusNode: passwordFocusNode,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'دخول',
                      onPressed: isLoading ? null : login,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          AppColors.backgroundColor.withOpacity(0.5),
                          AppColors.backgroundColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
