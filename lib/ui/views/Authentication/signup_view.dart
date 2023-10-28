import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:retailhub/ui/views/Authentication/signup_viewmodel.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../app/app.locator.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/route_names.dart';
import '../../../constants/string.dart';
import '../../../services/navigation_service.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/CustomStepper.dart';
import '../../widgets/FormHeader.dart';
import '../../widgets/basecommon_widget.dart';
import '../../widgets/text_field.dart';
import 'login_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final BaseCommonWidget _baseCommonWidget = BaseCommonWidget();

  @override
  Widget build(BuildContext context) {

    print("SignUp View ");

    return ViewModelBuilder<SignUpViewModel>.reactive(
      onViewModelReady: (model) => model.initMethod(context),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            const BodyWidget(),
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
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}

bool? check = false;

class BodyWidget extends ViewModelWidget<SignUpViewModel> {
  const BodyWidget({
    Key? key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    final formkey = GlobalKey<FormState>();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          body: Container(
            height: viewportConstraints.maxHeight,
            width: viewportConstraints.maxWidth,
            padding: const EdgeInsets.all(10),
            color: backgroundColor,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 1,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        logoasset,
                        scale: 5.5,
                      ),
                    ),
                  ),
                  // Container(
                  //     margin: const EdgeInsets.only(top: 10),
                  //     child: CustomStepper()),
                  Form(
                    key: formkey,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: greycolor,
                          borderRadius: BorderRadius.circular(33)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.5.h, vertical: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              CustomStrings.businessemail,
                              style: MyTextStyle.labelStyle,
                            ),
                            1.h.heightBox,
                            CustomTextField(
                              label: '',
                              textEditingController: viewModel.busienssemail,
                              validator: (value) {
                                if (value == '') {
                                  return "required";
                                }
                              },
                            ),
                            3.h.heightBox,
                            Text(
                              CustomStrings.firstName,
                              style: MyTextStyle.labelStyle,
                            ),
                            1.h.heightBox,
                            CustomTextField(
                              label: '',
                              textEditingController: viewModel.firstname,
                              validator: (value) {
                                if (value == '') {
                                  return "required";
                                }
                              },
                            ),
                            3.h.heightBox,
                            Text(
                              CustomStrings.lastName,
                              style: MyTextStyle.labelStyle,
                            ),
                            1.h.heightBox,
                            CustomTextField(
                              label: '',
                              textEditingController: viewModel.lastname,
                              validator: (value) {
                                if (value == '') {
                                  return "required";
                                }
                              },
                            ),
                            3.h.heightBox,
                            Text(
                              CustomStrings.setyourpassword,
                              style: MyTextStyle.labelStyle,
                            ),
                            1.h.heightBox,
                            CustomTextField(
                              obscureText: true,
                              label: '',
                              textEditingController: viewModel.password,
                              validator: (value) {
                                if (value == '') {
                                  return "required";
                                }
                              },
                            ),
                            3.h.heightBox,
                            Text(
                              CustomStrings.phoneNumber,
                              style: MyTextStyle.labelStyle,
                            ),
                            1.h.heightBox,
                            CustomTextField(
                              type: TextInputType.number,
                              onChanged: (value) {
                                if (value!.length == 10) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
                                } else if (value.length < 10) {
                                  return "enter a valid phone number";
                                }
                                return null;
                              },
                              label: '',
                              textEditingController: viewModel.phone,
                            ),
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
                                    value: check,
                                    onChanged: (bool? value) {
                                      check = value;
                                      viewModel.notifyListeners();
                                    },
                                    title: const Text(''),
                                    subtitle: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'I Agree to the RetailHub’s ',
                                          ),
                                          TextSpan(
                                            text: "Terms And Condition",
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.blue,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap =
                                                  () => _launchUrl(context),
                                          ),
                                          TextSpan(
                                            text:
                                                ', Privacy Policy and Security Policy, including Cookie Use Policy',
                                            style: MyTextStyle.agreetext,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            2.h.heightBox,
                            ElevatedButton(
                              onPressed: check!
                                  ? () => completeRegisteration(
                                      viewModel, context, formkey)
                                  : null,
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
                                    CustomStrings.completeregistrationbutton,
                                    style: MyTextStyle.button2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).pSymmetric(h: 2.h),
                  ),
                  3.h.heightBox,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _launchUrl(BuildContext context) async {
    final NavigationService _navigationService = locator<NavigationService>();

    _navigationService.navigateTo(innovationWebViewRoute,
        arguments: CustomStrings.termsconditionlink);
    // if (await canLaunch(CustomStrings.termsconditionlink)) {
    //   await launch(CustomStrings.termsconditionlink);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Error launching URL'),
    //     ),
    //   );
    // }
  }

  completeRegisteration(SignUpViewModel viewModel, context, formkey) {
    if (formkey.currentState!.validate()) {
      viewModel.steps[0] = true;
      viewModel.registerUser(context);
    }
  }
}
