import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/route_names.dart';
import '../../../constants/string.dart';
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

  initModel(BuildContext context) async {
    
  }
  get isLoading => _isLoading;
  var firstName = "Raushan";

  var lastName = "Jha";

  var fullName = "Raushan Jha";

  var email = "raushan@gmail.com";
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

  navigateToWebView() {
    _navigationService.navigateTo(innovationWebViewRoute,arguments: "https://app.retailhub.ai/");
  }
}
