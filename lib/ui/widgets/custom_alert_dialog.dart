import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/route_names.dart';
import '../../utill/app_text_style.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required Function() onTap,
  }) : super(key: key);

  final String title, description;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(widget.title, style: MyTextStyle.scoutCard),
          const SizedBox(height: 15),
          Text(
              textAlign: TextAlign.center,
              widget.description,
              style: MyTextStyle.scoutyear),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 1,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                    child: Center(
                      child: Text("Cancel", style: MyTextStyle.scoutyear),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    widget.onTap;
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                    child: Center(
                      child: Text("Sign Out", style: MyTextStyle.scoutyear),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
