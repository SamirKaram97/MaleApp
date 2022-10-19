import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maleapp/app/app_preferances.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/data/data_source/local_data_source/local_data_source.dart';
import 'package:maleapp/presentation/resources/assets_manger.dart';
import 'package:maleapp/presentation/resources/value_manger.dart';

import '../../resources/language_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final LocalDataSource _localDataSource=instance<LocalDataSource>();
  final AppPreferences _appPreferences=instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p10),
        child: Column(
          children: [
            ListTile(onTap: (){
              _appPreferences.changeLanguage();
              Phoenix.rebirth(context);
            },leading: SvgPicture.asset(ImageAssets.changeLang),title:  Text(AppStrings.changeLanguage.tr()),trailing: Transform(transform: isRtl()?Matrix4.rotationY(180):Matrix4.rotationY(0),
            child: SvgPicture.asset(ImageAssets.arrowSettings)),),
            ListTile(onTap: (){},leading: SvgPicture.asset(ImageAssets.contactUs),title:  Text(AppStrings.contactUs.tr()),trailing: Transform(transform: isRtl()?Matrix4.rotationY(180):Matrix4.rotationY(0),
            child: SvgPicture.asset(ImageAssets.arrowSettings)),),
            ListTile(onTap: (){},leading: SvgPicture.asset(ImageAssets.inviteFriends),title:  Text(AppStrings.inviteYourFriends.tr()),trailing: Transform(transform: isRtl()?Matrix4.rotationY(180):Matrix4.rotationY(0),child: SvgPicture.asset(ImageAssets.arrowSettings)),),
            ListTile(onTap: (){_logOut();},leading: SvgPicture.asset(ImageAssets.logout),title:  Text(AppStrings.logout.tr()),trailing: Transform(transform: isRtl()?Matrix4.rotationY(180):Matrix4.rotationY(0),child: SvgPicture.asset(ImageAssets.arrowSettings)),),
          ],
        ),
      ),
    );
  }

  void _logOut()
  {
    _appPreferences.setIsUserLogout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
  bool  isRtl()
  {
     return context.locale==ARABIC_Locale;
  }
}
