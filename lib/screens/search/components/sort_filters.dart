import 'package:flutter/material.dart';
import 'category_title.dart';
import 'my_radio_button.dart';

class SortFilters extends StatelessWidget {
  const SortFilters({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle(title: "Sort"),
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyRadioButton(value: "Viral", category: "sort",),
              MyRadioButton(value: "Top", category: "sort",),
              MyRadioButton(value: "Time", category: "sort",),
            ],
          ),
        ),
      ],
    );
  }
}
