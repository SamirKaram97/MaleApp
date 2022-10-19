import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/app/di.dart' ;
import 'package:maleapp/app/my_app.dart';
import 'package:maleapp/presentation/resources/language_manger.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  await initForgotPasswordModule();
  await initRegisterModule();
  await initHomeModule();

  runApp(
    EasyLocalization(supportedLocales: const [ENGLISH_Locale,ARABIC_Locale], path: ASSET_PATH_LOCALISATION, child: Phoenix(child: MyApp()))
  );
}
