import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool obscureText;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white, // Set the cursor color to white
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl, // Set the text direction to RTL
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Small label
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'cairo',
              ),
            ),
            // Wrap TextField with GestureDetector to handle selection
            GestureDetector(
              child: TextField(
                controller: widget.controller,
                textInputAction: TextInputAction.next,
                autofocus: true,
                obscureText: widget.obscureText,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.right, // Align text to the right
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'cairo',
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white, // Set the color of the border
                      width: 1.0, // Set the width of the border
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors
                          .white, // Set the color of the border when focused
                      width: 1.0, // Set the width of the border
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
