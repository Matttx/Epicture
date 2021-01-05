import 'package:epicture/data/constants.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRadioButton extends StatelessWidget {
  const MyRadioButton({
    Key key,
    @required this.value,
    @required this.category,
  }) : super(key: key);

  final String value;
  final String category;

  @override
  Widget build(BuildContext context) {
    var providerSetValue = Provider.of<GeneralState>(context, listen: false);
    var providerGetValue = Provider.of<GeneralState>(context);
    return Expanded(
      child: Row(
        children: [
          Radio(
              activeColor: primaryColor,
              value: value.toLowerCase(),
              groupValue: category == "window" ? providerGetValue.windowFilterItem :  providerGetValue.sortFilterItem,
              onChanged: (value) {
                category == "window"
                    ? providerSetValue.setWindowFilterItem(value)
                    : providerSetValue.setSortFilterItem(value);
              }),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}