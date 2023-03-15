import 'package:flutter/material.dart';
import 'package:retailhub/constants/app_colors.dart';

class NoDataWidget extends StatelessWidget {
  final String message;

   const NoDataWidget({Key? key, this.message = 'No data available'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Icon(Icons.warning, color: Colors.grey, size: 64.0),
            // const SizedBox(height: 8.0),
            // Text(message, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
