import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoof24/screens/auth/login.dart';
import 'package:shoof24/screens/main/home.dart'; // Import the home page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          title: 'Shoof | شوف',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder<bool>(
            future: isLoggedIn(), // Check if user is already logged in
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While checking user login state, show a loading indicator
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                // If there's an error checking login state, display an error message
                return Scaffold(
                    body: Center(child: Text('Error: ${snapshot.error}')));
              } else {
                // If user is logged in, show home page; otherwise, show login page
                return snapshot.data! ? home() : LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }

  // Method to check if user is already logged in (based on stored user data)
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if there is stored user data
    // Replace 'userData' with the actual key you used to store user data
    return prefs.containsKey('userData') && prefs.getString('userData') != null;
  }
}
