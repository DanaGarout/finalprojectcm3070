import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/app_color.dart';

class AddTaskTextfieldWidget extends StatefulWidget {
  final int maxLines;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const AddTaskTextfieldWidget({
    super.key,
    this.maxLines = 1,
    this.suffixIcon,
    this.controller,
  });

  @override
  State<AddTaskTextfieldWidget> createState() => _AddTaskTextfieldWidgetState();
}

class _AddTaskTextfieldWidgetState extends State<AddTaskTextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
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
