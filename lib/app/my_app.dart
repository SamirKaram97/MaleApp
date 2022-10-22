import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/app/app_preferances.dart';
import 'package:maleapp/presentation/login/view/login_view.dart';

import '../presentation/resources/routes_manger.dart';
import '../presentation/resources/theme_manger.dart';
import '../presentation/splash/splash_view.dart';
import 'di.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();
  static final MyApp _instance=MyApp._internal();
  factory MyApp()=>_instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences=instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((locale) => {
      context.setLocale(locale)
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,

      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
      home: SplashView(),
    );
  }
}
