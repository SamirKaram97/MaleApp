import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maleapp/presentation/main/pages/notifications_page.dart';
import 'package:maleapp/presentation/main/pages/search_page.dart';
import 'package:maleapp/presentation/main/pages/settings_page.dart';
import 'package:maleapp/presentation/resources/font_manger.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';
import 'package:maleapp/presentation/resources/styles_manger.dart';
import 'package:maleapp/presentation/resources/value_manger.dart';
import '../../resources/assets_manger.dart';
import '../../resources/color_manger.dart';
import '../pages/home/view/home_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage()
  ];
  List<String> titles =  [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr()
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _content(context),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() => AppBar(
      title: Text(titles[_currentIndex],
          style: Theme.of(context).textTheme.labelMedium));

  Widget _content(context) => pages[_currentIndex];

  Widget buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.grey4,
            spreadRadius: AppSize.s1
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey4,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: AppStrings.home.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: AppStrings.search.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: AppStrings.notifications.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: AppStrings.settings.tr()),
        ],
      ),
    );
  }
}
