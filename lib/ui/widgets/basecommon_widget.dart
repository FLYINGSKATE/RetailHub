import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';

class BaseCommonWidget {
  Widget getProgressBar(isBusy, Color color) {
    if (isBusy) {
      return SpinKitThreeBounce(
        color: color,
        size: 25.0,
      );
    } else {
      return Container();
    }
  }

  Widget showProgressBar() {
    return SpinKitThreeBounce(
      color: Colors.yellow.shade300,
      size: 25.0,
    );
  }

  Widget showProgressBaronDialogBox() {
    return SpinKitThreeBounce(
      color: Colors.yellow.shade300,
      size: 25.0,
    );
  }
   Widget retailhubappBar() {
    return AppBar(
      backgroundColor: appbarcolor,
      title: Column(
        children: [
          Image.asset(
            logoasset,
            scale: 10,
          ),
        ],
      ),
    );
  }
}
