import 'package:epicture/api/images.dart';
import 'package:epicture/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epicture/state/appstate.dart';

import 'footer-post.dart';

class Post extends StatefulWidget {
  final ImgurImage image;

  const Post({Key key, this.image}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Widget buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GeneralState>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(size.width / 35),
      height: ((widget.image.height * (size.width - (size.width / 35 * 2))) /
              widget.image.width) +
          size.height / 20,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 5,
            )
          ],
          image: DecorationImage(
              image: Image.network(widget.image.link,
                  cacheWidth: size.width.toInt(), loadingBuilder:
                      (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                if (loadingProgress == null)
                  return child;
                else
                  return buildCircularProgressIndicator();
              }).image,
              alignment: Alignment.topCenter)),
      child: FooterPost(widget: widget, provider: provider),
    );
  }
}