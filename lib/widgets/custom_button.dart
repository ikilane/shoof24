import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoof24/utils/colors.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late FocusNode _focusNode;

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
    setState(() {}); // Rebuild the widget when focus changes
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.select) {
        // If "OK" button is pressed, trigger onPressed callback
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
            // Update the focus state
          });
        },
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              _focusNode.hasFocus
                  ? AppColors.primaryColor
                  : AppColors.primaryColor,
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.primaryColor.withOpacity(0.1);
                }
                return Colors.transparent;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: _focusNode.hasFocus
                      ? AppColors.textColor
                      : Colors.transparent,
                  width: 1.0,
                ),
              ),
            ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: AppColors.backgroundColor,
              fontFamily: 'cairo',
            ),
          ),
        ),
      ),
    );
  }
}
