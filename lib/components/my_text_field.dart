import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData icon;
  final bool fill;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    required this.fill,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  Color textColor = Colors.red; // Initialize text color to red

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateTextColor); // Listen for text changes
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTextColor); // Remove listener
    super.dispose();
  }

  void _updateTextColor() {
    // Update text color based on text input
    setState(() {
      textColor = widget.controller.text.isNotEmpty ? Colors.blue : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: TextStyle(color: textColor), // Set text color dynamically
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Colors.grey[100],
        filled: widget.fill,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(widget.icon),
      ),
    );
  }
}
