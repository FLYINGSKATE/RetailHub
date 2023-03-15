import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../../utill/helper.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/progressbar_widget.dart';
import '../../widgets/text_filed3.dart';
import 'innovation_viewmodel.dart';

import 'package:footer/footer.dart';

class InnovationView extends StatefulWidget {
  const InnovationView({Key? key}) : super(key: key);
  @override
  InnovationViewState createState() => InnovationViewState();
}

class InnovationViewState extends State<InnovationView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext? context, InnovationViewModel? viewModel,
          Widget? child) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _bodyWidget(viewModel!),
                loadingView(viewModel.isLoading),
              ],
            ));
      },
      viewModelBuilder: () => InnovationViewModel(),
      onViewModelReady: (InnovationViewModel model) {
        model.initModel(context);
      },
    );
  }

  final formkey = GlobalKey<FormState>();
  Widget _bodyWidget(InnovationViewModel viewModel) {
    return Container(
      color: backgroundColor,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    back,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(logoasset, scale: 9),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.navigateToWebView();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: const Color(0xff394512),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 2.h),
                            child: Text(
                              CustomStrings.signIntextbutton,
                              style: MyTextStyle.signbtn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 42.h,
                  left: 4.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: CustomStrings.theInnovationyou,
                                style: MyTextStyle.mobilehome),
                            TextSpan(
                              text: CustomStrings.allinone,
                              style: MyTextStyle.mobilehomecolor,
                            ),
                            TextSpan(
                              text: CustomStrings.place,
                              style: MyTextStyle.mobilehome,
                            ),
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      Text(
                          textAlign: TextAlign.justify,
                          CustomStrings.theworldsfirst,
                          style: MyTextStyle.secondtext),
                    ],
                  ),
                ),
                Positioned(
                  top: 70.h,
                  right: 1.h,
                  left: 1.h,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Get.offAllNamed(token1 == null
                            //     ? RoutesName.innovationLogin
                            //     : RoutesName.dashboard);
                            // Get.offAllNamed(RoutesName.innovationEmailScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            onPrimary: const Color(0xff394512),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 2.h),
                              child: Center(
                                child: Text(
                                  CustomStrings.startyour,
                                  style: MyTextStyle.button1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        3.h.heightBox,
                        Image.asset(schermata),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: darkgrey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.h, vertical: 0.5.h),
                      child: Text(
                        CustomStrings.valueproposition,
                        style: MyTextStyle.colortext,
                      ),
                    ),
                  ),
                  2.h.heightBox,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: CustomStrings.InnovationExplorer,
                            style: MyTextStyle.Invocation),
                        TextSpan(
                          text: CustomStrings.sharingthemost,
                          style: MyTextStyle.mobilehome,
                        ),
                      ],
                    ),
                  ),
                  2.h.heightBox,
                  Text(
                      textAlign: TextAlign.justify,
                      CustomStrings.poweredby,
                      style: MyTextStyle.secondtext),
                ],
              ),
            ),
            2.h.heightBox,
            const Divider(
              thickness: 0.8,
              color: Color(0xff646464),
            ),
            2.h.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: darkgrey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.h, vertical: 0.5.h),
                      child: Text(
                        CustomStrings.features,
                        style: MyTextStyle.colortext,
                      ),
                    ),
                  ),
                  2.h.heightBox,
                  Center(
                    child: Text(
                        textAlign: TextAlign.justify,
                        CustomStrings.aboutour,
                        style: MyTextStyle.mobilehome),
                  ),
                  3.h.heightBox,
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 35.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              // horizontal: 5.h,
                              // vertical: 8.h,
                              ),
                          child: Center(
                            child: Text(
                              // textAlign: TextAlign.justify,
                              CustomStrings.InnovationExploreristhe,
                              style: MyTextStyle.aboutuscard,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        left: -1.5.h,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: whitetext,
                                  style: BorderStyle.solid,
                                  width: 3),
                              color: const Color(0xff111111),
                              shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                  3.h.heightBox,
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 35.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: whitetext,
                              style: BorderStyle.solid,
                              width: 1),
                          color: mobileColor,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 8.h,
                          ),
                          child: Center(
                            child: Text(
                              CustomStrings.newsletter,
                              style: MyTextStyle.mobilehome,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        left: -1.5.h,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                  3.h.heightBox,
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 35.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: whitetext,
                              style: BorderStyle.solid,
                              width: 1),
                          color: mobileColor,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 8.h,
                          ),
                          child: Center(
                            child: Text(
                              CustomStrings.global,
                              style: MyTextStyle.mobilehome,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        left: -1.5.h,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                  3.h.heightBox,
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 35.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: whitetext,
                              style: BorderStyle.solid,
                              width: 1),
                          color: mobileColor,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 8.h,
                          ),
                          child: Center(
                            child: Text(
                              CustomStrings.mission,
                              style: MyTextStyle.mobilehome,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        left: -1.5.h,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                  3.h.heightBox,
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 35.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: whitetext,
                              style: BorderStyle.solid,
                              width: 1),
                          color: mobileColor,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 8.h,
                          ),
                          child: Center(
                            child: Text(
                              CustomStrings.chat,
                              style: MyTextStyle.mobilehome,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16.h,
                        left: -1.5.h,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryColor, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            5.h.heightBox,
            const Divider(
              thickness: 0.8,
              color: Color(0xff646464),
              height: 1,
              // endIndent: 15
            ),
            const Divider(
              thickness: 0.8, color: const Color(0xff646464),
              // indent: 15
            ),
            5.h.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: CustomStrings.num,
                            style: MyTextStyle.mobilehomecolor),
                        TextSpan(
                          text: CustomStrings.startups,
                          style: MyTextStyle.mobilehome,
                        ),
                      ],
                    ),
                  ),
                ),
                3.h.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.h),
                  child: InkWell(
                    onTap: (() {
                      print('+2000 Startups Scaleups Unicorns');
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: whitetext,
                            style: BorderStyle.solid,
                            width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Center(
                            child: Text(CustomStrings.startyourfree,
                                style: MyTextStyle.startfreebtn)),
                      ),
                    ),
                  ),
                ),
                3.h.heightBox,
                const Divider(thickness: 1, color: Color(0xff646464)),
                3.h.heightBox,
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: CustomStrings.morethan26,
                            style: MyTextStyle.mobilehome),
                        TextSpan(
                          text: CustomStrings.retailsectors,
                          style: MyTextStyle.mobilehomecolor,
                        ),
                      ],
                    ),
                  ),
                ),
                3.h.heightBox,
                SizedBox(
                  height: 50.h,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2),
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: darkgrey1,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              viewModel.textList[index],
                              style: MyTextStyle.morecontainer,
                            ),
                          ),
                        );
                      }),
                ),
                const Divider(
                  thickness: 0.8,
                  color: const Color(0xff646464),
                ),
                3.h.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: darkgrey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 0.5.h),
                          child: Text(
                            CustomStrings.newjoiners,
                            style: MyTextStyle.colortext,
                          ),
                        ),
                      ),
                      2.h.heightBox,
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: CustomStrings.thousands,
                                style: MyTextStyle.Invocation),
                            TextSpan(
                              text: CustomStrings.arealreadyon,
                              style: MyTextStyle.mobilehome,
                            ),
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 32.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: whitetext,
                                  style: BorderStyle.solid,
                                  width: 1),
                              color: mobileColor,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.h,
                                vertical: 6.h,
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(power, scale: 4),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('FONDATION DATE:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                        Text(' 2005',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('SECTOR:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                        Text(' CATEGORY',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('LAST FOUND RAISING:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                        Text(' \$ 1000000',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('TECHNOLOGY:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8.h,
                            left: -1.5.h,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: primaryColor, shape: BoxShape.circle),
                            ),
                          )
                        ],
                      ),
                      5.h.heightBox,
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 30.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: whitetext,
                                  style: BorderStyle.solid,
                                  width: 1),
                              color: mobileColor,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.h,
                                vertical: 4.h,
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(scalapay, scale: 4),
                                    1.h.heightBox,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('FONDATION DATE:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                        Text(' 2005',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('SECTOR:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                        Text(' CATEGORY',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('LAST FOUND RAISING:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                        Text(' \$ 1000000',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('TECHNOLOGY:',
                                            style: TextStyle(
                                                fontFamily: appFontFamily,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -1.h,
                            left: -1.5.h,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: primaryColor, shape: BoxShape.circle),
                            ),
                          )
                        ],
                      ),
                      3.h.heightBox,
                      Center(
                        child: Text(CustomStrings.trustedby,
                            style: MyTextStyle.mobilehome),
                      ),
                      3.h.heightBox,
                      Container(
                        height: 6.h,
                        color: Colors.transparent,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: viewModel.imageList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (() {
                                // Get.toNamed(RoutesName.homePageEvent1);
                              }),
                              child: Container(
                                color: Colors.transparent,
                                child: Image.asset(
                                  scale: 3,
                                  viewModel.imageList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                2.h.heightBox,
                const Divider(
                  thickness: 0.8,
                  color: const Color(0xff646464),
                ),
                3.h.heightBox,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 3.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: greycolor,
                        borderRadius: BorderRadius.circular(33)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff5e5d5d),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.h, vertical: 0.5.h),
                              child: Text(
                                CustomStrings.newarticle,
                                style: MyTextStyle.colortext,
                              ),
                            ),
                          ),
                          2.h.heightBox,
                          Text(
                            CustomStrings.categorymanagement,
                            style: MyTextStyle.mobilehome,
                          ),
                          3.h.heightBox,
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 10.h),
                                child: Text(
                                  CustomStrings.seemore,
                                  style: MyTextStyle.button1,
                                ),
                              ),
                            ),
                          ),
                          3.h.heightBox,
                          Image.asset(mask),
                          2.h.heightBox,
                        ],
                      ),
                    ),
                  ),
                ),
                3.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(backarrow, scale: 3),
                    2.h.widthBox,
                    Image.asset(backarrow1, scale: 3),
                  ],
                ),
                5.h.heightBox,
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff5e5d5d),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.h, vertical: 0.5.h),
                          child: Text(
                            'CONTACT',
                            style: MyTextStyle.colortext,
                          ),
                        ),
                      ),
                      3.h.heightBox,
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                                text: CustomStrings.wantmore,
                                style: MyTextStyle.mobilehome),
                            TextSpan(
                              text: CustomStrings.informations,
                              style: MyTextStyle.mobilehomecolor,
                            ),
                            TextSpan(
                              text: CustomStrings.aboutwhat,
                              style: MyTextStyle.mobilehome,
                            ),
                          ],
                        ),
                      ),
                      3.h.heightBox,
                      Text(CustomStrings.sendusan,
                          textAlign: TextAlign.center,
                          style: MyTextStyle.secondtext),
                      3.h.heightBox,
                      InkWell(
                        onTap: (() {
                          print('START YOUR FREE TRIAL');
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 11.h),
                            child: Text(
                              'CONTACT US',
                              style: MyTextStyle.button1,
                            ),
                          ),
                        ),
                      ),
                      2.h.heightBox,
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: whitetext,
                              style: BorderStyle.solid,
                              width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 4.h),
                          child: Text(
                            'START YOUR FREE TRIAL',
                            style: MyTextStyle.startfreebtn,
                          ),
                        ),
                      ),
                      2.h.heightBox,
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: whitetext,
                              style: BorderStyle.solid,
                              width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 8.h),
                          child: Text(
                            'SUBMIT STARTUP',
                            style: MyTextStyle.startfreebtn,
                          ),
                        ),
                      ),
                      5.h.heightBox,
                      const Divider(
                        thickness: 0.8,
                        color: const Color(0xff646464),
                      ),
                      5.h.heightBox,
                      Image.asset(logoasset, scale: 4),
                      5.h.heightBox,
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Subscribe to our\n',
                                style: MyTextStyle.mobilehome),
                            TextSpan(
                              text: 'newsletter',
                              style: MyTextStyle.mobilehomecolor,
                            ),
                          ],
                        ),
                      ),
                      3.h.heightBox,
                      Text('Useful links', style: MyTextStyle.Useful),
                      3.h.heightBox,
                      Text('Blog', style: MyTextStyle.links),
                      3.h.heightBox,
                      Text('Features', style: MyTextStyle.links),
                      3.h.heightBox,
                      Text('Events', style: MyTextStyle.links),
                      3.h.heightBox,
                      Text('Success stories', style: MyTextStyle.links),
                      3.h.heightBox,
                      Text('Reviews', style: MyTextStyle.links),
                      5.h.heightBox,
                      Text('Follow us', style: MyTextStyle.Useful),
                      5.h.heightBox,
                      InkWell(
                        onTap: launchFacebook,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(facebook, scale: 5),
                            2.h.widthBox,
                            Text('Facebook', style: MyTextStyle.links)
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      InkWell(
                        onTap: launchInstagram,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(instagram, scale: 5),
                            2.h.widthBox,
                            Text('Instagram', style: MyTextStyle.links)
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      InkWell(
                        onTap: launchLinkedin,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(linkedin1, scale: 5),
                            3.h.widthBox,
                            Text('LinkedIn', style: MyTextStyle.links)
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      InkWell(
                        onTap: launchYoutube,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(youtube, scale: 5),
                            3.5.h.widthBox,
                            Text('Youtube', style: MyTextStyle.links)
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      InkWell(
                        onTap: launchTwitter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(twitter, scale: 5),
                            4.h.widthBox,
                            Text('Twitter', style: MyTextStyle.links)
                          ],
                        ),
                      ),
                      5.h.heightBox,
                      Text('More info', style: MyTextStyle.Useful),
                      3.h.heightBox,
                      Text('About us', style: MyTextStyle.links),
                      3.h.heightBox,
                      Text('Terms and Conditions', style: MyTextStyle.links),
                      3.h.heightBox,
                      Text('Trust, Safety & Security',
                          style: MyTextStyle.links),
                      5.h.heightBox,
                      const Divider(
                        thickness: 0.8,
                        color: const Color(0xff646464),
                      ),
                    ],
                  ),
                ),
                Footer(
                  backgroundColor: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        '© 2021 Retail Hub Srl | Registered office and\noperational headquarters: 65 Gloucester Pl\nMarylebone, London W1U 8JL',
                        style: MyTextStyle.footer,
                      ),
                      3.h.heightBox,
                      Text(
                        textAlign: TextAlign.center,
                        'PI: 10819380964 | REA: MI – 2559507 | Share capital:\n€ 10,000.00 iv | Privacy Policy | Cookie Policy',
                        style: MyTextStyle.footer,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
