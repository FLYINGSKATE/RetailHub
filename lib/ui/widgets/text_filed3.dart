import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../utill/app_text_style.dart';

class CustomTextField3 extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType type;
  final bool secureText;
  final String label;
  final bool expanded;
  final bool showPrefix;
  final bool obscureText;
  final bool showSuffix;
  final bool multiLine;
  final String? hintText;
  final bool isHintText;
  final Widget? suffixIcon;
  final VoidCallback? ontap;
  final FocusNode? focusNode;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;
  final bool readOnly;
  const CustomTextField3({
    Key? key,
    this.showPrefix = false,
    this.obscureText = false,
    this.validator,
    this.expanded = true,
    this.prefixIcon,
    this.isHintText = false,
    this.readOnly = false,
    this.hintText,
    this.onSaved,
    this.onChanged,
    required this.label,
    required this.textEditingController,
    this.type = TextInputType.text,
    this.secureText = false,
    this.multiLine = false,
    this.showSuffix = false,
    this.suffixIcon,
    this.ontap,
    this.focusNode,
    this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: TextFormField(
              key: formKey,
              validator: validator,
              onTap: ontap,
              readOnly: readOnly,
              focusNode: focusNode,
              obscureText: obscureText,
              // cursorHeight: 2.h,
              cursorColor: primaryColor,
              style: MyTextStyle.formtext1,
              decoration: InputDecoration(
                fillColor:whitetext,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: MyTextStyle.formhinttext1,
                labelStyle: MyTextStyle.labelStyle1,
              ),
              controller: textEditingController,
              keyboardType: type,
            ),
          ),
        ),
      ],
    );
  }
}
