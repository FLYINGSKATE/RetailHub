import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/route_names.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../enums/enums.dart';
import '../../methods/basecommon_methods.dart';

class ProfileViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var firstName = "Raushan";
  var lastName = "Jha";
  var fullName = "Raushan Jha";
  var email = "raushan@gmail.com";
  var position = "CTO";
  var token = "";
  bool isLinkedinlogin = false;
  initModel(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserDetails.token.toString())!;
    firstName = prefs.getString(UserDetails.firstname.toString())!;
    position = prefs.getString(UserDetails.position.toString())!;
    lastName = prefs.getString(UserDetails.lastname.toString())!;
    fullName = prefs.getString(UserDetails.fullname.toString())!;
    email = prefs.getString(UserDetails.email.toString())!;
    phoneController.text = prefs.getString(UserDetails.phoneNumber.toString())!;
    firstnameController.text = firstName;
    lastnameController.text = lastName;
    emailController.text = email;
    isLinkedinlogin = prefs.getBool(UserDetails.isLinkedinlogin.toString())!;

    notifyListeners();
  }

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

  Future<void> changePassword(BuildContext context) async {
    await showProgressBar(true);

    try {
      ApiServices.postRequestwithAuthToken(
          url: API.changePassword,
          authToken: token,
          params: {
            "currentPassword": currentPasswordController.text,
            "confirmPassword": confirmPasswordController.text,
            "newPassword": newPasswordController.text,
          },
          onSuccess: (var data) async {
            await showProgressBar(false);
            BaseCommonMethods.appToast(msg: "Password Changed", time: 3000);
            await logout();
            notifyListeners();
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.appToast(
                msg: "Your old password is wrong", time: 3000);

            await showProgressBar(false);
          });
    } catch (e) {
      BaseCommonMethods.appToast(msg: "Your old password is wrong", time: 3000);

      await showProgressBar(false);
    }
  }

  Future<void> updateAccount() async {
    await showProgressBar(true);

    try {
      ApiServices.postRequestwithAuthToken(
          url: API.updateAccount,
          authToken: token,
          params: {
            "department": "",
            "isEnabled": true,
            "isEnabled2fa": false,
            "password": null,
            "position": position,
            "phoneNumber": "99209041983",
            "email": emailController.text,
            "firstName": firstnameController.text,
            "lastName": lastnameController.text,
          },
          onSuccess: (var data) async {
            await showProgressBar(false);
            BaseCommonMethods.appToast(
                msg: "Your changes were saved  successfully", time: 3000);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.appToast(msg: "Something went wrong", time: 3000);

            await showProgressBar(false);
          });
    } catch (e) {
      BaseCommonMethods.appToast(msg: "Something went wrong", time: 3000);

      await showProgressBar(false);
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserDetails.islogin.toString(), false);
    _navigationService.popAllAndNavigateTo(bookingViewRoute);
  }
}
