import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/API.dart';
import '../../constants/app_colors.dart';

class NewsItem extends StatelessWidget {
  final String? id, newstitle, imageUrl, newsDesc, url;
  final Function myCallback;

  const NewsItem(
      this.id, this.newstitle, this.imageUrl, this.newsDesc, this.url,
      {Key? key, required this.myCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (() {
            myCallback();
          }),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: const Color(0xFFEAF0F1),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      placeholder: (context, url) => Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(40),
                        child: const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            newstitle!,
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            newsDesc!,
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                                color: grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // article title end
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
