import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:retailhub/app/app.locator.dart';
import 'package:retailhub/services/navigation_service.dart';
import 'package:retailhub/ui/views/Authentication/authentication_viewmodel.dart';
import 'package:retailhub/ui/widgets/text_field.dart';
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

class AuthenticationView extends StatelessWidget {
  AuthenticationView({Key? key}) : super(key: key);
  BaseCommonWidget _baseCommonWidget = BaseCommonWidget();

  @override
  Widget build(BuildContext context) {

    print("Authentication view");

    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      onViewModelReady: (model) => model.initLogin(context),
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
      viewModelBuilder: () => AuthenticationViewModel(),
    );
  }
}

final _formkey = GlobalKey<FormState>();

UserObject? user;

class BodyWidget extends ViewModelWidget<AuthenticationViewModel> {
  final NavigationService _navigationService = locator<NavigationService>();


   BodyWidget({
    Key? key,
  }) : super(key: key, reactive: true);

  final _forgetformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, AuthenticationViewModel viewModel) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        var size = MediaQuery.of(context).size;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            padding: const EdgeInsets.all(10),
            height: viewportConstraints.maxHeight,
            width: viewportConstraints.maxWidth,
            color: Colors.black,
            child: SingleChildScrollView(
              physics:NeverScrollableScrollPhysics(),
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
                              viewModel.isValidEmailAddress = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(s);

                              if(!viewModel.isValidEmailAddress!){
                                viewModel.emailErrortext = "Please Enter a valid Email Address";
                              }
                              else{
                                viewModel.emailErrortext = null;
                              }
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
                              errorText: viewModel.emailErrortext,
                              hintText: CustomStrings.emailaddress,
                              hintStyle: MyTextStyle.hinttext,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: underColor),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder:UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
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

                          2.h.heightBox,

                          2.h.heightBox,
                          ElevatedButton(
                            onPressed: () {
                              viewModel.signInWithEmailLink(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.h),
                              backgroundColor: (viewModel.bookingagreecheck! && viewModel.isValidEmailAddress!)!
                                  ? primaryColor
                                  : Colors.grey,
                              foregroundColor: const Color(0xff394512),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 1.5.h),
                                child: Text(
                                  CustomStrings.getstarted,
                                  style: MyTextStyle.button2,
                                ),
                              ),
                            ),
                          ),
                          42.h.heightBox,
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
          ),
        );
      },
    );
  }



  managebooking(LoginViewModel viewModel, BuildContext context) {}
}
