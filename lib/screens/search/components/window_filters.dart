import 'package:flutter/material.dart';

import 'category_title.dart';
import 'my_radio_button.dart';

class WindowFilters extends StatelessWidget {
  const WindowFilters({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle(title: "Window"),
        Container(
          height: 100,
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyRadioButton(value: "Top", category: "window",),
                    MyRadioButton(value: "Day", category: "window",),
                    MyRadioButton(value: "Week", category: "window",),
                  ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyRadioButton(value: "Month", category: "window",),
                  MyRadioButton(value: "Year", category: "window",),
                  MyRadioButton(value: "All", category: "window",),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}