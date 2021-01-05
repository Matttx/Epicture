import 'package:epicture/api/images.dart';
import 'package:epicture/data/constants.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:epicture/screens/upload/components/body.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(apiLink: 'https://api.imgur.com/3/account/me/images'),
      key: Provider.of<GeneralState>(context).scaffoldKey,
    );
  }

  void _uploadImage() {
    picker.getImage(source: ImageSource.gallery).then((value) {
      setState(() {
        if (value != null) {
          _image = File(value.path);
          uploadImages(context, 'https://api.imgur.com/3/upload',
              base64.encode(_image.readAsBytesSync()));
        } else {
          print('No image selected.');
        }
      });
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Text(
        "Upload",
        style: TextStyle(fontSize: headerTextSize, color: Colors.black),
      ),
      actions: [
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: _uploadImage,
            // Set the widget icon and its size
            icon: SvgPicture.asset(
              "assets/icons/plus.svg",
              width: 20,
              height: 20,
            )),
      ],
    );
  }
}
