import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/basecommon_widget.dart';
import '../../widgets/text_field.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  BaseCommonWidget _baseCommonWidget = BaseCommonWidget();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onViewModelReady: (model) => model.initLogin(),
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
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

final formkey = GlobalKey<FormState>();
final _forgetformKey = GlobalKey<FormState>();

class BodyWidget extends ViewModelWidget<LoginViewModel> {
  const BodyWidget({
    Key? key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          body: Container(
            height: viewportConstraints.maxHeight,
            width: viewportConstraints.maxWidth,
            color: black,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      logoasset,
                      scale: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: greycolor,
                          borderRadius: BorderRadius.circular(33)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          3.h.heightBox,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: CustomStrings.accessyour,
                                    style: MyTextStyle.bigtext),
                                TextSpan(
                                  text: CustomStrings.retailHub,
                                  style: MyTextStyle.bigtext1,
                                ),
                              ],
                            ),
                          ),
                          Text(CustomStrings.account,
                              style: MyTextStyle.bigtext),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.5.h, vertical: 3.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "required";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    hintText: CustomStrings.emailaddress,
                                    label: '',
                                    textEditingController:
                                        viewModel.emailController),
                                3.h.heightBox,
                                CustomTextField(
                                  validator: (value) {

                                    if (value!.isEmpty) {
                                      return "required";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  obscureText: true,
                                  hintText: CustomStrings.password,
                                  label: '',
                                  textEditingController:
                                      viewModel.passwordController,
                                ),
                                3.h.heightBox,
                                ElevatedButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      viewModel.loginUser(context);
                                    }
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
                                        style: MyTextStyle.button,
                                      ),
                                    ),
                                  ),
                                ),
                                2.h.heightBox,
                                InkWell(
                                  onTap: (() {
                                    showDialog(
                                      barrierColor: Colors.black26,
                                      context: context,
                                      builder: (context) {
                                        return forgetPasswordDialog(
                                            viewModel, context);
                                      },
                                    );
                                  }),
                                  child: Text(
                                    CustomStrings.forgotyourpassword,
                                    style: MyTextStyle.smalltext,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ).pSymmetric(v: 4.h),
                  ],
                ).pSymmetric(h: 2.5.h),
              ),
            ),
          ),
        );
      },
    );
  }

  forgetPasswordDialog(LoginViewModel model, context) {
    return AlertDialog(
      backgroundColor: greycolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Forgot your password?',
        style: TextStyle(color: Colors.white),
      ),
      content: Form(
        key: _forgetformKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                onSaved: (value) {
                  FocusScope.of(context).unfocus();
                },
                hintText: CustomStrings.emailaddress,
                label: '',
                textEditingController: model.emailController),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4.5,
          child: FlatButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.1,
          child: ElevatedButton(
            onPressed: () {
              if (_forgetformKey.currentState!.validate()) {
                Navigator.pop(context);
                model.forgetpassword(context);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              onPrimary: const Color(0xff394512),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            child: Center(
              child: Text(
                CustomStrings.resetyourpassword,
                style: MyTextStyle.button,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
