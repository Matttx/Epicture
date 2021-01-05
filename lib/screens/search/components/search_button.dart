import 'package:epicture/api/images.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/constants.dart';
import 'alertDialog.dart';

class SearchButton extends StatelessWidget {
  final String sortFilterItem;
  final String windowFilterItem;

  const SearchButton({
    Key key,
    this.sortFilterItem,
    this.windowFilterItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GeneralState>(context, listen: false);
    return FloatingActionButton.extended(
      backgroundColor: Colors.black,
      onPressed: () {
        provider.setLoaded(false);
        var controllerText = provider.controller.text;
        if (controllerText.isEmpty == true) {
          getImages(
                  context,
                  'https://api.imgur.com/3/gallery/hot/${provider.sortFilterItem}/${provider.windowFilterItem}/1?showViral=true&mature=false&album_previews=false',
                  null)
              .then((value) {
            provider.setImagesListFeed(value);
            provider.setLoaded(true);
            Navigator.pop(context);
          });
        } else {
          getImagesWithTag(context,
                  'https://api.imgur.com/3/gallery/t/${provider.controller.text}/${provider.sortFilterItem}/${provider.windowFilterItem}/1')
              .then((value) {
            provider.setLoaded(true);
            if (value != null) {
              provider.setImagesListFeed(value);
              Navigator.pop(context);
            } else {
              showAlertDialog(context);
            }
          });
        }
      },
      label: Text(
        "Search",
        style: TextStyle(color: Colors.white, fontSize: searchItemTextSize),
      ),
    );
  }
}
