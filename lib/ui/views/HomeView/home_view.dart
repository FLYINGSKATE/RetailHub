import 'package:flutter/material.dart';
import 'package:retailhub/constants/app_assets.dart';
import 'package:retailhub/constants/route_names.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/myappbar.dart';
import '../../widgets/nodata_widget.dart';
import '../../widgets/progressbar_widget.dart';
import '../../widgets/video.dart';
import '../Dashboard/dashboard_view.dart';
import 'home_viewmodel.dart';
import 'package:video_player/video_player.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, HomeViewModel? viewModel, Widget? child) {
        return Scaffold(
            appBar: const MyAppBar(
              title: "",
              isLogo: true,
            ),
            resizeToAvoidBottomInset: false,
            body: _bodyWidget(viewModel!));
      },
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (HomeViewModel model) {
        model.initModel(context);
      },
    );
  }

  Widget _bodyWidget(HomeViewModel viewModel) {
    return Container(
      color: backgroundColor,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            1.h.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(CustomStrings.upcomingevents,
                      style: MyTextStyle.bigtext2),
                  InkWell(
                    onTap: (() {
                      viewModel.navigateToPage(eventsViewRoute);
                      // Get.toNamed(RoutesName.homePageEvent3);
                    }),
                    child: Row(
                      children: [
                        Text(CustomStrings.seeall, style: MyTextStyle.small),
                        1.w.widthBox,
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        )
                        // Image.asset(Helper.see, scale: 2.8),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              child: Container(
                height: 25.h,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: viewModel.eventsArticles.length<6?viewModel.eventsArticles.length:6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    viewModel.eventsArticles[index].imageName = viewModel.eventsArticles[index].imageName.replaceAll("35.246.127.78", "Staticprod.retailhub.ai");
                    return InkWell(
                      onTap: (() {

                        viewModel.navigateToDetails(viewModel.eventsArticles[index]);
                      }),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Image.network(
                          viewModel.eventsArticles[index].imageName,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: primaryColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(CustomStrings.innovationExplorer,
                      style: MyTextStyle.bigtext2),
                  InkWell(
                    onTap: () {
                      viewModel.navigateToPage(innovationViewRoute);
                    },
                    child: Row(
                      children: [
                        Text(CustomStrings.discovermore,
                            style: MyTextStyle.small),
                        1.w.widthBox,
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        )

                        // Image.asset(Helper.see, scale: 2.8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
              child: Container(
                height: 20.h,
                decoration: const BoxDecoration(),
                child: videoPlayerScreen(
                    VideoPlayerController.network(
                      CustomStrings.videoUrl,
                    ),
                    false,
                    false),
              ),
            ),
            Divider(
              thickness: 1,
              color: primaryColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(CustomStrings.coworking, style: MyTextStyle.bigtext2),
                  InkWell(
                    onTap: (() {
                      print('coworkingscreen');
                      viewModel.navigateToPage(coworkingViewRoute);
                    }),
                    child: Row(
                      children: [
                        Text(CustomStrings.discovermore,
                            style: MyTextStyle.small),
                        1.w.widthBox,
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        )

                        // Image.asset(Helper.see, scale: 2.8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (() {
                print('coworkingscreen');
                // Get.toNamed(RoutesName.coworkingscreen);
              }),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                margin: const EdgeInsets.all(10),
                child: Image.asset(coworking),
              ),
            ),
            Divider(
              thickness: 1,
              color: primaryColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(CustomStrings.trainingcourses,
                      style: MyTextStyle.bigtext2),
                  InkWell(
                    onTap: (() {
                      viewModel.navigateToPage(trainingViewRoute);
                    }),
                    child: Row(
                      children: [
                        Text(CustomStrings.seeall, style: MyTextStyle.small),
                        1.w.widthBox,
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        )

                        // Image.asset(Helper.see, scale: 2.8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              child: Container(
                height: 25.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: viewModel.trainingArticles.length>6?6:viewModel.trainingArticles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    viewModel.trainingArticles[index].imageName = viewModel.trainingArticles[index].imageName.replaceAll("35.246.127.78", "Staticprod.retailhub.ai");

                    return InkWell(
                      onTap: (() {
                        viewModel.navigateToDetails(viewModel.trainingArticles[index]);
                      }),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Image.network(
                          viewModel.trainingArticles[index].imageName,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
