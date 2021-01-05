import 'package:epicture/api/images.dart';
import 'package:epicture/data/constants.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String imageHash) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK", style: TextStyle(color: primaryColor),),
    onPressed: () =>  deleteImage(context, imageHash),
  );

  Widget cancelButton = FlatButton(
    child: Text("Cancel", style: TextStyle(color: Colors.red)),
    onPressed: () => Navigator.of(context).pop(),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
    ),
    content: Text("Do you want to delete this image ?"),
    actions: [
      Container(
        width: 270,
        child: Row(
          children: [
            cancelButton,
            Spacer(),
            okButton,
          ],
        ),
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}