import 'dart:convert';
import 'package:flutter/material.dart';
import '../state/appstate.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ImgurImage {
  final String id;
  final String title;
  final String link;
  final double height;
  final double width;
  final String ups;
  final String downs;
  String vote;
  bool favorite;

  ImgurImage(
      {this.id,
      this.title,
      this.link,
      this.height,
      this.width,
      this.favorite,
      this.ups,
      this.downs,
      this.vote});

  factory ImgurImage.fromJson(Map<String, dynamic> json, screenName) {
    if (screenName == null) {
      if (json['images'] != null &&
          json['favorite'] != null &&
          json['images'][0] != null &&
          json['images'][0]['type'] != null &&
          json['images'][0]['type'] != "video/mp4") {
        return ImgurImage(
          id: json['id'],
          link: json['images'][0]['link'] as String,
          title: json['title'] as String,
          height: json['images'][0]['height'].toDouble(),
          width: json['images'][0]['width'].toDouble(),
          favorite: json['favorite'],
          ups: json['ups'].toString(),
          downs: json['downs'].toString(),
          vote: json['vote'],
        );
      }
    } else {
      if (json['link'] != null) {
        return ImgurImage(
          id: json['id'] as String,
          link: json['link'] as String,
          height: json['height'].toDouble(),
          width: json['width'].toDouble(),
        );
      }
    }
    return null;
  }
}

class Tag {
  final String name;
  final String displayName;
  final int nbPosts;

  Tag({this.name, this.displayName, this.nbPosts});

  factory Tag.fromJson(Map<String, dynamic> json, screenName) {
    if (json['name'] != null) {
      return Tag(
        name: json['name'],
        displayName: json['display_name'],
        nbPosts: json['total_items'],
      );
    }
  }
}

class Tags {
  List<Tag> tags;
  Tags({this.tags});

  factory Tags.fromJson(List<dynamic> json, screenName) => Tags(
      tags: json.map<Tag>((elem) => Tag.fromJson(elem, screenName)).toList()
        ..sort((tagPosts1, tagPosts2) =>
            tagPosts2.nbPosts.compareTo(tagPosts1.nbPosts)));
}

Future<Tags> getTags(context, String apiLink, screenName) async {
  final response = await http.get(
    apiLink,
    headers: {
      "Authorization":
          "Bearer ${Provider.of<GeneralState>(context, listen: false).accessToken}"
    },
  );
  if (response.statusCode == 200) {
    return Tags.fromJson(
        jsonDecode(response.body)['data']['tags'] as List, screenName);
  } else {
    throw Exception('Failed to load images');
  }
}

class ImgurImages {
  List<ImgurImage> images;
  ImgurImages({this.images});

  factory ImgurImages.fromJson(List<dynamic> json, screenName) => ImgurImages(
      images: json
          .map<ImgurImage>((elem) => ImgurImage.fromJson(elem, screenName))
          .toList());
}

void favoriteImages(context, apiLink) async {
  final request = await http.post(apiLink, headers: {
    "Authorization":
        "Bearer ${Provider.of<GeneralState>(context, listen: false).accessToken}"
  });
  if (request.statusCode != 200) {
    throw Exception('Failed to favorite this image.');
  }
}

void deleteImage(context, imageHash) {
  Navigator.of(context).pop();
  http.delete("https://api.imgur.com/3/image/$imageHash", headers: {
    "Authorization":
        "Bearer ${Provider.of<GeneralState>(context, listen: false).accessToken}"
  }).then((_) {
    Provider.of<GeneralState>(context, listen: false).setLoaded(false);
    getImages(context, 'https://api.imgur.com/3/account/me/images', "upload")
        .then((value) {
      if (context != null) {
        Provider.of<GeneralState>(context, listen: false)
            .setImagesListUpload(value);
        Provider.of<GeneralState>(context, listen: false).setLoaded(true);
      }
    });
  });
}

void uploadImages(context, apiLink, String image) {
  http.post(apiLink, headers: {
    "Authorization":
        "Bearer ${Provider.of<GeneralState>(context, listen: false).accessToken}"
  }, body: {
    'image': image,
    'type': 'base64'
  }).then((_) {
    Provider.of<GeneralState>(context, listen: false).setLoaded(false);
    getImages(context, 'https://api.imgur.com/3/account/me/images', "upload")
        .then((value) {
      if (context != null) {
        Provider.of<GeneralState>(context, listen: false)
            .setImagesListUpload(value);
        Provider.of<GeneralState>(context, listen: false).setLoaded(true);
      }
    });
  });
}

void vote(context, ImgurImage image, String vote) {
  String vote = image.vote == "up"
      ? "up"
      : image.vote == "down"
          ? "down"
          : "veto";
  String apiLink = "https://api.imgur.com/3/gallery/${image.id}/vote/${vote}";
  http.post(apiLink, headers: {
    "Authorization":
        "Bearer ${Provider.of<GeneralState>(context, listen: false).accessToken}"
  }).catchError((onError) => print("Failed to vote for this image"));
}

Future<ImgurImages> getImages(context, String apiLink, screenName) async {
  final response = await http.get(
    apiLink,
    headers: {
      "Authorization":
          "Bearer ${Provider.of<GeneralState>(context, listen: false).accessToken}"
    },
  );
  if (response.statusCode == 200) {
    return ImgurImages.fromJson(
        jsonDecode(response.body)['data'] as List, screenName);
  } else {
    throw Exception('Failed to load images');
  }
}

Future<ImgurImages> getImagesWithTag(context, String apiLink) async {
  final response = await http.get(
    apiLink,
    headers: {
      "Authorization":
          "Bearer ${Provider.of<GeneralState>(context, listen: false).accessToken}"
    },
  );
  if (response.statusCode == 200) {
    if (jsonDecode(response.body)['data']['items'] as List == null) return null;
    return ImgurImages.fromJson(
        jsonDecode(response.body)['data']['items'] as List, null);
  } else {
    throw Exception('Failed to load images');
  }
}
