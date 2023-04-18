import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class ArticleDetailsPage extends StatelessWidget {
  final article;
  ArticleDetailsPage({
    Key? key,
    required this.article,
  }) : super(key: key);
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(article.title),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: article.imageName,
                placeholder: (context, url) => const Center(child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit
                    .cover, // adjusts the size of the image to cover the entire box

                height: 200, // specify the height of the box
              ),
              2.h.heightBox,
              Text(article.title, style: MyTextStyle.apptitle),
              2.h.heightBox,
              Text(article.description, style: MyTextStyle.bodyText),
              2.h.heightBox,
              ElevatedButton(
                onPressed: () {
                  _navigationService.navigateTo(innovationWebViewRoute,
                      arguments: article.articlesLink);
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
    );
  }
}

class Article {
  final String title;
  final String desc;
  final String imgur;
  final String id;
  final String articleurl;

  Article({
    required this.title,
    required this.desc,
    required this.imgur,
    required this.id,
    required this.articleurl,
  });
}
