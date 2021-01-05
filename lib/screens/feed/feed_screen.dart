import 'package:epicture/screens/feed/components/body.dart';
import 'package:epicture/screens/search/search_screen.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../data/constants.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GeneralState>(context, listen: false);
    // Get the gallery album from Imgur API
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(
          apiLink:
              'https://api.imgur.com/3/gallery/hot/${provider.sortFilterItem}/${provider.windowFilterItem}/1?showViral=true&mature=false&album_previews=false'),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    // Navigation to the Search screen with transition
    void goToSearchScreen(BuildContext context) {
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionsBuilder: (context, animation, secAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }, pageBuilder: (context, animation, secAnimation) {
            return SearchScreen();
          }));
    }

    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text(
        "Feed",
        style: TextStyle(fontSize: headerTextSize, color: Colors.black),
      ),
      actions: [
        // Define an IconButton on the header
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              if (Provider.of<GeneralState>(context, listen: false).tagsList == null) {
                Provider.of<GeneralState>(context, listen: false)
                    .setLoaded(false);
              }
              goToSearchScreen(context);
            },
            // Set the widget icon and its size
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              width: 20,
              height: 20,
            )),
      ],
    );
  }
}
