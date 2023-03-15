import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/progressbar_widget.dart';
import '../../widgets/text_field.dart';
import '../../widgets/text_filed3.dart';
import 'profile_viewmodel.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);
  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, ProfileViewModel? viewModel, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () => Navigator.of(context!).pop(),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18.sp,
                    fontFamily: appFontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.help,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                )
              ],
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _bodyWidget(viewModel!),
                loadingView(viewModel.isLoading),
              ],
            ));
      },
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (ProfileViewModel model) {
        model.initModel(context);
      },
    );
  }

  final formkey = GlobalKey<FormState>();
  Widget _bodyWidget(ProfileViewModel viewModel) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  2.h.heightBox,
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor, shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              viewModel.firstName[0].toUpperCase(),
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              viewModel.lastName[0].toUpperCase(),
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  2.h.heightBox,
                     Visibility(
                    visible: viewModel.isLinkedinlogin,
                    child: Center(
                      child: Image.asset(
                        linkedinicon,
                        scale: 20,
                      ),
                    ),
                  ),
                    2.h.heightBox,
                  Center(
                    child: Text(
                      'Account Information',
                      style: TextStyle(
                        fontFamily: appFontFamily,
                        fontWeight: FontWeight.w600,
                        color: backgroundColor,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
               
                  2.h.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomTextField3(
                            label: 'First name',
                            hintText: 'First name',
                            textEditingController:
                                viewModel.firstnameController),
                      ),
                      3.h.widthBox,
                      Flexible(
                        child: CustomTextField3(
                            label: 'Last name',
                            hintText: 'Last name',
                            textEditingController:
                                viewModel.lastnameController),
                      ),
                    ],
                  ),
                  // 2.h.heightBox,
                  // Visibility(
                  //   visible: !viewModel.isLinkedinlogin,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Flexible(
                  //         child: CustomTextField3(
                  //             readOnly: true,
                  //             hintText: 'Phone',
                  //             label: 'Phone',
                  //             textEditingController: viewModel.phoneController),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  2.h.heightBox,
                  Row(
                    children: [
                      Flexible(
                        child: CustomTextField3(
                            readOnly: true,
                            label: 'Email ',
                            hintText: 'Email ',
                            textEditingController: viewModel.emailController),
                      ),
                    ],
                  ),
                  1.h.heightBox,
                  Visibility(
                    visible: viewModel.phoneController.text.trim().isNotEmpty,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (() {
                          showDialog(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) {
                              return changePasswordDialog(viewModel, context);
                            },
                          );
                        }),
                        child: Text(
                          'Change the password',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),
                  1.h.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          viewModel.updateAccount();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 7.5.h),
                            child: Center(
                              child: Text(
                                'Update',
                                style: MyTextStyle.button,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  final _forgetformKey = GlobalKey<FormState>();

  changePasswordDialog(ProfileViewModel model, context) {
    return AlertDialog(
      backgroundColor: greycolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text(
        'Change your password',
        style: TextStyle(color: Colors.white),
      ),
      content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
        child: Form(
          key: _forgetformKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter ${CustomStrings.currentpassword}';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  hintText: CustomStrings.currentpassword,
                  label: '',
                  textEditingController: model.currentPasswordController),
              2.h.heightBox,
              CustomTextField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter ${CustomStrings.newpassword}';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  hintText: CustomStrings.newpassword,
                  label: '',
                  textEditingController: model.newPasswordController),
              2.h.heightBox,
              CustomTextField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter ${CustomStrings.confirmyourpassword}';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  hintText: CustomStrings.confirmyourpassword,
                  label: '',
                  textEditingController: model.confirmPasswordController),
            ],
          ),
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
                model.changePassword(context);
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
