import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatelessWidget {
  String title;
  String imgurl;
  bool isProfile;

  HeaderWidget({Key? key, required this.title, required this.imgurl,required this.isProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: darkblue,
        height: 102,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: isProfile,
                child: imgurl == "null"||imgurl==""
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(23))),
                        height: 40,
                        width: 40,
                        child: Center(
                            child: Text(
                          title[0],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )))
                    : CircleAvatar(
                        radius: 23.0,
                        backgroundImage: NetworkImage(imgurl),
                        backgroundColor: Colors.transparent,
                      ),
              ),
              Visibility(
                visible: isProfile,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  child: Center(
                      child: Text(
                    "Hi, $title",
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              ),
              Visibility(
                visible: !isProfile,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  child: Center(
                      child: Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
