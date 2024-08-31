import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/app_color.dart';

class DateTimeTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final int maxLines;
  final VoidCallback onTap;

  const DateTimeTextField({
    super.key,
    this.maxLines = 1,
    this.suffixIcon,
    this.controller,
    required this.onTap,
  });

  @override
  State<DateTimeTextField> createState() => _DateTimeTextFieldState();
}

class _DateTimeTextFieldState extends State<DateTimeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap, // Trigger date/time picker
      readOnly: true,
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        fillColor: AppColor.offWhite,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.pink,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.pink,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
