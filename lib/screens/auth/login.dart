// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
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
    usernameFocusNode.addListener(() {
      if (usernameFocusNode.hasFocus) {
        // Show the keyboard when the username field gets focus
        FocusScope.of(context).requestFocus(usernameFocusNode);
      }
    });
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        // Show the keyboard when the password field gets focus
        FocusScope.of(context).requestFocus(passwordFocusNode);
      }
    });
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> login() async {
    // Check if username or password is empty
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Username and password are required.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the login function if username or password is empty
    }

    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'http://shoof.watch:8000/player_api.php?username=${usernameController.text}&password=${passwordController.text}'));

    print(response);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['user_info']['auth'] == 1) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', usernameController.text);
        prefs.setString('password', passwordController.text);

        // Parse expiration date as int, assuming it's stored as a Unix timestamp
        int? expTimestamp =
            int.tryParse(responseData['user_info']['exp_date'] ?? '');
        if (expTimestamp != null) {
          // Convert Unix timestamp to DateTime
          DateTime expDate =
              DateTime.fromMillisecondsSinceEpoch(expTimestamp * 1000);
          // Format DateTime to a readable string format, e.g., "2023-01-01"
          String formattedExpDate =
              intl.DateFormat('yyyy-MM-dd').format(expDate);

          // Modify the user_info map to replace the timestamp with the formatted date string
          responseData['user_info']['exp_date'] = formattedExpDate;

          prefs.setString('userData', json.encode(responseData['user_info']));

          // Navigate to the home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  home(), // Ensure this is correctly referenced
            ),
          );
        } else {
          // Display error message for invalid expiration date format
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Invalid expiration date format.'),
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
      } else {
        // Display error message for authentication failure
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content:
                  const Text('Invalid username or password. Please try again.'),
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
    } else {
      // Display error message for HTTP request failure
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to connect to the server. Please try again later.'),
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

    setState(() {
      isLoading = false;
    });
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
