import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/CustomStepper.dart';
import '../../widgets/FormHeader.dart';
import '../../widgets/basecommon_widget.dart';
import '../../widgets/text_field.dart';
import 'login_viewmodel.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final BaseCommonWidget _baseCommonWidget = BaseCommonWidget();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
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
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

bool? check = true;

class BodyWidget extends ViewModelWidget<LoginViewModel> {
  const BodyWidget({
    Key? key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
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
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: CustomStepper()),
                  Form(
                    key: formkey,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
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
                                  subtitle: Text(
                                    CustomStrings.iagree,
                                    style: MyTextStyle.agreetext,
                                  ),
                                ),
                              ),
                            ),
                            2.h.heightBox,
                            ElevatedButton(
                              onPressed: check!
                                  ? () =>
                                      completeRegisteration(viewModel, context,formkey)
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

  completeRegisteration(LoginViewModel viewModel, context, formkey) {
    if (formkey.currentState!.validate()) {
      viewModel.steps[0] = true;
      viewModel.registerUser(context);
    }
  }
}
