import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:retailhub/model/startup_model.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/app.locator.dart';
import '../../constants/app_colors.dart';
import '../../constants/route_names.dart';
import '../../constants/string.dart';
import '../../model/article_model.dart';
import '../../services/navigation_service.dart';
import '../../utill/app_text_style.dart';

class StartUpsDetailsPage extends StatelessWidget {
  final startup;
  StartUpsDetailsPage({
    Key? key,
    required this.startup,
  }) : super(key: key);
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(startup.companyLegalName.toString()),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: startup.logo??"",
                  placeholder: (context, url) => const Center(child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit
                      .cover, // adjusts the size of the image to cover the entire box

                  height: 200, // specify the height of the box
                ),
                2.h.heightBox,
                Text(startup.companyLegalName.toString(), style: MyTextStyle.apptitle),
                2.h.heightBox,
                Text(startup.companyDescription.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''), style: MyTextStyle.bodyText),
                2.h.heightBox,
                ElevatedButton(
                  onPressed: () {
                    print("Goes to :");
                    print(startup.linkedInCompanyPage??"https://retailhub.ai/");
                    _navigationService.navigateTo(innovationWebViewRoute,
                        arguments: startup.linkedInCompanyPage??"https://retailhub.ai/");
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
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Text(
                        CustomStrings.readfull,
                        style: MyTextStyle.button,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

