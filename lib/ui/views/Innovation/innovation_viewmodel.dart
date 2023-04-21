import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/route_names.dart';
import '../../../constants/string.dart';
import '../../../model/tagsarticles_model.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../enums/enums.dart';

class InnovationViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  List<String> textList = [
    CustomStrings.Grocery,
    CustomStrings.Fashion,
    CustomStrings.Automotive,
    CustomStrings.Sports,
    CustomStrings.Design,
    CustomStrings.Human,
    CustomStrings.Luxury,
    CustomStrings.showmore,
  ];
  var imageList = [
    yamamay,
    Googlefull,
    veronauno,
    Nespresso,
    Carrefour,
    Accenture
  ];

  List<TagsArticleModel> _articles = [];

  bool get isLoading => _isLoading;
  List<TagsArticleModel> get articles => _articles;

  Future<void> initModel(BuildContext context) async {
    await getArticles();
  }

  Future<void> getArticles() async {
    showProgressBar(true);
    await ApiServices.getRequest(
      url: "${API.articlesbyTag}1293",
      onSuccess: (data) async {
        showProgressBar(false);
        final searchData = tagsArticleModelFromJson(data.toString());
        _articles = searchData;
        log('Length: ${_articles.length}');
        notifyListeners();
      },
      onError: (String message, bool isError) async {
        showProgressBar(false);
        notifyListeners();
        log("ERROR$message");
      },
    );
  }

  void navigateToDetails(TagsArticleModel blogs) {
    _navigationService.navigateTo(blogdetailsViewRoute, arguments: blogs);
  }

 void showProgressBar(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  navigateToWebView() {
    _navigationService.navigateTo(innovationWebViewRoute,arguments: "https://app.retailhub.ai/");
  }
}
