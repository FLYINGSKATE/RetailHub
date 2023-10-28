import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/route_names.dart';
import '../../../services/navigation_service.dart';
import '../../enums/enums.dart';

class SettingViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();
  initModel(BuildContext context) async {}
  get isLoading => _isLoading;

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserDetails.islogin.toString(), false);
    _navigationService.popAllAndNavigateTo(loginViewRoute);
  }

  void navigateToPrivacy(title, fileName) {
    var pageObj = {"title": title, "fileName": fileName};
    _navigationService.navigateTo(privacyviewRoute, arguments: pageObj);
  }
}
