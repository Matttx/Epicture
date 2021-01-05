import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyBottomNavBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<GeneralState>(context).navBarItemList[Provider.of<GeneralState>(context).selectedIndex],
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}


class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 0),
            blurRadius: 5)
      ]),
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomNavBarItem("assets/icons/home.svg", "assets/icons/home-green.svg", 0),
          Spacer(),
          BottomNavBarItem("assets/icons/add.svg", "assets/icons/add-green.svg", 1),
          Spacer(),
          BottomNavBarItem("assets/icons/star.svg", "assets/icons/star-green.svg", 2),
        ],
      ),
    );
  }

  Widget BottomNavBarItem(String asset, String toggleAsset, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            setState(() {
              Provider.of<GeneralState>(context, listen: false).setSelectedItem(index);
            });
          },
          child: SvgPicture.asset(
            index == Provider.of<GeneralState>(context).selectedIndex ? toggleAsset : asset,
            height: 24,
            width: 24,
          )),
    );
  }
}
