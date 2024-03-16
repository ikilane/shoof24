import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Stack(
        children: [
          // Background
          Container(
            color: Colors.black, // Dark background color
          ),
          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo (replace the placeholder with your logo widget)
                  CustomBox(
                    width: 100,
                    height: 50,
                    color: Colors.white,
                  ),
                  // Day and time
                  Text(
                    DateFormat('EEE, MMM d, yyyy HH:mm').format(DateTime.now()),
                    style: TextStyle(color: Colors.white),
                  ),
                  // Expiration date (replace 'getUserInfo' with your actual method)
                  FutureBuilder<String>(
                    future: getUserInfo(), // Fetch user info asynchronously
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While data is being fetched, show a loading indicator
                        return CircularProgressIndicator(color: Colors.white);
                      } else if (snapshot.hasError) {
                        // If there's an error fetching data, display an error message
                        return Text('Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.white));
                      } else {
                        // If data is fetched successfully, display expiration date
                        final expirationDate = snapshot.data;
                        return Text(
                          'Expiration Date: $expirationDate',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
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

class CustomBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const CustomBox({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: home(),
  ));
}
