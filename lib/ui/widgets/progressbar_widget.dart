import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/app_colors.dart';

class loadingView extends StatelessWidget {
  bool isLoading;
  loadingView(this.isLoading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isLoading ? Colors.black : null,
      margin: const EdgeInsets.only(top: 10),
      height: double.infinity,
      child: isLoading
          ? const Center(
              child: SpinKitThreeBounce(
              color: loadingBarcolor,
              size: 25.0,
            ))
          : Container(),
    );
  }
}
