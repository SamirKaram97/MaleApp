import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:maleapp/presentation/main/view/main_view.dart';
import 'package:maleapp/presentation/on_boarding/view/on_boarding.dart';
import 'package:maleapp/presentation/register/view/register_view.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';
import 'package:maleapp/presentation/splash/splash_view.dart';
import 'package:maleapp/presentation/store_details/view/store_details_view.dart';

import '../../app/di.dart';
import '../login/view/login_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoarding = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RoutGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView(),
        );
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(
          builder: (context) => const MainView(),
        );
      case Routes.storeDetailsRoute:
        initStroeDetailsModule();
        return MaterialPageRoute(
          builder: (context) => const StoreDetailsView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound).tr(),//todo add to strings manger
          ),
          body:  Center(child: Text(AppStrings.noRouteFound.tr())),//todo add to strings manger
        );
      },
    );
  }
}
