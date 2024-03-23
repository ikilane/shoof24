import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoof24/utils/colors.dart';
import 'package:shoof24/widgets/custom_home_cards.dart';
import 'package:shoof24/widgets/custom_home_cards_horizontal.dart';

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

  void onBackPressed() {
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpeg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 18, 18, 18),
                    Color.fromARGB(240, 18, 18, 18),
                    Color.fromARGB(255, 18, 18, 18),
                    Color.fromARGB(200, 18, 18, 18),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align children to the start
                    children: [
                      const SizedBox(height: 50),
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
                      const Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customHomeCards(
                                text: 'مـبـاشـر',
                                supText: '1000',
                                icon: Icons.live_tv_rounded,
                                backgroundImage:
                                    'assets/images/homeCards/Live.png',
                              ),
                              SizedBox(width: 15),
                              customHomeCards(
                                text: 'مسلسلات',
                                supText: '1000',
                                icon: Icons.movie_outlined,
                                backgroundImage:
                                    'assets/images/homeCards/series.png',
                              ),
                              SizedBox(width: 15),
                              customHomeCards(
                                text: 'أفـــلام',
                                supText: '1000',
                                icon: Icons.local_movies_outlined,
                                backgroundImage:
                                    'assets/images/homeCards/movies.png',
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customHomeCardsHorizontal(
                                text: 'مـبـاشـر',
                                supText: '1000',
                                icon: Icons.live_tv_rounded,
                                backgroundImage:
                                    'assets/images/homeCards/Live.png',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
}
