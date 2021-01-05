import 'package:flutter/material.dart';
import 'package:epicture/api/images.dart';
import 'package:epicture/components/post.dart';
import 'package:epicture/data/constants.dart';
import 'package:epicture/state/appstate.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final String apiLink;

  const Body({Key key, this.apiLink}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getImages(context, widget.apiLink, null).then((value) {
          if (context != null) {
            Provider.of<GeneralState>(context, listen: false)
                .setImagesListFeed(value);
            Provider.of<GeneralState>(context, listen: false).setLoaded(true);
          }
        }));
  }

  Widget buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GeneralState>(context);
    return provider.imagesListFeed != null
        ? provider.imagesListFeed.images.length == 0
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "No image found",
                    style: TextStyle(
                        color: Colors.grey, fontSize: defaultTextSize),
                  ),
                ),
              )
            : Container(
                child: !provider.isLoaded
                    ? buildCircularProgressIndicator()
                    : ListView.builder(
                        itemCount: provider.imagesListFeed.images.length < 400
                            ? provider.imagesListFeed.images.length
                            : 400,
                        itemBuilder: (context, index) {
                          if (provider.imagesListFeed != null &&
                              provider.imagesListFeed.images != null &&
                              provider.imagesListFeed.images[index] != null)
                            return Post(
                                image: provider.imagesListFeed.images[index]);
                          return Container();
                        }),
              )
        : buildCircularProgressIndicator();
  }
}
