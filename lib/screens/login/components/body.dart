import 'package:epicture/data/constants.dart';
import 'login_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: primaryColor,
      padding: EdgeInsets.only(bottom: size.height / 4, top: size.height / 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: Image.asset("assets/logo.png").image),
            ),
          ),
          Spacer(),
          // Login button for login the user
          LoginButton(),
          // Developer description
          Text(
            "by Nathan and Matteo  🤙🏼",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
