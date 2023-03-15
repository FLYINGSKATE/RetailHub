import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/route_names.dart';
import '../../../model/coworking_model.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';

class CoworkingViewModel extends BaseViewModel {
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

  List<Datum> coworkingsitems = [];
  getAllEvents() async {
    showProgressBar(true);
    ApiServices.getRequest(
        url: API.coworking,
        onSuccess: (data) async {
          showProgressBar(false);
          final CoWorkingModel searchData = coWorkingModelFromJson(data.toString());
          coworkingsitems = searchData.record.data;
          log(' Length: ${coworkingsitems.length}');
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
