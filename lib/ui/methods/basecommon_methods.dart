
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BaseCommonMethods {
  


  static Future<bool> appToast({msg, time}) async {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
    await Future.delayed(Duration(milliseconds: time ?? 2000), () {
      Fluttertoast.cancel();
    });
    return true;
  }

  static Future<bool> showSnackbar({context, msg}) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
    return true;
  }

  static Future closeApp() async {
  
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
