import 'package:epicture/api/images.dart';
import 'package:epicture/screens/favorites/favorites_screen.dart';
import 'package:epicture/screens/feed/feed_screen.dart';
import 'package:epicture/screens/upload/upload_screen.dart';
import 'package:flutter/material.dart';

class GeneralState extends ChangeNotifier {
  String _accessToken = "";
  String _refreshToken = "";
  Tags _tagsList;
  ImgurImages _imagesListFeed;
  ImgurImages _imagesListUpload;
  ImgurImages _imagesListFavorites;
  String _sortFilterItem = "viral";
  String _windowFilterItem = "top";
  bool _isLoaded = false;
  TextEditingController _controller = TextEditingController();
  List<Widget> _navBarItemList = [
    FeedScreen(),
    UploadScreen(),
    FavoritesScreen()
  ];
  int _selectedItem = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void setFavorite(ImgurImage image, String list) {
    if (_imagesListFeed != null && list == "feed") {
      _imagesListFeed.images.forEach((element) {
        if (element != null && element.id == image.id) {
          element.favorite = !element.favorite;
          notifyListeners();
        }
      });
    } else {
      _imagesListFavorites.images.forEach((element) {
        if (element != null && element.id == image.id) {
          element.favorite = !element.favorite;
          notifyListeners();
        }
      });
    }
  }

  void setVote(ImgurImage image, String vote, String list) {
    if (_imagesListFeed != null && list == "feed") {
      _imagesListFeed.images.forEach((element) {
        if (element != null && element.id == image.id) {
          element.vote = vote;
          notifyListeners();
        }
      });
    } else {
      _imagesListFavorites.images.forEach((element) {
        if (element != null && element.id == image.id) {
          element.vote = element.vote;
          notifyListeners();
        }
      });
    }
  }

  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  String get accessToken => _accessToken;

  void setLoaded(bool isLoaded) {
    _isLoaded = isLoaded;
    notifyListeners();
  }

  bool get isLoaded => _isLoaded;

  void setRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    notifyListeners();
  }

  String get refreshToken => _refreshToken;

  void setImagesListFeed(ImgurImages images) {
    _imagesListFeed = images;
    notifyListeners();
  }

  void setTagsList(Tags tags) {
    _tagsList = tags;
    notifyListeners();
  }

  Tags get tagsList => _tagsList;

  ImgurImages get imagesListFeed => _imagesListFeed;

  void setImagesListFavorite(ImgurImages images) {
    _imagesListFavorites = images;
    notifyListeners();
  }

  ImgurImages get imagesListFavorites => _imagesListFavorites;

  void setImagesListUpload(ImgurImages images) {
    _imagesListUpload = images;
    notifyListeners();
  }

  ImgurImages get imagesListUpload => _imagesListUpload;

  void setSortFilterItem(String value) {
    _sortFilterItem = value;
    notifyListeners();
  }

  String get sortFilterItem => _sortFilterItem;

  void setWindowFilterItem(String value) {
    _windowFilterItem = value;
    notifyListeners();
  }

  String get windowFilterItem => _windowFilterItem;

  TextEditingController get controller => _controller;

  void setSelectedItem(int index) {
    _selectedItem = index;
    notifyListeners();
  }

  int get selectedIndex => _selectedItem;

  List<Widget> get navBarItemList => _navBarItemList;

  GlobalKey get scaffoldKey => _scaffoldKey;
}
