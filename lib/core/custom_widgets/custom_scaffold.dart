import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String pageTitle;
  final Widget body;
  final Color backgroundColor;
  final Color appBarColor;
  final TextStyle? titleStyle;
  final bool automaticallyImplyLeading;

  const CustomScaffold({
    super.key,
    required this.pageTitle,
    required this.body,
    required this.backgroundColor,
    required this.appBarColor,
    required this.automaticallyImplyLeading,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Set background color of the scaffold
      resizeToAvoidBottomInset:
          true, // Avoids bottom inset when keyboard is open
      appBar: AppBar(
        elevation: 0, // Removes shadow from the AppBar
        backgroundColor: appBarColor, // Set background color of the AppBar
        automaticallyImplyLeading:
            automaticallyImplyLeading, // Controls the display of the back button
        title: Text(
          pageTitle,
          style: titleStyle ??
              const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Jost',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}
