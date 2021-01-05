import 'package:epicture/api/images.dart';
import 'package:epicture/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:epicture/state/appstate.dart';

class TagPost extends StatefulWidget {
  final Tag tag;

  const TagPost({Key key, this.tag}) : super(key: key);

  @override
  _TagPostState createState() => _TagPostState();
}

class _TagPostState extends State<TagPost> {
  Widget buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    );
  }

  Text findDigitMillion(int nbPosts) {
    if (nbPosts >= 1000000)
      return (Text(nbPosts.toString().substring(0, 1) + "M+ ",
          style: TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center));
    else
      return (Text(nbPosts.toString(),
          style: TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GeneralState>(context, listen: false);
    return GestureDetector(
      onTap: () {
        provider.setLoaded(false);
        getImagesWithTag(context,
                'https://api.imgur.com/3/gallery/t/${widget.tag.name}/${provider.sortFilterItem}/${provider.windowFilterItem}/1')
            .then((value) {
          provider.setImagesListFeed(value);
          provider.setLoaded(true);
          Navigator.pop(provider.scaffoldKey.currentContext);
        });
      },
      child: Container(
          width: 105,
          height: 105,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 5,
                )
              ]),
          child: Column(
            children: [
              Container(
                width: 105,
                height: 105 * 2/3,
                child: Center(
                    child: Text(
                  widget.tag.displayName,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )), // titre du tag
              ),
              Container(
                  width: 105,
                  height: 105 / 3,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                      color: primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: findDigitMillion(widget.tag.nbPosts),
                      ),
                      SvgPicture.asset("assets/icons/gallery.svg",
                          width: 20, height: 20)
                    ],
                  ))
            ],
          )),
    );
  }
}
