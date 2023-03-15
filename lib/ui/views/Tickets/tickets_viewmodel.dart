import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import 'package:share_plus/share_plus.dart';

import '../../enums/enums.dart';

class TicketsViewModel extends BaseViewModel {
  bool _isLoading = false;
  String? email;

  var privacyData;

  initModel(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString(UserDetails.email.toString()) ?? '';
    notifyListeners();
    getMeetings();
  }

  get isLoading => _isLoading;
 

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  getMeetings() {
    showProgressBar(true);
   
  }

  
}
