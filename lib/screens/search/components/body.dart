import 'package:epicture/api/images.dart';
import 'package:epicture/screens/search/components/sort_filters.dart';
import 'package:epicture/screens/search/components/tag_post.dart';
import 'package:epicture/data/constants.dart';
import 'package:epicture/screens/search/components/window_filters.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_title.dart';
import 'search_text_input.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<GeneralState>(context, listen: false).isLoaded == false) {
        getTags(context, 'https://api.imgur.com/3/tags', null).then((value) {
          if (context != null) {
            Provider.of<GeneralState>(context, listen: false)
                .setTagsList(value);
            Provider.of<GeneralState>(context, listen: false).setLoaded(true);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: searchPadding),
      child: Column(
        children: [
          SearchTextInput(),
          SizedBox(
            height: 40,
          ),
          SortFilters(),
          SizedBox(
            height: 40,
          ),
          WindowFilters(),
          SizedBox(
            height: 40,
          ),
          CategoryTitle(title: "Tags"),
          tags(),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    ));
  }

  Widget tags() {
    var provider = Provider.of<GeneralState>(context);
    return !provider.isLoaded
        ? buildCircularProgressIndicator()
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 0.97),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.tagsList != null
                ? provider.tagsList.tags.length < 400
                    ? provider.tagsList.tags.length
                    : 400
                : buildCircularProgressIndicator(),
            itemBuilder: (context, index) {
              if (provider.tagsList != null &&
                  provider.tagsList.tags != null &&
                  provider.tagsList.tags[index] != null)
                return Center(
                  child: TagPost(tag: provider.tagsList.tags[index]),
                );
              return Container();
            });
  }
}