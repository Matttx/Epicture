import 'package:epicture/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/appstate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Define a ChangeNotifierProvider to have an appState
    // instead of using Stateful Widget
    // GeneralState is the container of all variable.
    return ChangeNotifierProvider<GeneralState>(
      create: (context) => GeneralState(),
      child: MaterialApp(
        title: 'Epicture',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
