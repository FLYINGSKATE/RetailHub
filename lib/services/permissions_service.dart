import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/custom_strings.dart';

class PermissionsService {
  late Map<Permission, PermissionStatus> statuses;

  Future<void> getPermission(context) async {
    var locationcamera = await Permission.camera.status;
    if (locationcamera.isGranted) {
    } else if (locationcamera.isPermanentlyDenied) {
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: const Text('Use Your Permission'),
                content: const Text(
                    '$appName app need camera permissionto enable video features.'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('TurnOn'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      statuses = await [
                        Permission.camera,
                      ].request();
                    },
                  ),
                  // CupertinoDialogAction(
                  //   child: Text('No thanks'),
                  //   onPressed: () => Navigator.pop(context, true),
                  // ),
                ],
              ));
      // }
    }
  }
}
