import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/custom_strings.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/progressbar_widget.dart';
import 'setting_viewmodel.dart';


class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);
  @override
  SettingViewState createState() => SettingViewState();
}

class SettingViewState extends State<SettingView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, SettingViewModel? viewModel, Widget? child) {
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
      viewModelBuilder: () => SettingViewModel(),
      onModelReady: (SettingViewModel model) {
        model.initModel(context);
      },
    );
  }

  Widget _bodyWidget(SettingViewModel viewModel) {
    return Stack(
      children: [
        HeaderWidget(
          title: "Setting",
          isProfile: false,
          imgurl: "",
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .10,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: ListView(
                  children: ListTile.divideTiles(
                      //          <-- ListTile.divideTiles
                      context: context,
                      tiles: [
                        ListTile(
                          onTap: () {
                            // LaunchReview.launch();
                          },
                          leading: const Icon(Icons.rate_review),
                          title: const Text("Rate Us"),
                        ),

                        ListTile(
                          leading: const Icon(Icons.security),
                          onTap: () {
                            viewModel.navigateToPrivacy(privacy,privacyfile);
                            // _displayPrivacy();
                          },
                          title: const Text('Privacy Policy'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.branding_watermark),
                          onTap: () {
                             viewModel.navigateToPrivacy(terms,termsfile);
                          },
                          title: const Text('Terms & Conditions'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.info),
                          onTap: () {
                           viewModel.navigateToPrivacy(aboutus,aboutfile);
                          },
                          title: const Text('About'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          onTap: () {
                            viewModel.logOutUser();
                          },
                          title: const Text('Logout'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Visibility(
                        //   visible: Constants.ISADSENABLED,
                        //   child: AdmobBanner(
                        //     adUnitId: Constants.BANNER_ADS_UNIT,
                        //     adSize: AdmobBannerSize.LARGE_BANNER,
                        //   ),),
                      ]).toList(),
                )),
          ),
        ),
      ],
    );
  }
}
