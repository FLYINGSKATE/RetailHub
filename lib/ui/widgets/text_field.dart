import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../utill/app_text_style.dart';

class CustomTextField extends StatefulWidget {
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
  const CustomTextField({
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: containercolor,
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: TextFormField(
              key: widget.formKey,
              validator: widget.validator,
              onTap: widget.ontap,
              readOnly: widget.readOnly,
              focusNode: widget.focusNode,
              obscureText: _isHidden&&widget.obscureText,
              cursorHeight: 2.h,
              cursorColor: primaryColor,
              style: MyTextStyle.formtext,
              decoration: InputDecoration(
                suffix: Visibility(
                  visible: widget.obscureText,
                  child: InkWell(
                      onTap: _togglePasswordView,

                      /// This is Magical Function
                      child: Icon(
                        
                        _isHidden
                            ?

                            /// CHeck Show & Hide.
                            Icons.visibility
                            : Icons.visibility_off,
                            color: Colors.white,
                      )),
                ),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: MyTextStyle.formhinttext,
                labelStyle: MyTextStyle.labelStyle,
              ),
              controller: widget.textEditingController,
              keyboardType: widget.type,
            ),
          ),
        ),
      ],
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
