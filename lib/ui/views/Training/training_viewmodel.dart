import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/route_names.dart';
import '../../../model/training_model.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../enums/enums.dart';

class TrainingViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();

  initModel(BuildContext context) async {
    await getAllEvents();
    notifyListeners();
  }

  get isLoading => _isLoading;
  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  List<TrainingModel> trainingitems = [];
  getAllEvents() async {
    showProgressBar(true);
    ApiServices.getRequest(
        url: API.training,
        onSuccess: (data) async {
          showProgressBar(false);
          final List<TrainingModel>  searchData =
              trainingModelFromJson(data.toString());
          trainingitems = searchData;
          log(' Length: ${trainingitems.length}');
          notifyListeners();
        },
        onError: (String message, bool isError) async {
          showProgressBar(false);
          notifyListeners();
          log("ERROR$message");
        });
  }

  void navigateToDetails(TrainingModel? blogs) {
    log("blogs!.newsTitle!");

    _navigationService.navigateTo(blogdetailsViewRoute, arguments: blogs);
  }
}
