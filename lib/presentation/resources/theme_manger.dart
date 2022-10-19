import 'package:flutter/material.dart';
import 'color_manger.dart';
import 'font_manger.dart';
import 'styles_manger.dart';
import 'value_manger.dart';


ThemeData getApplicationTheme() {
  return ThemeData(
      //colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      //ripple effect (click)

      //scaffold color
      scaffoldBackgroundColor: ColorManager.white,
      //
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


        labelMedium: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16),
        //appBar

        headlineLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s16,
        ),
        //see the best course
        headlineSmall: getRegularStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s14,
        ),

        //tut app //username formfiled

        labelSmall: getRegularStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s12,
        ),
        //forgotPassword

        titleLarge:
            getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s14),
        //services
        titleSmall: getSemiBoldStyle(
            color: ColorManager.primary, fontSize: FontSize.s18),
        //Details

        bodySmall: getRegularStyle(
          color: ColorManager.grey1,
          fontSize: FontSize.s12,
        ),
        //first service
        bodyMedium: getMediumStyle(
          color: ColorManager.lightGrey,
          fontSize: FontSize.s14,
        ),
        //details loram

        displaySmall: getMediumStyle(color: ColorManager.primary,fontSize: FontSize.s16),

        titleMedium: getRegularStyle(
            color: ColorManager.grey, fontSize: FontSize.s14),), //change lang


      //text form filed theme
      inputDecorationTheme:  InputDecorationTheme(
        //content padding
        contentPadding:  EdgeInsets.all(AppPadding.p12),
        //hint style
        hintStyle: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        //label style
        labelStyle: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        //error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        //enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey3.withOpacity(AppOpacity.o_2), width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8)),

        //focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8)),

        //error border
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8)),

        //focused Error Border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),//thick 1.5 (side)
            borderRadius: BorderRadius.circular(AppSize.s8))
      )
       );
}
