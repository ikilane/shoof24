import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class customHeader extends StatelessWidget implements PreferredSizeWidget {
  const customHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current date and time
    DateTime now = DateTime.now();
    // Format date and time using intl.DateFormat
    String formattedDateTime =
        intl.DateFormat('yyyy-MM-dd | HH:mm').format(now);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: preferredSize.height,
        color: Colors.transparent, // Set background to transparent
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Time and Date on the left
            Text(
              formattedDateTime,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            // Logo and Search Icon on the right
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Implement the search functionality here
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  isAntiAlias: true,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(60); // Adjust the height as needed
}
