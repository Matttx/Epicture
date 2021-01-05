import 'package:flutter/material.dart';
import '../../../data/constants.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
                fontSize: searchCategoryTextSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          )),
    );
  }
}
