import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:retailhub/app/app.locator.dart';
import 'package:retailhub/services/navigation_service.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/route_names.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../methods/basecommon_methods.dart';
import '../../widgets/basecommon_widget.dart';
import 'login_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

class BookingView extends StatelessWidget {
  BookingView({Key? key}) : super(key: key);
  BaseCommonWidget _baseCommonWidget = BaseCommonWidget();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onViewModelReady: (model) => model.initLogin(),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            BodyWidget(),
            model.isSigningIn
                ? Container(
                    color: Colors.black38,
                    height: double.infinity,
                    child: Center(
                        child: _baseCommonWidget.getProgressBar(
                            model.isSigningIn, Colors.green)),
                  )
                : Container()
          ],
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

final _formkey = GlobalKey<FormState>();

UserObject? user;

class BodyWidget extends ViewModelWidget<LoginViewModel> {
  final NavigationService _navigationService = locator<NavigationService>();

   BodyWidget({
    Key? key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        var size = MediaQuery.of(context).size;
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10),
            height: viewportConstraints.maxHeight,
            width: viewportConstraints.maxWidth,
            color: Colors.black,
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              logoasset,
                              scale: 4,
                            ),
                          ),
                        ),
                        5.h.heightBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              onChanged: (s){
                                viewModel.notifyListeners();
                              },
                              controller: viewModel.bookingemailController,
                              cursorColor: primaryColor,
                              autocorrect: true,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: appFontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: CustomStrings.emailaddress,
                                hintStyle: MyTextStyle.hinttext,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: underColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: underColor),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            3.h.heightBox,
                            TextFormField(
                              onChanged: (s){
                                viewModel.notifyListeners();
                              },
                              obscureText: viewModel.isHidden,
                              controller: viewModel.ticketrefrenceController,
                              cursorColor: primaryColor,
                              autocorrect: true,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: appFontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: CustomStrings.ticketreference,
                                hintStyle: MyTextStyle.hinttext,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: underColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: underColor),
                                ),
                                suffix: InkWell(
                                    onTap: () {
                                      viewModel.togglePasswordView();
                                    },
                                    child: Icon(
                                      viewModel.isHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    )),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            2.h.heightBox,
                            Align(
                              alignment: Alignment.center,
                              child: Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: CheckboxListTile(
                                  activeColor: primaryColor,
                                  checkColor: Colors.white,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: viewModel.bookingagreecheck,
                                  onChanged: (bool? value) {
                                    viewModel.bookingagreecheck = value;
                                    viewModel.notifyListeners();
                                  },
                                  title: const Text(''),
                                  subtitle: Text(
                                    CustomStrings.iagree,
                                    style: MyTextStyle.agreetext,
                                  ),
                                ),
                              ),
                            ),
                            1.h.heightBox,
                            ElevatedButton(
                              onPressed: () {
                                print("Hola");
                                _navigationService.popAllAndNavigateTo(singleTicketViewRoute,arguments: {
                                  viewModel.bookingemailController.text:viewModel.ticketrefrenceController.text
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: (viewModel.bookingagreecheck! && viewModel.bookingemailController.text.isNotEmpty && viewModel.ticketrefrenceController.text.isNotEmpty)!
                                    ? primaryColor
                                    : Colors.grey,
                                onPrimary: const Color(0xff394512),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 1.5.h),
                                  child: Text(
                                    'MANAGE YOUR BOOKING',
                                    style: MyTextStyle.button2,
                                  ),
                                ),
                              ),
                            ),
                            2.h.heightBox,
                            TextButton(
                              onPressed: () {

                                // Get.toNamed(RoutesName.emailScreen);
                              },
                              child: Text(
                                CustomStrings.forgotticketreference,
                                style: MyTextStyle.smalltext,
                              ),
                            ),
                            2.h.heightBox,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  color: Colors.white30,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                ),
                                const Text(
                                  'or',
                                  style: TextStyle(color: grey),
                                ),
                                1.h.widthBox,
                                Container(
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  color: Colors.white30,
                                  // margin:
                                  //     const EdgeInsets.only(left: 1.0, right: 2.0),
                                ),
                              ],
                            ),
                            2.h.heightBox,
                            ElevatedButton(
                              onPressed: () {
                                viewModel.opensigninPage();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                onPrimary: const Color(0xff394512),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 1.5.h),
                                  child: Text(
                                    CustomStrings.loginbutton,
                                    style: MyTextStyle.button2,
                                  ),
                                ),
                              ),
                            ),
                            3.h.heightBox,
                            ElevatedButton(
                              onPressed: () async {
                                // await viewModel.linkedinLogin(
                                //     context, "LINK", "USER", "lin1@gmail.com");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (final BuildContext context) =>
                                        LinkedInUserWidget(
                                      appBar: AppBar(
                                        backgroundColor: backgroundColor,
                                        title: const Text('Retail Hub'),
                                      ),
                                      destroySession: viewModel.logoutUser,
                                      redirectUrl: viewModel.redirectUrl,
                                      clientId: viewModel.clientId,
                                      clientSecret: viewModel.clientSecret,
                                      projection: const [
                                        ProjectionParameters.id,
                                        ProjectionParameters.localizedFirstName,
                                        ProjectionParameters.localizedLastName,
                                        ProjectionParameters.firstName,
                                        ProjectionParameters.lastName,
                                        ProjectionParameters.profilePicture,
                                      ],
                                      onError: (final UserFailedAction e) {
                                        Navigator.pop(context);
                                        BaseCommonMethods.showSnackbar(
                                          context: context,
                                          msg: "Unable to login with linkedin",
                                        );
                                        print('Error: ${e.toString()}');
                                        print(
                                            'Error: ${e.stackTrace.toString()}');
                                      },
                                      onGetUserProfile:
                                          (final UserSucceededAction
                                              linkedInUser) async {
                                        print(
                                          'Access token ${linkedInUser.user.token.accessToken}',
                                        );

                                        print(
                                            'User id: ${linkedInUser.user.userId}');

                                        user = UserObject(
                                          firstName: linkedInUser.user
                                              .firstName!.localized!.label!,
                                          lastName: linkedInUser
                                              .user.lastName!.localized!.label!,
                                          email: linkedInUser
                                              .user
                                              .email!
                                              .elements![0]
                                              .handleDeep!
                                              .emailAddress!,
                                          profileImageUrl: linkedInUser
                                              .user
                                              .profilePicture!
                                              .displayImageContent!
                                              .elements![0]
                                              .identifiers![0]
                                              .identifier!,
                                        );
                                        print(linkedInUser.user);
                                        // Save an String value to 'action' key.
                                        await viewModel.saveSharedData(
                                            linkedInUser.user.firstName!
                                                .localized!.label!,
                                            linkedInUser.user.lastName!
                                                .localized!.label!,
                                            linkedInUser
                                                .user
                                                .email!
                                                .elements![0]
                                                .handleDeep!
                                                .emailAddress!,
                                            linkedInUser
                                                .user
                                                .profilePicture!
                                                .displayImageContent!
                                                .elements![0]
                                                .identifiers![0]
                                                .identifier!);

                                        // ignore: use_build_context_synchronously
                                        print(linkedInUser.user.firstName!.localized!.label!.toString());
                                        print(linkedInUser.user.lastName!.localized!.label!.toString());
                                        print(linkedInUser.user.email!.elements![0].handleDeep!.emailAddress!.toString());

                                        print("Ashraffafafsafshagsf");
                                        await viewModel.linkedinsignup(
                                            linkedInUser.user.firstName!.localized!.label!.toString(),
                                            linkedInUser.user.lastName!.localized!.label!.toString(),linkedInUser
                                            .user
                                            .email!
                                            .elements![0]
                                            .handleDeep!
                                            .emailAddress!.toString(),context
                                            );
                                      },
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              clipBehavior: Clip.none,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.h),
                                primary: whitetext,
                                onPrimary: const Color(0xff394512),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      linkedinicon,
                                      scale: 15,
                                    ),
                                  ),
                                  Text("Sign In with LinkedIn",
                                      style: MyTextStyle.button2),
                                ],
                              ),
                            ),
                            5.h.heightBox,
                            InkWell(
                              onTap: () {
                                viewModel.opensignupPage();
                              },
                              child: Center(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: CustomStrings.donthaveanaccount,
                                          style: MyTextStyle.already),
                                      TextSpan(
                                        text: CustomStrings.signUptextbutton,
                                        style: MyTextStyle.alreadybutton,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            15.h.heightBox,
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: CustomStrings.copyrightText,
                                        style: MyTextStyle.smalltext),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  managebooking(LoginViewModel viewModel, BuildContext context) {}
}
