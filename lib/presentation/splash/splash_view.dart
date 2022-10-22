import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/presentation/resources/color_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_preferances.dart';
import '../resources/assets_manger.dart';
import '../resources/constant_manger.dart';
import '../resources/routes_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final AppPreferences _appPreferences=instance<AppPreferences>();
  Timer? _timer;
  void _startDelay()
  {
    _timer=Timer(const Duration(seconds: AppConstant.splashDelay), () {
      _goNext();
    });
  }
  void _goNext()
  {
    _selectFirstPage();
  }

  void _selectFirstPage()async
  {
    if(await _appPreferences.isUserLogin())
      {
        Navigator.pushNamed(context, Routes.mainRoute);
      }
    else{
      if(await _appPreferences.isOnboardingScreenViewed())
        {
          Navigator.pushNamed(context, Routes.loginRoute);
        }
      else
        {Navigator.pushNamed(context, Routes.onBoarding);

        }
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image(image: AssetImage(ImageAssets.splashLogo),),),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
