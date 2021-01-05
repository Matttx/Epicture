import 'package:epicture/api/images.dart';
import 'package:epicture/data/constants.dart';
import 'package:epicture/screens/upload/components/alertDialog.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadPost extends StatefulWidget {
  final ImgurImage image;

  const UploadPost({
    Key key,
    this.image
  }) : super(key: key);

  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {

  Widget buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: () => showAlertDialog(Provider.of<GeneralState>(context, listen: false).scaffoldKey.currentContext, widget.image.id),
      child: Container(
        margin: EdgeInsets.all(size.width / 35),
        height: ((widget.image.height * (size.width - (size.width / 35 * 2))) / widget.image.width),
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
                image: Image.network(
                    widget.image.link,
                    cacheWidth: size.width.toInt(),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null)
                        return child;
                      else
                        return buildCircularProgressIndicator();
                    }
                ).image, alignment: Alignment.center
            )
        ),
      ),
    );
  }
}
