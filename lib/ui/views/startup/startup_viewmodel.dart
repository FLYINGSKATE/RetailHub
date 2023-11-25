import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../constants/route_names.dart';
import '../../../services/localstorage_service.dart';
import '../../../services/navigation_service.dart';
import '../../enums/enums.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  void isTokenValid() async {
    setBusy(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isLogin = prefs.getBool(UserDetails.islogin.toString())??false;
    log("Islogin:$isLogin");
    Timer(
      const Duration(seconds: 0),
      () async {
        setBusy(false);
       _navigationService.popAllAndNavigateTo(isLogin? dashboardViewRoute: authenticationViewRoute);
        //_navigationService.popAllAndNavigateTo(isLogin? dashboardViewRoute: bookingViewRoute);
      },
    );
    notifyListeners();
  }
}
