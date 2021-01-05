import 'package:epicture/data/constants.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    return Scaffold(
      appBar: AppBar(
        // Define the color's status bar
        brightness: Brightness.dark,
        backgroundColor: primaryColor,
        // Set the shadow of the appbar to null
        elevation: 0,
      ),
      body: Body(),
    );
  }
}