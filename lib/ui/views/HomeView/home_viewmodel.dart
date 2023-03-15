import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/route_names.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../../utill/helper.dart';
import '../../enums/enums.dart';
import '../../methods/basecommon_methods.dart';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

class HomeViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();
  get isLoading => _isLoading;

  String? username;
  String? email;
  String? imgurl;
  String? meetingCode;
  String? currentDate;
  bool _validatemeetingtitle = false;
  bool _validatemeetingid = false;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  TextEditingController titlecontroller = TextEditingController();
  var imageList = [banner1, banner2];
  var imageList1 = [banner3, banner4];
  initModel(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString(UserDetails.email.toString()) ?? '';
    username = prefs.getString(UserDetails.fullname.toString()) ?? '';
    imgurl = prefs.getString(UserDetails.imgurl.toString());
    notifyListeners();
  }

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  void navigateToPage(String eventsViewRoute) {
    _navigationService.navigateTo(eventsViewRoute);
  }
}
