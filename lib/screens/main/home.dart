import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoof24/utils/colors.dart';

class home extends StatelessWidget {
  // Since SharedPreferences is async, we use a method to get user data
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return json.decode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Logo placeholder - replace with your actual logo widget if available
            const Placeholder(
              color: AppColors.backgroundColor,
            ),
            SizedBox(width: 16), // Spacer
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('EEE, MMM d, yyyy').format(DateTime.now()),
                  style: TextStyle(color: AppColors.textColor, fontSize: 15),
                ),
                FutureBuilder<Map<String, dynamic>?>(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                          color: AppColors.textColor);
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return Text('Error loading data',
                          style: TextStyle(
                              color: AppColors.textColor, fontSize: 15));
                    } else {
                      final userData = snapshot.data;
                      // Assuming 'exp_date' is the key where expiration date is stored. Adjust if necessary.
                      final expirationDate = userData?['exp_date'] ?? 'Unknown';
                      return Text(
                        'Expiration Date: $expirationDate',
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 15),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background
          Container(
            color: Colors.black, // Dark background color
          ),

          // Four button boxes in the middle
          Positioned(
            top: 100, // Adjust the position as needed
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButtonBox('Live', Icons.live_tv),
                _buildButtonBox('Movies', Icons.movie),
                _buildButtonBox('Sport', Icons.sports_soccer),
                _buildButtonBox('Series', Icons.tv),
              ],
            ),
          ),
          // Scrollable list on the right for last watched
          Positioned(
            top: 200, // Adjust the position as needed
            right: 16,
            bottom: 16,
            child: Container(
              width: 200, // Adjust the width as needed
              color: Colors.white, // Background color for the list
              child: ListView(
                children: [
                  ListTile(title: Text('Last Watched 1')),
                  ListTile(title: Text('Last Watched 2')),
                  ListTile(title: Text('Last Watched 3')),
                  ListTile(title: Text('Last Watched 4')),
                  // Add more list items as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to fetch user info from shared preferences
  Future<String> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Replace 'expirationDateKey' with the actual key you used to store expiration date
    String? expirationDate = prefs.getString('expirationDateKey');
    return expirationDate ?? 'Unknown';
  }

  // Method to build a button box widget
  Widget _buildButtonBox(String text, IconData icon) {
    return Container(
      width: 100, // Adjust the width as needed
      height: 100, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.white, // Box background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40), // Icon
          SizedBox(height: 8),
          Text(text), // Text
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: home(),
  ));
}
