import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:retailhub/model/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/route_names.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import 'package:share_plus/share_plus.dart';

import '../../enums/enums.dart';

class SearchViewModel extends BaseViewModel {
  bool _isLoading = false;
  var token = "";

  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();
  final List<String> items = List<String>.generate(20, (i) => "Item $i");
  var duplicateItems = <String>[];
  initModel(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserDetails.token.toString())!;
    await getAll();
    notifyListeners();
  }

  get isLoading => _isLoading;

  List<Datum> searchitems = [];

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  getAll() async {
    showProgressBar(true);
    print("Getting All Articles");
    ApiServices.getRequest(
        url: API.articles,
        onSuccess: (data) async {
          showProgressBar(false);
          log("data");
          log(data);
          final ArticleModel searchData = articleModelFromJson(data.toString());
          searchitems = searchData.data;
          log(' Length: ${searchitems.length}');
          notifyListeners();
        },
        onError: (String message, bool isError) async {
          showProgressBar(false);
          notifyListeners();
          log("ERROR$message");
        });
  }

  searchArticles() async {
    searchitems.clear();
    notifyListeners();
    showProgressBar(true);
    ApiServices.getRequest(
        url: '${API.articles}?search=${searchController.text}',
        onSuccess: (data) async {
          showProgressBar(false);
          final ArticleModel searchData = articleModelFromJson(data.toString());
          searchitems = searchData.data;
          log(' Length: ${searchitems.length}');
          notifyListeners();
        },
        onError: (String message, bool isError) async {
          showProgressBar(false);
          notifyListeners();
          log("ERROR$message");
        });
  }

  void navigateToDetails(Datum? blogs) {
    log("blogs!.newsTitle!");
    log(blogs!.id);
    _navigationService.navigateTo(blogdetailsViewRoute, arguments: blogs);
  }
}
