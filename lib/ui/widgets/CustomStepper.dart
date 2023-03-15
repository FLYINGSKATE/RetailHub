import 'package:flutter/material.dart';
import 'package:retailhub/ui/views/Authentication/login_viewmodel.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';

class CustomStepper extends StatelessWidget {
  CustomStepper({
    Key? key,
  }) : super(key: key);

  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final viewModel = LoginViewModel();
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        left: 0,
        right: 0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 2.0,
            width: MediaQuery.of(context).size.width/1.5,
            color: primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(viewModel.steps.length, (index) {
              return Padding(
                padding:
                    index == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 1),
                child: CircleAvatar(
                  backgroundColor:
                      viewModel.steps[index] ? primaryColor : lightgrey,
                  radius: 15,
                  child: Text(
                    viewModel.text.toList()[index],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
