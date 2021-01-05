import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/constants.dart';
import 'components/body.dart';
import 'package:provider/provider.dart';

import 'components/search_button.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var providerGetValue = Provider.of<GeneralState>(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: buildAppBar(context),
        body: Body(),
        floatingActionButton: SearchButton(
            sortFilterItem: providerGetValue.sortFilterItem,
            windowFilterItem: providerGetValue.windowFilterItem),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        key: Provider.of<GeneralState>(context).scaffoldKey);
  }

  void resetFilters() {
    var provider = Provider.of<GeneralState>(context, listen: false);

    if (provider.controller.text.length > 0) {
      provider.controller.clear();
    }
    provider.setSortFilterItem("viral");
    provider.setWindowFilterItem("top");
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Text(
        "Search",
        style: TextStyle(fontSize: headerTextSize, color: Colors.black),
      ),
      leading: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          "assets/icons/cancel.svg",
          height: 16,
          width: 16,
        ),
      ),
      actions: [
        FlatButton(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onPressed: resetFilters,
            child: Text(
              "Reset",
              style: TextStyle(fontSize: headerTextSize),
            ))
      ],
    );
  }
}
