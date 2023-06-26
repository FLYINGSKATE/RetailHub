import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:retailhub/model/register_user_model.dart';
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
import 'package:http/http.dart' as http;

class SignUpViewModel extends BaseViewModel {
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
  String redirectUrl = 'https://app.retailhub.ai/';
  String clientId = '78k5xejwubg8ep';
  String clientSecret = 'd6YEzQi38Fzeebe1';
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

  Future<void> loginUser(BuildContext context, {String? emailId, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(UserDetails.email.toString(),
    //     isChecked ? emailController.text.toString().trim() : "");
    // prefs.setString(UserDetails.password.toString(),
    //     isChecked ? passwordController.text.toString() : "");

    await showProgressBar(true);
    if(emailId==null){
      emailId = emailController.text.trim();
    }
    if(password==null){
      password = passwordController.text;
    }

    try {
      ApiServices.postRequest(
          url: API.login,
          params: {
            "email": emailId,
            "password": password,
          },
          onSuccess: (Map data) async {
            await showProgressBar(false);
            log('login data: ${data}');
            final UserModel user =
            userModelFromJson(json.encode(data).toString());
            log(user.data.user.firstName);
            var userData = user.data.user;
            prefs.setBool(UserDetails.islogin.toString(), true);
            prefs.setString(
                UserDetails.firstname.toString(), userData.firstName);
            prefs.setString(UserDetails.lastname.toString(), userData.lastName);
            prefs.setString(UserDetails.fullname.toString(),
                userData.firstName + userData.lastName);
            prefs.setString(UserDetails.email.toString(), userData.email);
            prefs.setString(
                UserDetails.phoneNumber.toString(), userData.phoneNumber);
            prefs.setString(UserDetails.token.toString(), user.data.token);
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
            "firstName": firstname.text,
            "lastName": lastname.text,
            "email": busienssemail.text,
            "password": password.text,
            "phoneNumber": phone.text,
            "isLinkedinUser": false
          },
          onSuccess: (Map data) async {
            await showProgressBar(false);
            log('register data: ${data}');
            data.forEach((key, value) {
              print(key);
              print(value);
              print("Ashraf Khan");
            });
            final RegisterUserModel user = registerUserModelFromJson(json.encode(data).toString());

            var userData = user.user;

            prefs.setBool(UserDetails.islogin.toString(), true);
            prefs.setString(UserDetails.imgurl.toString(), "null");
            prefs.setString(UserDetails.firstname.toString(), userData.firstName);
            prefs.setString(UserDetails.lastname.toString(), userData.lastName);
            prefs.setString(UserDetails.fullname.toString(), userData.firstName + userData.lastName);
            prefs.setString(UserDetails.email.toString(), userData.email);
            prefs.setString(UserDetails.phoneNumber.toString(),phone.text);
           // prefs.setString(UserDetails.token.toString(),userData.token);

            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Registration successful",
            );
            await loginUser(context,emailId: busienssemail.text,password: password.text);
            _navigationService.popAllAndNavigateTo(dashboardViewRoute);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "User already registered",
            );
            await showProgressBar(false);
          });
    } catch (e) {
      BaseCommonMethods.appToast(
          msg: "User already registered", time: 7000);

      await showProgressBar(false);
    }
  }

  Future<void> forgetpassword(BuildContext context) async {
    await showProgressBar(true);

    try {
      ApiServices.postRequest(
          url: "${API.forgetpassword}/${emailController.text}",
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

  linkedinLogin(context, fn, ln, email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(UserDetails.password.toString(), "");
    // email = "rjha1@gmail.comm";
    print("APAN LOGF");
    print(email.toString());
    print(password.text);
    await showProgressBar(true);

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dev1.retailhub.ai/api/login'));
    request.body = json.encode({
      "email": email.toString(),
      "password": password.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      print(data);
      await showProgressBar(false);
      final UserModel user = userModelFromJson(data.toString());
      log("user.data.user.firstName");
      log(user.data.user.firstName);
      log(user.data.user.email);
      log(user.data.user.lastName);
      log(user.data.user.isLinkedinUser.toString());
      var userData = user.data.user;
      prefs.setBool(UserDetails.islogin.toString(), true);
      prefs.setString(UserDetails.imgurl.toString(), "null");
      prefs.setString(UserDetails.firstname.toString(), userData.firstName);
      prefs.setString(UserDetails.lastname.toString(), userData.lastName);
      prefs.setString(UserDetails.fullname.toString(), userData.firstName + userData.lastName);
      prefs.setString(UserDetails.email.toString(), userData.email);
      prefs.setBool(UserDetails.isLinkedinlogin.toString(), true);

      prefs.setString(UserDetails.phoneNumber.toString(), userData.phoneNumber);
      prefs.setString(UserDetails.token.toString(), user.data.token);
      await showProgressBar(false);
      _navigationService.popAllAndNavigateTo(dashboardViewRoute);
    }
    else {
      print(response.reasonPhrase);
      print("message");
      BaseCommonMethods.showSnackbar(
        context: context,
        msg: "Please check username and password",
      );
      await showProgressBar(false);
      Navigator.pop(context);
    }


  }

  linkedinsignup(fn, ln, email, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("fn+ln+email");
    log(fn+ln+email);
    await showProgressBar(true);
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dev1.retailhub.ai/api/register'));
    request.body = json.encode({
      "firstName": fn,
      "lastName": ln,
      "email": email,
      "isLinkedinUser": true,
      "password": "",
      "phoneNumber": "0000000000"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      await showProgressBar(false);
      log('registewr data: ${data}');
      final RegisterUserModel user = registerUserModelFromJson(data);
      var userData = user.user;
      prefs.setBool(UserDetails.islogin.toString(), true);

      prefs.setString(UserDetails.imgurl.toString(), "null");
      prefs.setString(UserDetails.firstname.toString(), userData.firstName);
      prefs.setString(UserDetails.lastname.toString(), userData.lastName);
      prefs.setString(UserDetails.fullname.toString(),
          userData.firstName + userData.lastName);
      prefs.setString(UserDetails.email.toString(), userData.email);
      prefs.setString(UserDetails.token.toString(), userData.email);
      log("linkedin user registerd");
      await linkedinLogin(context, fn.toString(), ln.toString(), email.toString());
    }
    else {
      print(response.reasonPhrase);
      print("Unable To Register");
      print("message");

      /*BaseCommonMethods.showSnackbar(
        context: context,
        msg: "Unable to register with linkedin ",
      );*/
      await showProgressBar(false);
      await linkedinLogin(context, fn, ln, email);
      Navigator.pop(context);
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
