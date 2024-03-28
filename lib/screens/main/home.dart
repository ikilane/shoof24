import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoof24/models/iptv.dart';
import 'package:shoof24/models/user.dart';
import 'package:shoof24/screens/auth/login.dart';
import 'package:shoof24/screens/main/live.dart';
import 'package:shoof24/utils/colors.dart';
import 'package:shoof24/widgets/custom_home_cards.dart';
import 'package:shoof24/widgets/custom_home_cards_horizontal.dart';
import 'package:shoof24/api/api_service.dart'; // Import ApiService

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int liveChannelsCount = 0;
  int movieChannelsCount = 0;
  int seriesChannelsCount = 0;

  List<ChannelLive> liveChannels = [];
  List<ChannelLive> movieChannels = [];
  List<ChannelLive> seriesChannels = [];

  Future<UserInfo> getUserInfoFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userDataString);
      UserInfo userInfo = UserInfo.fromJson(userDataMap);
      return userInfo;
    } else {
      throw Exception('User data not found in shared preferences.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChannelsCounts(); // Call method to fetch channels counts
  }

  // Method to fetch channels counts from ApiService
  Future<void> fetchChannelsCounts() async {
    bool countsFetched = false;

    while (!countsFetched) {
      try {
        // Fetch live channels count
        liveChannels = await ApiService.fetchLiveChannels();
        if (liveChannels.isNotEmpty) {
          setState(() {
            liveChannelsCount = liveChannels.length;
          });
        }

        // // Fetch movie channels count
        // movieChannels = await ApiService.fetchMovieChannels();
        // if (movieChannels.isNotEmpty) {
        //   setState(() {
        //     movieChannelsCount = movieChannels.length;
        //   });
        // }

        // // Fetch series channels count
        // seriesChannels =
        //     await ApiService.fetchSeriesChannels();
        // if (seriesChannels.isNotEmpty) {
        //   setState(() {
        //     seriesChannelsCount = seriesChannels.length;
        //   });
        // }

        // Check if all counts are fetched and not equal to zero
        if (liveChannels.isNotEmpty) {
          countsFetched = true;
        }
      } catch (e) {
        print('Error fetching channels counts: $e');
        // Delay before retrying
        await Future.delayed(const Duration(minutes: 1)); // Retry every 1 minute
      }
    }
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
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customHomeCards(
                                text: 'مـبـاشـر',
                                supText: liveChannelsCount, // Update subtext
                                icon: Icons.live_tv_rounded,
                                backgroundImage:
                                    'assets/images/homeCards/Live.png',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          live(liveChannels: liveChannels),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.easeInOut;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 15),
                              customHomeCards(
                                text: 'مسلسلات',
                                supText: movieChannelsCount, // Update subtext
                                icon: Icons.movie_outlined,
                                backgroundImage:
                                    'assets/images/homeCards/series.png',
                              ),
                              const SizedBox(width: 15),
                              customHomeCards(
                                text: 'أفـــلام',
                                supText: seriesChannelsCount, // Update subtext
                                icon: Icons.local_movies_outlined,
                                backgroundImage:
                                    'assets/images/homeCards/movies.png',
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 168),
                              FutureBuilder<UserInfo>(
                                future: getUserInfoFromPrefs(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    UserInfo userInfo = snapshot.data!;
                                    return CustomHomeCardsHorizontal(
                                        userInfo: userInfo);
                                  }
                                },
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

  void onBackPressed() {
    // Implement functionality for back button
  }
}
