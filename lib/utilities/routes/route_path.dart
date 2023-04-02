import 'package:ambulance_staff/page_layout.dart';
import 'package:ambulance_staff/utilities/routes/routes.dart';
import 'package:ambulance_staff/view/dashboard_page.dart';
import 'package:ambulance_staff/view/splash_page.dart';
import 'package:ambulance_staff/view/terms_and_condition.dart';
import 'package:ambulance_staff/view/user_guide_page.dart';
import 'package:flutter/material.dart';
import '../../view/login_page.dart';
import '../../view/register_page.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    // route setting request cases
    switch (settings.name) {
      // case;
      case RoutesName.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Splash_Screen());

      // case; requesting for login
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Register());

      case RoutesName.dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardPage());

      case RoutesName.pageLayout:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PageLayout());

      case RoutesName.termsAndConditions:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TermAndCondition());

      case RoutesName.userGuide:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UserGuidePage());

      // if non of these above cases are met then return this
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("no route defined")),
          );
        });
    }
  }
}
