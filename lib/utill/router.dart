import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:retailhub/ui/views/Authentication/booking_view.dart';
import 'package:retailhub/ui/views/CoWorking/coworking_view.dart';
import 'package:retailhub/ui/views/Events/events_view.dart';
import 'package:retailhub/ui/views/Innovation/innovation_view.dart';
import 'package:retailhub/ui/views/Innovation/innovation_viewweb.dart';
import 'package:retailhub/ui/views/Profile/profile_view.dart';
import 'package:retailhub/ui/views/Training/training_view.dart';
import 'package:retailhub/ui/widgets/article_details.dart';

import '../constants/route_names.dart';
import '../model/article_model.dart';
import '../ui/views/Authentication/login_view.dart';
import '../ui/views/Authentication/signup_view.dart';
import '../ui/views/Dashboard/dashboard_view.dart';
import '../ui/views/StartUp/startup_view.dart';
import '../ui/widgets/startups_details.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case startupViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const StartUpView(),
      );

    case bookingViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: BookingView(),
      );
    case loginViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: LoginView(),
      );

    case signupViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SignUpView(),
      );
    case dashboardViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DashboardView(
          initialTab: 0,
        ),
      );

    case profileViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ProfileView(),
      );
    case blogsviewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DashboardView(
          initialTab: 2,
        ),
      );
    case eventsViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const EventsView(),
      );
    case innovationViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const InnovationView(),
      );
    case innovationWebViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow:  InnovationWebView(url:settings.arguments),
      );
    case coworkingViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const CoworkingView(),
      );
    case trainingViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const TrainingView(),
      );
    case blogdetailsViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow:  ArticleDetailsPage(article: settings.arguments),
      );
    case startupsdetailsViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow:  StartUpsDetailsPage(startup: settings.arguments),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return PageTransition(
    type: PageTransitionType.rightToLeft,
    child: SafeArea(
      child: viewToShow!,
    ),
  );
}
