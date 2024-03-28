import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shoof24/models/user.dart';
import 'package:shoof24/utils/colors.dart';

class CustomHomeCardsHorizontal extends StatefulWidget {
  final UserInfo userInfo;

  const CustomHomeCardsHorizontal({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  _CustomHomeCardsHorizontalState createState() =>
      _CustomHomeCardsHorizontalState();
}

class _CustomHomeCardsHorizontalState extends State<CustomHomeCardsHorizontal> {
  late FocusNode _focusNode;
  bool _isFocused = false;
    late String greetingMessage;


  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
        _updateGreetingMessage();

  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.select) {
        if (_focusNode.hasFocus) {
          // Handle key press event
        }
      }
    }
  }

  void _updateGreetingMessage() {
    final now = DateTime.now();
    if (now.hour < 12) {
      // AM
      greetingMessage = 'صباح الخير';
    } else {
      // PM
      greetingMessage = 'مساء الخير';
    }
  }

  @override
  Widget build(BuildContext context) {

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyPress,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 250,
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _isFocused
                    ? AppColors.primaryColor
                    : AppColors.lightBackgroundColor,
                _isFocused
                    ? AppColors.backgroundColor
                    : AppColors.lightBackgroundColor,
              ],
            ),
            borderRadius: BorderRadius.circular(0.0),
            border: Border.all(
              color: _isFocused ? AppColors.textColor : Colors.transparent,
              width: 0.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Handle onTap event
              },
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(20), // Remove internal padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              greetingMessage == 'صباح الخير'
                                  ? Icons.wb_sunny_outlined
                                  : Icons.nightlight_round,
                              size: 60,
                              color: AppColors.textColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$greetingMessage, ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'cairo',
                                color: AppColors.textColor,
                              ),
                            ),
                            Text(
                              widget.userInfo.username,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'cairo',
                                color: AppColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.textColor,
                            ),
                            const SizedBox(
                                width:
                                    8), // Add some space between icon and text
                            Text(
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              style: const TextStyle(
                                fontFamily: 'cairo',
                                color: AppColors.textColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: AppColors.textColor,
                            ),
                            const SizedBox(
                                width:
                                    8), // Add some space between icon and text
                            Text(
                              DateFormat('hh:mm').format(DateTime.now().toUtc().add(const Duration(hours: 2))),
                              style: const TextStyle(
                                fontFamily: 'cairo',
                                color: AppColors.textColor,
                              ),
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
        ),
      ),
    );
  }
}
