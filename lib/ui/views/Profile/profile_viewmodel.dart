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
  var firstName = "Retail";
  var lastName = "HUB";
  var fullName = "Retail HUB";
  var email = "retailhub@gmail.com";
  var position = "CTO";
  var token = "";
  bool isLinkedinlogin = false;
  initModel(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Hola ");
    token = prefs.getString(UserDetails.token.toString())??"";
    print(token);
    firstName = prefs.getString(UserDetails.firstname.toString())!;
    print(firstName);
    if(prefs.containsKey(UserDetails.position.toString())){
      position = prefs.getString(UserDetails.position.toString())!;
    }
    lastName = prefs.getString(UserDetails.lastname.toString())!;
    print(lastName);
    fullName = prefs.getString(UserDetails.fullname.toString())!;
    print(fullName);
    email = prefs.getString(UserDetails.email.toString())!;
    print(email);
    phoneController.text = prefs.getString(UserDetails.phoneNumber.toString())??"";
    firstnameController.text = firstName;
    lastnameController.text = lastName;
    emailController.text = email;
    if(prefs.containsKey(UserDetails.isLinkedinlogin.toString())){
      isLinkedinlogin = prefs.getBool(UserDetails.isLinkedinlogin.toString())!;
    }


    print(firstName);
    print(lastName);
    print(firstName);
    print(fullName);
    print(email);

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
      ApiServices.putRequestwithAuthToken(
          url: API.changePassword,
          authToken: token,
          params: {
            "oldPassword": currentPasswordController.text,
            "newPassword": newPasswordController.text
          },
          onSuccess: (var data) async {
            await showProgressBar(false);
            BaseCommonMethods.appToast(msg: "Password Changed", time: 3000);

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await showProgressBar(true);

    try {
      ApiServices.putRequestwithAuthToken(
          url: API.updateAccount,
          authToken: token,
          params: {
            "first_name": firstnameController.text,
            "last_name": lastnameController.text,
            // "email": emailController.text,
            "phone_number": phoneController.text
          },
          onSuccess: (var data) async {
            await showProgressBar(false);
            firstName = firstnameController.text;
            lastName = lastnameController.text;
            BaseCommonMethods.appToast(
                msg: "Your changes were saved  successfully", time: 3000);
            prefs.setString(
                UserDetails.firstname.toString(), firstnameController.text);
            prefs.setString(
                UserDetails.lastname.toString(), lastnameController.text);
            prefs.setString(UserDetails.fullname.toString(),
                firstnameController.text + lastnameController.text);
            prefs.setString(UserDetails.email.toString(), emailController.text);
            prefs.setString(
                UserDetails.phoneNumber.toString(), phoneController.text);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.appToast(msg: message, time: 3000);

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
