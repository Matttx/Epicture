import 'package:epicture/components/my_bottom_nav_bar.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:provider/provider.dart';

final clientId = "be1f302ff467d27";
final clientSecret = "6e9a9d31eb4b8dcdcf954be0c70ebcafae2ab1d7";
final callbackUrlScheme = "com.example.epicture";

Future<String> authenticate(BuildContext context) async {
  var provider = Provider.of<GeneralState>(context, listen: false);

  final url = Uri.https('api.imgur.com', '/oauth2/authorize', {
    'response_type': 'token',
    'client_id': clientId,
  });

  await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: callbackUrlScheme)
      .then((result) {
    var newUrl = result.replaceAll('#', '?');
    final accessToken = Uri.parse(newUrl).queryParameters['access_token'];
    final refreshToken = Uri.parse(newUrl).queryParameters['refresh_token'];
    provider.setAccessToken(accessToken);
    provider.setRefreshToken(refreshToken);
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyBottomNavBarPage()));
  }).catchError((error) => null);
}
