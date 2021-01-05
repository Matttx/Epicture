
import 'package:epicture/screens/favorites/components/body.dart';
import 'package:flutter/material.dart';
import '../../data/constants.dart';

// ignore: must_be_immutable
class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(apiLink: 'https://api.imgur.com/3/account/me/gallery_favorites/'),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    // Navigation to the Search screen with transition

    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text(
        "Favorites",
        style: TextStyle(fontSize: headerTextSize, color: Colors.black),
      ),
    );
  }
}
