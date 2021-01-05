import 'package:epicture/screens/upload/components/upload_post.dart';
import 'package:flutter/material.dart';
import 'package:epicture/api/images.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => getImages(
      context,
      widget.apiLink,
      "upload"
    ).then((value) {
      if (context != null) {
        Provider.of<GeneralState>(context, listen: false)
            .setImagesListUpload(value);
        Provider.of<GeneralState>(context, listen: false).setLoaded(true);
      }
    }).catchError((onError) => print(onError))
    );
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
    return provider.imagesListUpload != null ? provider.imagesListUpload.images.length == 0 ?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("No image uploaded", style: TextStyle(color: Colors.grey, fontSize: defaultTextSize),),),
        ):
      Container(
      child: !provider.isLoaded
          ? buildCircularProgressIndicator()
          : ListView.builder(
          itemCount: provider.imagesListUpload.images.length < 400
              ? provider.imagesListUpload.images.length
              : 400,
          itemBuilder: (context, index) {
            if (provider.imagesListUpload != null &&
                provider.imagesListUpload.images != null &&
                provider.imagesListUpload.images[index] != null)
              return UploadPost(image: provider.imagesListUpload.images[index]);
            return Container();
          }),
    ) : buildCircularProgressIndicator();
  }
}