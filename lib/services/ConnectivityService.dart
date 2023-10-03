import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<bool> hasNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      default:
        return false;
    }
  }
}
