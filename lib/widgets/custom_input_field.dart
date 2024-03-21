import 'package:flutter/material.dart';
import 'package:shoof24/utils/colors.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool obscureText;
  final FocusNode focusNode;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.obscureText = false,
    required this.focusNode,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late FocusNode _focusNode;
  bool _isFakeField = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isFakeField = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    super.dispose();
  }

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
            SizedBox(height: 5),
            //Wrap TextField with GestureDetector to handle selection
            GestureDetector(
              child: _isFakeField
                  ? FakeTextField(
                      hintText: widget.hintText,
                      onTap: () {
                        setState(() {
                          _focusNode.requestFocus();
                          _isFakeField = false;
                        });
                      },
                    )
                  : TextField(
                      controller: widget.controller,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) {
                        setState(() {
                          _isFakeField = true;
                        });
                      },
                      focusNode: _focusNode,
                      obscureText: widget.obscureText,
                      style: const TextStyle(
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: const TextStyle(
                          color: AppColors.textColor,
                          fontFamily: 'cairo',
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textColor,
                            width: 1.0,
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

class FakeTextField extends StatefulWidget {
  final String hintText;
  final Function() onTap;

  const FakeTextField({
    Key? key,
    required this.hintText,
    required this.onTap,
  }) : super(key: key);

  @override
  _FakeTextFieldState createState() => _FakeTextFieldState();
}

class _FakeTextFieldState extends State<FakeTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        setState(() {
          _isFocused = true;
        });
      },
      child: Container(
        height: 50, // Set the height as needed
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          // color: _isFocused ? AppColors.primaryColor : Colors.transparent,
          border: Border(
            bottom: BorderSide(
                color: _isFocused
                    ? AppColors.primaryColor
                    : AppColors.primaryColor), // Only bottom border
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.hintText,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'cairo',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension KeyboardUtils on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
