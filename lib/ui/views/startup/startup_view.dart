import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../startup/startup_viewmodel.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext? context, StartUpViewModel? model, Widget? child) {
        return Scaffold(body: _getBody(model!, context!));
      },
      viewModelBuilder: () => StartUpViewModel(),
      onViewModelReady: (StartUpViewModel model) {
        model.isTokenValid();
      },
    );
  }

  Widget _getBody(StartUpViewModel model, BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 1.3,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
