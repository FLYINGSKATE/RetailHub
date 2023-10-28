import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState!.pop();
  }

  popWithValue(string) {
    return _navigationKey.currentState!.pop(string);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndPop(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndReplace(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );

  }
}
