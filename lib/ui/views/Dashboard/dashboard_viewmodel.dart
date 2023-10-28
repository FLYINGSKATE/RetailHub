import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:retailhub/constants/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/navigation_service.dart';
import '../../../services/permissions_service.dart';
import '../../enums/enums.dart';

class DashboardViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isLoading = false;
  final PermissionsService _permissionsService = PermissionsService();

  String firstName = "Raushan";

  String lastName = "";

  String fullName = "Raushan Jha";

  String email = "raushan@gmail.com";

  initMethod(BuildContext context) async {
    // var hasPermissions = await _permissionsService.getPermission(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      firstName = prefs.getString(UserDetails.firstname.toString())!;
      lastName = prefs.getString(UserDetails.lastname.toString())!;
      fullName = prefs.getString(UserDetails.fullname.toString())!;
      email = prefs.getString(UserDetails.email.toString())!;
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  showProgressBar(value) async {
    isLoading = value;
    notifyListeners();
  }

  navigateToProfile() {
    _navigationService.navigateTo(profileViewRoute);
  }

  Future<void> logout(context) async {
    Navigator.pop(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserDetails.islogin.toString(), false);
    _navigationService.popAllAndNavigateTo(bookingViewRoute);
  }
}
