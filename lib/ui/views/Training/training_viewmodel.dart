import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/route_names.dart';
import '../../../model/tagsarticles_model.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../enums/enums.dart';

class TrainingViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();
  List<TagsArticleModel> _articles = [];

  bool get isLoading => _isLoading;
  List<TagsArticleModel> get articles => _articles;

  Future<void> initModel(BuildContext context) async {
    await getArticles();
  }

  Future<void> getArticles() async {
    showProgressBar(true);
    await ApiServices.getRequest(
      url: API.articlesbyTag + "1291",
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
}

