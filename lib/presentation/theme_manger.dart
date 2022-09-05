import 'package:flutter/material.dart';
import 'package:maleapp/presentation/color_manger.dart';
import 'package:maleapp/presentation/font_manger.dart';
import 'package:maleapp/presentation/styles_manger.dart';
import 'package:maleapp/presentation/value_manger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      //colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      //ripple effect (click)

      //card view theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: FontSize.s4,
        shadowColor: ColorManager.grey,
      ),

      //appBar theme
      appBarTheme: AppBarTheme(
          color: ColorManager.primary,
          centerTitle: true,
          elevation: AppSize.s4,
          shadowColor: ColorManager.lightPrimary,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      // button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        buttonColor: ColorManager.primary,
        disabledColor: ColorManager.grey,
        splashColor: ColorManager.lightPrimary,
      ),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s17),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
        backgroundColor: ColorManager.primary,
      )),

      //text theme
      textTheme: TextTheme(
        headline1: getSemiBoldStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s16,
        ),
        //see the best course
        headline2: getRegularStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s14,
        ),
        //tut app //username formfiled

        subtitle1:
            getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s12),
        //services
        subtitle2: getSemiBoldStyle(
            color: ColorManager.primary, fontSize: FontSize.s18),
        //Details

        bodySmall: getRegularStyle(
          color: ColorManager.grey1,
          fontSize: FontSize.s12,
        ),
        //first service
        bodyText1: getMediumStyle(
          color: ColorManager.grey1,
          fontSize: FontSize.s14,
        ),
        //details loram

        titleMedium: getRegularStyle(
            color: ColorManager.grey, fontSize: FontSize.s14), //change lang
      ),

      //text form filed theme
      inputDecorationTheme: InputDecorationTheme(
        //content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        //hint style
        hintStyle: getApplicationTheme().textTheme.headline2,
        //label style
        labelStyle: getApplicationTheme()
            .textTheme
            .headline2!
            .copyWith(fontWeight: FontWeight.w500),
        //error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        //enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8)),

        //focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.grey, width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8)),

        //error border
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8)),

        //
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8))
      ));
}
