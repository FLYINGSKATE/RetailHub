import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLogo;

   const MyAppBar({required this.title,required this.isLogo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbarcolor,
      title:isLogo?Column(
        children: [
          Image.asset(
            logoasset,
            scale: 10,
          ),
        ],
      ):Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

