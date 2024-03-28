import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shoof24/models/iptv.dart'; // Import the model classes
import 'package:shoof24/utils/colors.dart';
import 'package:shoof24/widgets/customHeader.dart';
import 'package:shoof24/widgets/custom_live_cards_cats.dart';
import 'package:shoof24/widgets/custom_channel_card.dart'; // Import the ChannelCard widget
import 'package:shoof24/api/api_service.dart'; // Import the ApiService to fetch categories
import 'package:shoof24/models/iptv.dart';

class live extends StatefulWidget {
  List<ChannelLive> liveChannels;

  live({Key? key, required this.liveChannels}) : super(key: key); // Constructor takes a list of live channels

  @override
  _liveState createState() => _liveState();
}

class _liveState extends State<live> {
  List<CategoryModel> liveCategories = []; // List to store live categories
  bool isLoading = true; // Flag to track loading state
  String? selectedCategory; // Currently selected category
  bool updateListStatus = false; // Currently selected category

  List<ChannelLive> channelsList = [];

  @override
  void initState() {
    super.initState();
    fetchLiveCategories(); // Fetch live categories when the widget initializes
  }

  // Function to fetch live categories from the API
  void fetchLiveCategories() async {
    // Call the API service to fetch live categories
    List<CategoryModel> categories = await ApiService.getCategories('get_live_categories');
    setState(() {
      liveCategories = categories; // Update the state with fetched categories
      isLoading = false; // Update loading state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Container(
              child:  SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customHeader(),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  // Create CustomLiveCardsCats widgets based on liveCategories list
                                  for (CategoryModel category in liveCategories)
                                    Column(
                                      children: [
                                        CustomLiveCardsCats(
                                          catName: category.categoryName.toString(),
                                          imageUrl: '',
                                          onTap: () {
                                            setState(() {
                                              selectedCategory = category.categoryId;
                                              print(selectedCategory);
                                              updateListStatus = true;
                                              filterList();
                                            });
                                          },
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  // if(updateListStatus)
                                    for (ChannelLive channel in channelsList)
                                      Column(
                                        children: [
                                          ChannelCard(
                                            channelName: channel.name.toString(),
                                            imageUrl: '',
                                            // onTap: () {
                                            //   setState(() {
                                            //     selectedCategory = category;
                                            //   });
                                            // },
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  // Widgets for other columns if needed
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Loading overlay in the middle of the screen
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5), // Black matte opacity overlay
                child: Center(
                  child: CircularProgressIndicator(backgroundColor: AppColors.textColor,color: AppColors.primaryColor,strokeWidth: 2,), // Loading indicator
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  void filterList() {
    print('start filter');
    channelsList = [];
    for (ChannelLive channel in widget.liveChannels){
      if(channel.categoryId == selectedCategory){
        channelsList.add(channel);
      }
    }
  }
  
  
}