import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoof24/utils/colors.dart';

class customHomeCards extends StatefulWidget {
  final String text;
  final String supText;
  final IconData icon;
  final String backgroundImage;
  final VoidCallback? onPressed;

  const customHomeCards({
    Key? key,
    required this.text,
    required this.supText,
    required this.icon,
    required this.backgroundImage,
    this.onPressed,
  }) : super(key: key);

  @override
  _customHomeCardsState createState() => _customHomeCardsState();
}

class _customHomeCardsState extends State<customHomeCards> {
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
        if (_focusNode.hasFocus && widget.onPressed != null) {
          widget.onPressed!();
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
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 200,
          height: 350,
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
            image: _isFocused
                ? DecorationImage(
                    image: AssetImage(widget.backgroundImage),
                    fit: BoxFit.cover,
                    opacity: 0.1)
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(20), // Remove internal padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      widget.icon,
                      size: 50,
                      color: AppColors.textColor.withOpacity(1),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'cairo',
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.supText,
                      style: const TextStyle(
                        fontFamily: 'cairo',
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w100,
                      ),
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
