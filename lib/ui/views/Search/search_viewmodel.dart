import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:retailhub/model/article_model.dart';
import 'package:retailhub/model/startup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';

import '../../../constants/api.dart';
import '../../../constants/route_names.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:retailhub/model/startup_model.dart';
import '../../enums/enums.dart';

class SearchViewModel extends BaseViewModel {
  bool _isLoading = false;
  var token = "";

  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();
  final List<String> items = List<String>.generate(20, (i) => "Item $i");
  var duplicateItems = <String>[];

  initModel(BuildContext context) async {
    print("Init Model For Search");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserDetails.token.toString())??"";
    print("Init Model For Search");
    await getAllArticles();
    await getAllStartups();
    notifyListeners();
  }

  get isLoading => _isLoading;

  List<Datum> searchedArticles = [];
  List<Startups> searchedStartUps = [];

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  getAllArticles() async {
    showProgressBar(true);
    print("Getting All Articles For Search");
    ApiServices.getRequest(
        url: API.articles,
        onSuccess: (data) async {
          showProgressBar(false);
          log("data");
          log(data);
          final ArticleModel searchData = articleModelFromJson(data.toString());
          searchedArticles = searchData.data;
          log(' Length: ${searchedArticles.length}');
          notifyListeners();
        },
        onError: (String message, bool isError) async {
          showProgressBar(false);
          notifyListeners();
          log("ERROR$message");
        });
  }

  searchArticles() async {
    searchedArticles.clear();
    print("Searching Articles : for"+searchController.text);
    notifyListeners();
    showProgressBar(true);
    ApiServices.getRequest(
        url: '${API.articles}?search=${searchController.text}',
        onSuccess: (data) async {
          showProgressBar(false);
          final ArticleModel searchData = articleModelFromJson(data.toString());
          searchedArticles = searchData.data;
          log(' Length: ${searchedArticles.length}');
          notifyListeners();
        },
        onError: (String message, bool isError) async {
          showProgressBar(false);
          notifyListeners();
          log("ERROR$message");
        });
  }


  getAllStartups() async {
    showProgressBar(true);
    print("Getting All Startups For Search");
    ApiServices.getRequest(
        ///url: "https://dev1.retailhub.ai/api/v2/startup/search?pageNum=1&size=5",
        url: API.startups,
        onSuccess: (data) async {
          showProgressBar(false);
          log("data");
          log(data);
          final StartupModal searchData = startupModelFromJson(data.toString());
          searchedStartUps = searchData.data?.startups??[];
          log(' Length Searched StartUps: ${searchedStartUps.length}');
          notifyListeners();
        },
        onError: (String message, bool isError) async {
          showProgressBar(false);
          notifyListeners();
          log("ERROR$message");
        });
  }

  searchStartups() async {
    searchedArticles.clear();
    print("Searching StartUps : for"+searchController.text);
    notifyListeners();
    showProgressBar(true);
    ApiServices.getRequest(
       // https://dev1.retailhub.ai/api/v2/startup/search?pageNum=1&size=5&search=Information Security"
       // url: 'https://dev1.retailhub.ai/api/v2/startup/search?pageNum=1&size=5&search=${searchController.text}',
        url: API.searchstartups+searchController.text,
        onSuccess: (data) async {
          showProgressBar(false);
          log("data");
          log(data);
          //log(data["startups"]);
          final StartupModal searchData = startupModelFromJson(data.toString());
          searchedStartUps = searchData.data?.startups??[];
          log(' Length Searched StartUps: ${searchedStartUps.length}');
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

  void navigateToStartupDetails(Startups startups) {
    log("startups!.companyLegalName!");
    log(startups.companyLegalName.toString());
    _navigationService.navigateTo(startupsdetailsViewRoute, arguments: startups);
  }

  
}
