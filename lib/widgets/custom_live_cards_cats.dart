import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:marquee/marquee.dart';
import 'package:shoof24/utils/colors.dart';

class CustomLiveCardsCats extends StatefulWidget {
  final String imageUrl;
  final String catName;
  final VoidCallback onTap; // Add this line

  const CustomLiveCardsCats({
    Key? key,
    required this.imageUrl,
    required this.catName,
    required this.onTap, // Add this line
  }) : super(key: key);

  @override
  _CustomLiveCardsCatsState createState() => _CustomLiveCardsCatsState();
}

class _CustomLiveCardsCatsState extends State<CustomLiveCardsCats> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
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
          duration: const Duration(milliseconds: 1000), // Animation duration
          curve: Curves.easeInOut, // Animation curve
          child: Transform.scale(
            scale: _isFocused ? 1.1 : 1.0, // Scale factor when focused
            child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200), // Animation duration
            opacity: _isFocused ? 1.0 : 0.3, // Opacity when focused
            curve: Curves.easeInOut, // Animation curve
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 250,
                height: 100,
                decoration: BoxDecoration(
                  color: _isFocused ? AppColors.backgroundColor : AppColors.backgroundColor,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      widget.onTap();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            backgroundImage: widget.imageUrl.isNotEmpty ? NetworkImage(widget.imageUrl) : AssetImage('assets/images/placeholder.png') as ImageProvider,
                            child: _isFocused
                                ? Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.textColor.withOpacity(0.5), width: 1.5),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 5),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Expanded(
                              child: _isFocused
                                  ? Marquee(
                                      text: widget.catName,
                                      blankSpace: 20.0,
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      accelerationDuration: Duration(milliseconds: 500),
                                      accelerationCurve: Curves.easeOut,
                                      decelerationDuration: Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeIn,
                                      pauseAfterRound: Duration(seconds: 1),
                                      
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'cairo',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColor.withOpacity(1.0),
                                      ),
                                    )
                                  : Text(
                                      widget.catName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'cairo',
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textColor.withOpacity(0.5),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
