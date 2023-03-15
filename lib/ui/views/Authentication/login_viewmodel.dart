import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/route_names.dart';
import '../../../model/user_model.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../enums/enums.dart';
import '../../methods/basecommon_methods.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController bookingemailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ticketrefrenceController = TextEditingController();

  //signup
  TextEditingController busienssemail = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  UserObject? user;
  bool? bookingagreecheck = false;
  bool logoutUser = false;
  String redirectUrl = 'https://www.youtube.com/callback';
  String clientId = '776rnw4e4izlvg';
  String clientSecret = 'rQEgboUHMLcQi59v';
  final List<bool> steps = [
    true,
    false,
    false,
  ];
  final text = <String>['1', '2', '3'];
  initMethod(BuildContext context) async {}
  initLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString(UserDetails.email.toString()) ?? '';
    passwordController.text =
        prefs.getString(UserDetails.password.toString()) ?? '';
    notifyListeners();
  }

  bool isSigningIn = false;
  bool isChecked = true;
  Future showProgressBar(value) async {
    isSigningIn = value;
    notifyListeners();
  }

  remeberpassword(bool? value) {
    isChecked = value!;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(UserDetails.email.toString(),
        isChecked ? emailController.text.toString().trim() : "");
    prefs.setString(UserDetails.password.toString(),
        isChecked ? passwordController.text.toString() : "");
    await showProgressBar(true);
    try {
      ApiServices.postRequest(
          url: API.login,
          params: {
            "email": emailController.text.trim(),
            "password": passwordController.text,
          },
          onSuccess: (Map data) async {
            await showProgressBar(false);
            log('login data: ${data}');
            // final UserModel user = userModelFromJson(data.toString());
            var user = data;
            prefs.setString(UserDetails.imgurl.toString(), "null");
            prefs.setString(
                UserDetails.firstname.toString(), user['firstName']);
            prefs.setString(UserDetails.lastname.toString(), user['lastName']);
            prefs.setString(UserDetails.fullname.toString(), user['fullName']);
            prefs.setString(UserDetails.email.toString(), user['email']);
            prefs.setString(
                UserDetails.phoneNumber.toString(), user['phoneNumber']??"");
            prefs.setString(UserDetails.position.toString(), user['position']??"");
            prefs.setString(UserDetails.token.toString(), user['token']);
            prefs.setBool(UserDetails.islogin.toString(), true);
            prefs.setBool(UserDetails.isLinkedinlogin.toString(), false);
            prefs.setBool(
                UserDetails.isVerified.toString(), user['isVerified']);
            prefs.setString(UserDetails.city.toString(), user['city']??"");

            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Login successful",
            );
            _navigationService.popAllAndNavigateTo(dashboardViewRoute);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Please check username and password",
            );
            await showProgressBar(false);
          });
    } catch (e) {
      BaseCommonMethods.appToast(
          msg: "Please check username and password", time: 7000);

      await showProgressBar(false);
    }
  }

  registerUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await showProgressBar(true);
    try {
      ApiServices.postRequest(
          url: API.register,
          params: {
            "policyConfirmed": true,
            "isCompany": "false",
            "emailDomain": "@retailhub.com",
            "email": busienssemail.text,
            "companyLegalName": "Retailhub.com",
            "password": password.text,
            "lastName": lastname.text,
            "firstName": firstname.text,
            "businessTypeName": "Retailer",
            "businessType": "Retailer",
            "companyShortName": "Retailhub.com",
            "role": "Retailer",
          },
          onSuccess: (Map data) async {
            await showProgressBar(false);
            log('registewr data: ${data}');
            var user = data;
            log('user: $user');
            prefs.setString(
                UserDetails.firstname.toString(), user['firstName'] ?? '');
            prefs.setString(
                UserDetails.lastname.toString(), user['lastName'] ?? '');
            prefs.setString(
                UserDetails.fullname.toString(), user['fullName'] ?? '');
            prefs.setString(UserDetails.email.toString(), user['email'] ?? '');
            // prefs.setString(
            //     UserDetails.phoneNumber.toString(), user['phoneNumber'] ?? '');
            prefs.setString(
                UserDetails.position.toString(), user['position'] ?? '');
            prefs.setString(UserDetails.token.toString(), user['token'] ?? '');
            // prefs.setBool(
            //     UserDetails.isVerified.toString(), user['isVerified'] ?? false);
            // prefs.setString(UserDetails.city.toString(), user['city'] ?? '');
            prefs.setBool(UserDetails.islogin.toString(), true);
            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Registration successful",
            );
            _navigationService.popAllAndNavigateTo(dashboardViewRoute);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Please check username and password",
            );
            await showProgressBar(false);
          });
    } catch (e) {
      BaseCommonMethods.appToast(
          msg: "Please check username and password", time: 7000);

      await showProgressBar(false);
    }
  }

  Future<void> forgetpassword(BuildContext context) async {
    await showProgressBar(true);

    try {
      ApiServices.postRequest(
          url: API.forgetpassword,
          params: {
            "email": emailController.text,
          },
          onSuccess: (var data) async {
            await showProgressBar(false);
            BaseCommonMethods.appToast(
                msg: "Please check your email to set a new password.",
                time: 2000);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.appToast(
                msg: "We couldn't find an account with that email address.",
                time: 2000);

            await showProgressBar(false);
          });
    } catch (e) {
      BaseCommonMethods.appToast(
          msg: "We couldn't find an account with that email address.",
          time: 2000);

      await showProgressBar(false);
    }
  }

  void opensignupPage() {
    _navigationService.navigateTo(signupViewRoute);
  }

  void opensigninPage() {
    _navigationService.navigateTo(loginViewRoute);
  }

  signIn(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(UserDetails.password.toString(), "");
    await showProgressBar(true);
    try {
      ApiServices.postRequest(
          url: API.login,
          params: {
            "email": "nehmezed@gmail.com",
            "password": 'Retail@Hub2023',
          },
          onSuccess: (Map data) async {
            await showProgressBar(false);
            log('login data: ${data}');
            // final UserModel user = userModelFromJson(data.toString());
            var user = data;

            prefs.setBool(UserDetails.isLinkedinlogin.toString(), true);
            prefs.setString(UserDetails.position.toString(), user['position']);
            prefs.setString(UserDetails.token.toString(), user['token']);
            prefs.setBool(UserDetails.islogin.toString(), true);
            prefs.setBool(
                UserDetails.isVerified.toString(), user['isVerified']);
            prefs.setString(UserDetails.city.toString(), user['city']);

            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Login successful",
            );
            _navigationService.popAllAndNavigateTo(dashboardViewRoute);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Please check username and password",
            );
            await showProgressBar(false);
          });
    } catch (e) {
      BaseCommonMethods.appToast(
          msg: "Please check username and password", time: 7000);

      await showProgressBar(false);
    }
  }

  saveSharedData(String fname, lname, email, profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLinkedin', true);
    await prefs.setString(UserDetails.firstname.toString(), fname);
    await prefs.setString(UserDetails.lastname.toString(), lname);
    await prefs.setString(UserDetails.email.toString(), email);
    await prefs.setString(UserDetails.fullname.toString(), "$fname $lname");
    await prefs.setString(UserDetails.phoneNumber.toString(), " ");
    await prefs.setString('profile', profile);
  }

  bool isHidden = true;
  void togglePasswordView() {
    isHidden = !isHidden;
    notifyListeners();
  }

  void changePassword(context) {}
}

class UserObject {
  UserObject({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImageUrl,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String profileImageUrl;
}
