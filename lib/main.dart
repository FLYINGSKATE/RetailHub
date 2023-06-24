import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:retailhub/ui/views/Authentication/login_view.dart';
import 'package:retailhub/ui/views/Authentication/signup_view.dart';
import 'package:retailhub/ui/views/Search/search_view.dart';
import 'package:retailhub/ui/views/Tickets/single_ticket_view.dart';
import 'package:sizer/sizer.dart';

import 'app/app.locator.dart';
import 'constants/route_names.dart';
import 'firebase_options.dart';
import 'services/navigation_service.dart';
import 'utill/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Initialized default app $app');
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
        //home: SingleTicketsView(ticketDetails: {"diana.doe@example.com":"9fMgUUb18ov8OHzZ9X4J"},),
        onGenerateRoute: generateRoute,
      );
    });
  }
}
