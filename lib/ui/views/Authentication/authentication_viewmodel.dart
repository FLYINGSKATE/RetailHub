import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retailhub/model/register_user_model.dart';
import 'package:retailhub/ui/views/Authentication/app_response.dart';
import 'package:retailhub/ui/views/Authentication/login_viewmodel.dart';
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

class AuthenticationViewModel extends BaseViewModel with WidgetsBindingObserver {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController bookingemailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController ticketrefrenceController = TextEditingController();

  //signup
  TextEditingController busienssemail = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  CollectionReference ticketsCollectionReference = FirebaseFirestore.instance
      .collection('/Tickets');
  CollectionReference eventsCollectionReference = FirebaseFirestore.instance
      .collection('/Events');
  CollectionReference usersCollectionReference = FirebaseFirestore.instance
      .collection('/Users');


  UserObject? user;
  bool? bookingagreecheck = false;
  bool? isValidEmailAddress = false;
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

  static const BREVO_API_KEY = "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";
  static const BREVO_BASE_URL = "https://api.brevo.com/v3";

  String? emailErrortext;

  final _firebaseAuth = FirebaseAuth.instance;

  static const noCredentialsWereFound = 'No credentials were found';

  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  initMethod(BuildContext context) async {}

  initLogin(BuildContext context) async {
    WidgetsBinding.instance.addObserver(this);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bookingemailController.text = prefs.getString(UserDetails.email.toString()) ?? '';
    passwordController.text = prefs.getString(UserDetails.password.toString()) ?? '';
    //retrieveDynamicLinkAndSignIn(fromColdState: true);
    notifyListeners();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //   focusNode.dispose();
    bookingemailController.dispose();
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        developer.log('SignInController: resumed');
        retrieveDynamicLinkAndSignIn(fromColdState: false, context: null);
        break;
      case AppLifecycleState.inactive:
        developer.log('SignInController: inactive');
        break;
      case AppLifecycleState.paused:
        developer.log('SignInController: paused');
        break;
      case AppLifecycleState.detached:
        developer.log('SignInController: detached');
        break;
    }}

    Future<void> signInWithEmailLink(BuildContext context) async {
      try {
        isSigningIn = true;
        AppResponse appResponse = await sendEmailLink(context);
        if (appResponse.isSuccess) {
          BaseCommonMethods.showSnackbar(
            context: context,
            msg: 'Email Link Sent : Passwordless sign-in link sent!\n Please check your inbox to complete sign in',
          );
        } else {
          //errorDialog(appResponse.message);
          BaseCommonMethods.showSnackbar(
            context: context,
            msg: appResponse.message,
          );
        }
      } catch (error, stackTrace) {
        developer.log(
          'signInWithEmailLink',
          error: error,
          stackTrace: stackTrace,
        );
      } finally {
        isSigningIn = false;
      }
    }

   /* Future<AppResponse> retrieveDynamicLinkAndSignIn({
      required bool fromColdState,BuildContext? context
    }) async {
      developer.log('retrieveDynamicLinkAndSignIn');
      AppResponse appResponse = await retrieveDynamicLinkAndSignIn(
        fromColdState: fromColdState, context: context,
      );
      if (appResponse.isNotFound) {
        developer.log('retrieveDynamicLinkAndSignIn: not found');
      }
      else if (appResponse.isSuccess) {
        _navigationService.pop();
        _navigationService.navigateTo(dashboardViewRoute);
      }
      else {
        BaseCommonMethods.showSnackbar(
          context: context,
          msg: appResponse.message,
        );
      }
      return appResponse;
    }*/

  /// Cold state means the app was terminated.
  Future<AppResponse> retrieveDynamicLinkAndSignIn({
    required bool fromColdState,BuildContext? context
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email =prefs.getString(UserDetails.email.toString()) ?? '';
      developer.log('retrieveDynamicLinkAndSignIn[$email]');
      if (email.isEmpty) {
        developer.log('retrieveDynamicLinkAndSignIn email is empty');
        return AppResponse.notFound(
          id: 'retrieveDynamicLinkAndSignIn',
          message: noCredentialsWereFound,
        );
      }

      PendingDynamicLinkData? dynamicLinkData;

      Uri? deepLink;
      if (fromColdState) {
        dynamicLinkData = await FirebaseDynamicLinks.instance.getInitialLink();
        if (dynamicLinkData != null) {
          deepLink = dynamicLinkData.link;
        }
      } else {
        dynamicLinkData = await FirebaseDynamicLinks.instance.onLink.first;
        deepLink = dynamicLinkData.link;
      }

      developer.log('deepLink => $deepLink');
      if (deepLink != null) {
        bool validLink = _firebaseAuth.isSignInWithEmailLink(deepLink.toString());

        /// Password- less hack for IOS
        if (!validLink && Platform.isIOS) {
          developer.log('Password- less hack for IOS deepLink is not valid');
          ClipboardData? data = await Clipboard.getData('text/plain');
          if (data != null) {
            developer.log('Get link from Clipboard => ${data.text}');
            final linkData = data.text ?? '';
            final link = Uri.parse(linkData).queryParameters['link'] ?? "";
            developer.log(
              'Parsed Link => $link',
            );
            validLink = _firebaseAuth.isSignInWithEmailLink(link);
            if (validLink) {
              deepLink = Uri.parse(link);
            }
          }
        }

        /// End - Password- less hack for IOS
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(UserDetails.email.toString(),'');

        if (validLink) {
          await _firebaseAuth.signInWithEmailLink(
            email: email,
            emailLink: deepLink.toString(),
          );
          if (_firebaseAuth.currentUser != null) {

            ///Register User here
            registerUser(context!);
            return AppResponse.success(
              id: 'retrieveDynamicLinkAndSignIn',
            );
          } else {
            developer.log('userCredential.user is [${_firebaseAuth.currentUser}]');
          }
        } else {
          developer.log('Link is not valid');
          return AppResponse.error(
            id: 'retrieveDynamicLinkAndSignIn',
            message: noCredentialsWereFound,
          );
        }
      } else {
        developer.log('retrieveDynamicLinkAndSignIn.deepLink[$deepLink]');
      }
    } catch (e, s) {
      return AppResponse.error(
        id: 'retrieveDynamicLinkAndSignIn',
        error: e,
        stackTrace: s,
      );
    }
    return AppResponse.notFound(
      id: 'retrieveDynamicLinkAndSignIn',
      message: noCredentialsWereFound,
    );
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
    // prefs.setString(UserDetails.email.toString(),
    //     isChecked ? emailController.text.toString().trim() : "");
    // prefs.setString(UserDetails.password.toString(),
    //     isChecked ? passwordController.text.toString() : "");
    await showProgressBar(true);
    try {
      ApiServices.postRequest(
          url: API.login,
          params: {
            "email": bookingemailController.text.trim(),
            "password": passwordController.text,
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
            _navigationService.navigateAndReplace(dashboardViewRoute);
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
            log('registewr data: ${data}');
            final RegisterUserModel user =
            registerUserModelFromJson(json.encode(data).toString());

            var userData = user.user;
            prefs.setBool(UserDetails.islogin.toString(), true);
            prefs.setString(UserDetails.imgurl.toString(), "null");
            prefs.setString(
                UserDetails.firstname.toString(), userData.firstName);
            prefs.setString(UserDetails.lastname.toString(), userData.lastName);
            prefs.setString(UserDetails.fullname.toString(),
                userData.firstName + userData.lastName);
            prefs.setString(UserDetails.email.toString(), userData.email);
            //prefs.setString(UserDetails.phoneNumber.toString(),userData.phoneNumber);
            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "Registration successful",
            );
            _navigationService.popAllAndNavigateTo(dashboardViewRoute);
          },
          onError: (String message, bool isError) async {
            BaseCommonMethods.showSnackbar(
              context: context,
              msg: "User already registered",
            );
            await showProgressBar(false);
            await loginUser(context);
          });
    } catch (e) {
      BaseCommonMethods.appToast(
          msg: "User already registered", time: 7000);
      await loginUser(context);
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


/*
  Future<void> sendTicketReferencesToEmail(String recieversEmailId,List<String> ticketReferences) async {

    String ticketReferenceHTML = "";
    ticketReferences.forEach((refNo) {
      ticketReferenceHTML = ticketReferenceHTML + "<p style=\"margin: 0;\"><span style=\"color: #BEE73E;\"><strong>#$refNo</strong></span></p>";
    });


    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'api-key': BREVO_API_KEY
    };

    var request = http.Request('POST', Uri.parse('$BREVO_BASE_URL/smtp/email'));
    request.body = json.encode({
      "sender": {
        "name": "Innovation Explorer",
        "email": "retailhub@innovationexplorer.com"
      },
      "to": [
        {
          "email": recieversEmailId,
          "name": recieversEmailId.split("@")[0]
        }
      ],
      "subject": "Forgot Ticket References ?",
      "htmlContent":"<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"format-detection\" content=\"telephone=no\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title></title><style type=\"text/css\" emogrify=\"no\">#outlook a { padding:0; } .ExternalClass { width:100%; } .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; } table td { border-collapse: collapse; mso-line-height-rule: exactly; } .editable.image { font-size: 0 !important; line-height: 0 !important; } .nl2go_preheader { display: none !important; mso-hide:all !important; mso-line-height-rule: exactly; visibility: hidden !important; line-height: 0px !important; font-size: 0px !important; } body { width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0; } img { outline:none; text-decoration:none; -ms-interpolation-mode: bicubic; } a img { border:none; } table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; } th { font-weight: normal; text-align: left; } *[class=\"gmail-fix\"] { display: none !important; } </style><style type=\"text/css\" emogrify=\"no\"> @media (max-width: 600px) { .gmx-killpill { content: \' \03D1\';} } </style><style type=\"text/css\" emogrify=\"no\">@media (max-width: 600px) { .gmx-killpill { content: \' \03D1\';} .r0-o { border-style: solid !important; margin: 0 auto 0 auto !important; width: 320px !important } .r1-i { background-color: #000000 !important } .r2-c { box-sizing: border-box !important; text-align: center !important; valign: top !important; width: 100% !important } .r3-o { border-style: solid !important; margin: 0 auto 0 auto !important; width: 100% !important } .r4-i { background-color: #000000 !important; padding-bottom: 20px !important; padding-left: 15px !important; padding-right: 15px !important; padding-top: 20px !important } .r5-c { box-sizing: border-box !important; display: block !important; valign: top !important; width: 100% !important } .r6-o { border-style: solid !important; width: 100% !important } .r7-i { padding-left: 0px !important; padding-right: 0px !important } .r8-o { border-style: solid !important; margin: 0 auto 0 auto !important; margin-bottom: 0px !important; margin-top: 0px !important; width: 100% !important } .r9-i { padding-bottom: 15px !important; padding-top: 15px !important } .r10-c { box-sizing: border-box !important; text-align: left !important; valign: top !important; width: 100% !important } .r11-o { border-style: solid !important; margin: 0 auto 0 0 !important; margin-bottom: 0px !important; margin-top: 0px !important; width: 100% !important } .r12-i { padding-bottom: 0px !important; padding-left: 0px !important; padding-right: 0px !important; padding-top: 0px !important; text-align: center !important } .r13-i { padding-bottom: 20px !important; padding-left: 15px !important; padding-right: 15px !important; padding-top: 20px !important } .r14-o { border-style: solid !important; margin: 0 auto 0 0 !important; width: 100% !important } .r15-i { padding-bottom: 15px !important; padding-top: 15px !important; text-align: left !important } .r16-i { padding-bottom: 0px !important; padding-left: 10px !important; padding-right: 10px !important; padding-top: 0px !important } .r17-i { padding-top: 15px !important; text-align: center !important } .r18-c { box-sizing: border-box !important; padding: 0 !important; text-align: center !important; valign: top !important; width: 100% !important } .r19-o { border-style: solid !important; margin: 0 auto 0 auto !important; margin-bottom: 15px !important; margin-top: 15px !important; width: 100% !important } .r20-i { padding: 0 !important; text-align: center !important } .r21-r { background-color: #bee73e !important; border-radius: 4px !important; border-width: 0px !important; box-sizing: border-box; height: initial !important; padding: 0 !important; padding-bottom: 12px !important; padding-left: 5px !important; padding-right: 5px !important; padding-top: 12px !important; text-align: center !important; width: 100% !important } body { -webkit-text-size-adjust: none } .nl2go-responsive-hide { display: none } .nl2go-body-table { min-width: unset !important } .mobshow { height: auto !important; overflow: visible !important; max-height: unset !important; visibility: visible !important; border: none !important } .resp-table { display: inline-table !important } .magic-resp { display: table-cell !important } } </style><!--[if !mso]><!--><style type=\"text/css\" emogrify=\"no\">@import url(\"https://fonts.googleapis.com/css2?family=Lucida sans unicode\"); </style><!--<![endif]--><style type=\"text/css\">p, h1, h2, h3, h4, ol, ul { margin: 0; } a, a:link { color: #de3daf; text-decoration: underline } .nl2go-default-textstyle { color: #3b3f44; font-family: lucida sans unicode, lucida grande, sans-serif; font-size: 18px; line-height: 1.5; word-break: break-word } .default-button { color: #ffffff; font-family: lucida sans unicode, lucida grande, sans-serif; font-size: 16px; font-style: normal; font-weight: bold; line-height: 1.15; text-decoration: none; word-break: break-word } .default-heading1 { color: #1F2D3D; font-family: verdana, geneva, sans-serif, Arial; font-size: 36px; word-break: break-word } .default-heading2 { color: #1F2D3D; font-family: verdana, geneva, sans-serif, Arial; font-size: 32px; word-break: break-word } .default-heading3 { color: #1F2D3D; font-family: verdana, geneva, sans-serif, Arial; font-size: 24px; word-break: break-word } .default-heading4 { color: #1F2D3D; font-family: verdana, geneva, sans-serif, Arial; font-size: 18px; word-break: break-word } a[x-apple-data-detectors] { color: inherit !important; text-decoration: inherit !important; font-size: inherit !important; font-family: inherit !important; font-weight: inherit !important; line-height: inherit !important; } .no-show-for-you { border: none; display: none; float: none; font-size: 0; height: 0; line-height: 0; max-height: 0; mso-hide: all; overflow: hidden; table-layout: fixed; visibility: hidden; width: 0; } </style><!--[if mso]><xml> <o:OfficeDocumentSettings> <o:AllowPNG/> <o:PixelsPerInch>96</o:PixelsPerInch> </o:OfficeDocumentSettings> </xml><![endif]--><style type=\"text/css\">a:link{color: #de3daf; text-decoration: underline;}</style></head><body bgcolor=\"#000000\" text=\"#3b3f44\" link=\"#de3daf\" yahoo=\"fix\" style=\"background-color: #000000;\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" class=\"nl2go-body-table\" width=\"100%\" style=\"background-color: #000000; width: 100%;\"><tr><td> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"600\" align=\"center\" class=\"r0-o\" style=\"table-layout: fixed; width: 600px;\"><tr><td valign=\"top\" class=\"r1-i\" style=\"background-color: #000000;\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" align=\"center\" class=\"r3-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td class=\"r4-i\" style=\"background-color: #000000; padding-bottom: 20px; padding-top: 20px;\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><th width=\"100%\" valign=\"top\" class=\"r5-c\" style=\"font-weight: normal;\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r6-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td valign=\"top\" class=\"r7-i\" style=\"padding-left: 15px; padding-right: 15px;\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><td class=\"r2-c\" align=\"center\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"570\" class=\"r8-o\" style=\"table-layout: fixed; width: 570px;\"><tr><td class=\"r9-i\" style=\"font-size: 0px; line-height: 0px; padding-bottom: 15px; padding-top: 15px;\"> <img src=\"https://img.mailinblue.com/4783268/images/content_library/original/64ba45dc10ce306c5d556aa7.png\" width=\"570\" border=\"0\" style=\"display: block; width: 100%;\"></td> </tr></table></td> </tr><tr><td class=\"r10-c\" align=\"left\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r11-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td align=\"center\" valign=\"top\" class=\"r12-i nl2go-default-textstyle\" style=\"color: #3b3f44; font-family: lucida sans unicode,lucida grande,sans-serif; font-size: 18px; word-break: break-word; line-height: 1.5; text-align: center;\"> <div><h1 class=\"default-heading1\" style=\"margin: 0; color: #1f2d3d; font-family: verdana,geneva,sans-serif,Arial; font-size: 36px; word-break: break-word;\"><span style=\"color: #bee73e; font-family: Verdana; font-size: 36px;\">Forgot Your Ticket References ?</span></h1></div> </td> </tr></table></td> </tr></table></td> </tr></table></th> </tr></table></td> </tr></table><table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" align=\"center\" class=\"r3-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td class=\"r13-i\" style=\"padding-bottom: 20px; padding-top: 20px;\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><th width=\"100%\" valign=\"top\" class=\"r5-c\" style=\"font-weight: normal;\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r6-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td valign=\"top\" class=\"r7-i\" style=\"padding-left: 15px; padding-right: 15px;\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><td class=\"r2-c\" align=\"center\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"347\" class=\"r3-o\" style=\"table-layout: fixed; width: 347px;\"><tr><td class=\"r9-i\" style=\"font-size: 0px; line-height: 0px; padding-bottom: 15px; padding-top: 15px;\"> <img src=\"https://img.mailinblue.com/4783268/images/content_library/original/64c389f0ed08b803de1b493d.png\" width=\"347\" border=\"0\" style=\"display: block; width: 100%;\"></td> </tr></table></td> </tr></table></td> </tr></table></th> </tr></table></td> </tr></table><table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" align=\"center\" class=\"r3-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td class=\"r13-i\" style=\"padding-bottom: 20px; padding-top: 20px;\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><th width=\"100%\" valign=\"top\" class=\"r5-c\" style=\"font-weight: normal;\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r6-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td valign=\"top\" class=\"r7-i\" style=\"padding-left: 15px; padding-right: 15px;\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><td class=\"r10-c\" align=\"left\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r14-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td align=\"left\" valign=\"top\" class=\"r15-i nl2go-default-textstyle\" style=\"color: #3b3f44; font-family: lucida sans unicode,lucida grande,sans-serif; font-size: 18px; line-height: 1.5; word-break: break-word; padding-bottom: 15px; padding-top: 15px; text-align: left;\"> <div><p style=\"margin: 0;\"><span style=\"color: #bee73e;\">Here you go for the email id : </span><a href=\"\" style=\"color: #de3daf; text-decoration: underline;\"><span style=\"color: #bee73e;\"><strong>$recieversEmailId</strong></span></a><span style=\"color: #bee73e;\"><strong> </strong></span></p></div> </td> </tr></table></td> </tr></table></td> </tr></table></th> </tr></table></td> </tr></table><table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" align=\"center\" class=\"r3-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td class=\"r16-i\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><th width=\"100%\" valign=\"top\" class=\"r5-c\" style=\"font-weight: normal;\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r6-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td valign=\"top\" class=\"r7-i\"> <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\"><tr><td class=\"r10-c\" align=\"left\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r14-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td align=\"center\" valign=\"top\" class=\"r17-i nl2go-default-textstyle\" style=\"color: #3b3f44; font-family: lucida sans unicode,lucida grande,sans-serif; font-size: 18px; word-break: break-word; line-height: 1.5; padding-top: 15px; text-align: center;\"> <div><h3 class=\"default-heading3\" style=\"margin: 0; color: #1f2d3d; font-family: verdana,geneva,sans-serif,Arial; font-size: 24px; word-break: break-word;\"><span style=\"color: #bee73e; font-family: Verdana; font-size: 24px;\">List Of All the References of Tickets You have</span></h3></div> </td> </tr></table></td> </tr><tr><td class=\"r10-c\" align=\"left\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"100%\" class=\"r14-o\" style=\"table-layout: fixed; width: 100%;\"><tr><td align=\"center\" valign=\"top\" class=\"r12-i nl2go-default-textstyle\" style=\"color: #3b3f44; font-family: lucida sans unicode,lucida grande,sans-serif; font-size: 18px; line-height: 1.5; word-break: break-word; text-align: center; word-wrap: break-word;\"> <div><p style=\"margin: 0;\"> </p>$ticketReferenceHTML</div> </td> </tr></table></td> </tr><tr><td class=\"r18-c\" align=\"center\" style=\"align: center; padding-bottom: 15px; padding-top: 15px; valign: top;\"> <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" role=\"presentation\" width=\"300\" class=\"r19-o\" style=\"background-color: #bee73e; border-collapse: separate; border-color: #bee73e; border-radius: 4px; border-style: solid; border-width: 0px; table-layout: fixed; width: 300px;\"><tr><td height=\"18\" align=\"center\" valign=\"top\" class=\"r20-i nl2go-default-textstyle\" style=\"word-break: break-word; background-color: #bee73e; border-radius: 4px; color: #ffffff; font-family: lucida sans unicode, lucida grande, sans-serif; font-size: 16px; font-style: normal; line-height: 1.15; padding-bottom: 12px; padding-left: 5px; padding-right: 5px; padding-top: 12px; text-align: center;\"> <a href=\"https://retailhub.page.link/tobR\" class=\"r21-r default-button\" target=\"_blank\" data-btn=\"1\" style=\"font-style: normal; font-weight: bold; line-height: 1.15; text-decoration: none; word-break: break-word; word-wrap: break-word; display: inline-block; -webkit-text-size-adjust: none; color: #ffffff; font-family: lucida sans unicode, lucida grande, sans-serif; font-size: 16px;\"> <span><span style=\"color: #000000;\">Open Retail Hub App</span></span></a> </td> </tr></table></td> </tr></table></td> </tr></table></th> </tr></table></td> </tr></table></td> </tr></table></td> </tr></table></body></html>"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
*/



  Future<AppResponse> sendEmailLink(BuildContext context) async {
    String email = bookingemailController.text.trim();
    developer.log('sendEmailLink[$email]');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final actionCodeSettings = ActionCodeSettings(
        url: 'https://retailhub.page.link/passwordless',
        handleCodeInApp: true,
        androidPackageName: 'com.example.fluttermeet',
        iOSBundleId: 'com.example.fluttermeet',
      );
      developer.log('actionCodeSettings[${actionCodeSettings.asMap()}]');
      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        developer.log('onLink[${dynamicLinkData.link}]');
        ////Register or Login........
        await registerUser(context);
      }).onError((error) {
        developer.log('onLink.onError[$error]');
      });
      prefs.setString(UserDetails.email.toString(), email);
      //SPService.instance.setString('passwordLessEmail', email);
      return AppResponse.success(
        id: 'sendEmailLink',
      );
    } catch (e, s) {
      return AppResponse.error(
        id: 'sendEmailLink',
        error: e,
        stackTrace: s,
      );
    }
  }

  /*/// Cold state means the app was terminated.
  Future<AppResponse> retrieveDynamicLinkAndSignIn({
    required bool fromColdState,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString(UserDetails.email.toString())!;



      developer.log('retrieveDynamicLinkAndSignIn[$email]');
      if (email.isEmpty) {
        developer.log('retrieveDynamicLinkAndSignIn email is empty');
        return AppResponse.notFound(
          id: 'retrieveDynamicLinkAndSignIn',
          message: noCredentialsWereFound,
        );
      }

      PendingDynamicLinkData? dynamicLinkData;

      Uri? deepLink;
      if (fromColdState) {
        dynamicLinkData = await FirebaseDynamicLinks.instance.getInitialLink();
        if (dynamicLinkData != null) {
          deepLink = dynamicLinkData.link;
        }
      } else {
        dynamicLinkData = await FirebaseDynamicLinks.instance.onLink.first;
        deepLink = dynamicLinkData.link;
      }

      developer.log('deepLink => $deepLink');
      if (deepLink != null) {
        bool validLink =
        _firebaseAuth.isSignInWithEmailLink(deepLink.toString());

        /// Password- less hack for IOS
        if (!validLink && Platform.isIOS) {
          developer.log('Password- less hack for IOS deepLink is not valid');
          ClipboardData? data = await Clipboard.getData('text/plain');
          if (data != null) {
            developer.log('Get link from Clipboard => ${data.text}');
            final linkData = data.text ?? '';
            final link = Uri
                .parse(linkData)
                .queryParameters['link'] ?? "";
            developer.log(
              'Parsed Link => $link',
            );
            validLink = _firebaseAuth.isSignInWithEmailLink(link);
            if (validLink) {
              deepLink = Uri.parse(link);
            }
          }
        }

        /// End - Password- less hack for IOS
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(UserDetails.email.toString(), '');
        if (validLink) {
          await _firebaseAuth.signInWithEmailLink(
            email: email,
            emailLink: deepLink.toString(),
          );
          if (_firebaseAuth.currentUser != null) {
            return AppResponse.success(
              id: 'retrieveDynamicLinkAndSignIn',
            );
          } else {


            developer.log('userCredential.user is [${_firebaseAuth.currentUser}]');
          }
        } else {
          developer.log('Link is not valid');
          return AppResponse.error(
            id: 'retrieveDynamicLinkAndSignIn',
            message: noCredentialsWereFound,
          );
        }
      } else {
        developer.log('retrieveDynamicLinkAndSignIn.deepLink[$deepLink]');
      }
    } catch (e, s) {
      return AppResponse.error(
        id: 'retrieveDynamicLinkAndSignIn',
        error: e,
        stackTrace: s,
      );
    }
    return AppResponse.notFound(
      id: 'retrieveDynamicLinkAndSignIn',
      message: noCredentialsWereFound,
    );
  }*/

/*Future<void> signOut() async {
    try {
      AppLoader.show();
      await _firebaseAuth.signOut();
      Get.offAll(() => const SignInScreen());
    } catch (error, stackTrace) {
      developer.log(
        'signOut',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      AppLoader.hide();
    }
  }*/
}

