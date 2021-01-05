import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchTextInput extends StatefulWidget {
  @override
  _SearchTextInputState createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<SearchTextInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.only(top: 17),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 2,
              color: Colors.grey,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child: SvgPicture.asset("assets/icons/search.svg",
                  width: 15, height: 15)
          ),
          Expanded(
            child: TextField(
              controller: Provider.of<GeneralState>(context).controller,
              decoration: InputDecoration(
                hintText: "Rechercher",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
