import 'package:flutter/material.dart';
import '../../../data/constants.dart';
import 'authenticate.dart';

class LoginButton extends StatefulWidget {

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          authenticate(context);
        },
        child: Container(
          width: size.width - 50,
          height: 50,
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 6,
                    color: Colors.grey[600])
              ]),
          child: Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 25, color: primaryColor),
              )),
        ),
      ),
    );
  }
}
