import 'package:flutter/material.dart';

class customHeader extends StatelessWidget implements PreferredSizeWidget {
  const customHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: preferredSize.height,
        color: Colors.transparent, // Set background to transparent
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  isAntiAlias: true,
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 1, // Divider width
                  height: 20, // Divider height
                  color: Colors.grey, // Divider color
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: onBackPressed, // Call local function
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(60); // Adjust the height as needed
}

void onBackPressed() {
  // Implement functionality for back button
}
