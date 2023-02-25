
import 'package:flutter/material.dart';
import 'package:furniture/presentation/home_page/view/home_view.dart';
import 'package:furniture/presentation/notification/view/notification_view.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';
import 'package:furniture/presentation/all_chairs/view/all_chairs_view.dart';
import 'package:furniture/presentation/settings/view/settings_view.dart';
import 'package:furniture/presentation/splash/splash_view.dart';

import '../about/view/about_view.dart';
import '../authentication/login/login_view.dart';
import '../authentication/register/register_view.dart';
import '../cart/view/cart_view.dart';
import '../location/view/location_view.dart';
import '../main_view.dart';
import '../profile/view/profile_view.dart';


class Routes {
  static const String mainRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String allChairsRoute = "/allChairs";
  static const String allCartsRoute = "/allCarts";
  static const String notificationRoute = "/notification";
  static const String profileRoute = "/profile";
  static const String aboutRoute = "/about";
  static const String locationRoute = "/location";
  static const String settingsRoute = "/settings";
  static const String splashRoute = "/splash";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.allChairsRoute:
        return MaterialPageRoute(builder: (_) => const AllChairsView());
      case Routes.allCartsRoute:
        return MaterialPageRoute(builder: (_) => const CartView());
      case Routes.locationRoute:
        return MaterialPageRoute(builder: (_) => const LocationView());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound)),
        ));
  }
}