import 'package:flutter/material.dart';
import 'package:retailhub/constants/app_assets.dart';

import '../../constants/app_colors.dart';
import 'CustomStepper.dart';


class FormHeader extends StatelessWidget {
  final bool showLeftVector;
  final String title;
  final bool isWhiteColor;
  const FormHeader({
    Key? key,
    required this.showLeftVector,
    required this.title,
    this.isWhiteColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: backgroundColor.withOpacity(0.2),
      child: Stack(
        alignment: Alignment.center,
        children: [
          showLeftVector
              ? const Positioned(
                  top: -35,
                  left: -35,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
         
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 1,
          //   ),
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: Text(
          //       title,
          //     ),
          //   ),
          // ),
          isWhiteColor ? const SizedBox.shrink() : Container( margin: const EdgeInsets.only(top: 10),child: CustomStepper()),
        ],
      ),
    );
  }
}
