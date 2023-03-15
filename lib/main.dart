import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app/app.locator.dart';
import 'constants/route_names.dart';
import 'services/navigation_service.dart';
import 'utill/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Retail Hub',
        theme: ThemeData.light(),
        navigatorKey: locator<NavigationService>().navigationKey,
        initialRoute: startupViewRoute,
        onGenerateRoute: generateRoute,
      );
    });
  }
}
