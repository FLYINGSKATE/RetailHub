import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference ticketsCollectionReference = FirebaseFirestore.instance.collection('/Tickets');
  CollectionReference eventsCollectionReference = FirebaseFirestore.instance.collection('/Events');
  CollectionReference usersCollectionReference = FirebaseFirestore.instance.collection('/Users');


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

  static const BREVO_API_KEY = "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";
  static const BREVO_BASE_URL = "https://api.brevo.com/v3";
  initMethod(BuildContext context) async {}
  initLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString(UserDetails.email.toString()) ?? '';
    passwordController.text = prefs.getString(UserDetails.password.toString()) ?? '';
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
    // prefs.setString(UserDetails.email.toString(),
    //     isChecked ? emailController.text.toString().trim() : "");
    // prefs.setString(UserDetails.password.toString(),
    //     isChecked ? passwordController.text.toString() : "");
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
            final UserModel user =
                userModelFromJson(json.encode(data).toString());
            log(user.data.user.firstName);
            var userData = user.data.user;
            prefs.setBool(UserDetails.islogin.toString(), true);
            prefs.setString(UserDetails.firstname.toString(), userData.firstName);
            prefs.setString(UserDetails.lastname.toString(), userData.lastName);
            prefs.setString(UserDetails.fullname.toString(), userData.firstName + userData.lastName);
            prefs.setString(UserDetails.email.toString(), userData.email);
            prefs.setString(UserDetails.phoneNumber.toString(), userData.phoneNumber);
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
            prefs.setString(UserDetails.firstname.toString(), userData.firstName);
            prefs.setString(UserDetails.lastname.toString(), userData.lastName);
            prefs.setString(UserDetails.fullname.toString(), userData.firstName + userData.lastName);
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

  Future<void> forgetticketReference(BuildContext context) async {
    await showProgressBar(true);
    List<String> ticketRefNos = [];
    try{

      //Fetch all the tickets reference from firebase for the user

      //Fetch Email Id From Shared Preferences
      String emailId = emailController.text;
      print("User Collection Fec "+(emailId));

      //Get Reference of the Participants From Email Id
      DocumentReference? participantReference ;
      await usersCollectionReference.where('Email',isEqualTo: emailId).get().then((value) {
        if(value.docs.length==0){
          ///The User email have no tickets
          //Don't Send Email Just give them notification to buy tickets & Exit method
          showProgressBar(false);
          notifyListeners();
          BaseCommonMethods.appToast(
              msg: "We couldn't find an account with that email address.",
              time: 2000);
          return;
        }
        participantReference = value.docs.first.reference;
      });

      await ticketsCollectionReference.where('ParticipantsDetails', isEqualTo: participantReference).get().then((QuerySnapshot querySnapshot) async {
        print("Tickets");
        print(querySnapshot.docs.first.data());
        print(querySnapshot.docs.length);

        if(querySnapshot.docs.length==0){
          showProgressBar(false);
          notifyListeners();
          BaseCommonMethods.appToast(
              msg: "We couldn't find any tickets for .$emailId",
              time: 2000);
          return;

        }

        for(int i=0;i<querySnapshot.docs.length;i++){
          print(querySnapshot.docs[i].id);
          print(querySnapshot.docs[i].data());

          ticketRefNos.add(querySnapshot.docs[i].get("ReferenceNumber"));

         // _tickets.add(TicketsModal.fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>) as TicketsModal);
          /*await querySnapshot.docs[i]["EventDetails"].get().then((eventSnapshot) {
            print(eventSnapshot);
            print(eventSnapshot.data());
            //_events.add(EventsModal.fromJson(eventSnapshot.data() as Map<String, dynamic>) as EventsModal);
          });
          await querySnapshot.docs[i]["ParticipantsDetails"].get().then((participantSnapshot) {
            print(participantSnapshot);
            print(participantSnapshot.data());
           // _participants.add(ParticipantsModal.fromJson(participantSnapshot.data() as Map<String, dynamic>) as ParticipantsModal);
          });*/

          //CALL BREVO API HERE



        }
      }).onError((error, stackTrace) {
        print("Firebase Error");
        print(error);
      });
      sendTicketReferencesToEmail(emailId,ticketRefNos);
      showProgressBar(false);
      notifyListeners();
      BaseCommonMethods.appToast(
          msg: "Please check your email $emailId for all ticket references you have.",
          time: 2000);
      //Send an email from brevo
    }
    catch(e){
      BaseCommonMethods.appToast(
          msg: "We couldn't find an account with that email address.",
          time: 2000);

      await showProgressBar(false);
    }


    /*try {
      ApiServices.postRequest(
          url: "${API.forgetpassword}/${emailController.text}",
          params: {
            "email": emailController.text,
          },
          onSuccess: (var data) async {
            await showProgressBar(false);
            BaseCommonMethods.appToast(
                msg: "Please check your email for all ticket references you have.",
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
    }*/
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
      print("AsasaasasassssssssssssssssssssssssssIOIOI");
      _navigationService.pop();
      _navigationService.navigateTo(dashboardViewRoute);
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
