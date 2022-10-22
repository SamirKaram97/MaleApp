import 'package:flutter/material.dart';
import 'package:maleapp/presentation/resources/language_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../data/resposes/home_response.dart';

const String PREFS_KEY_LANG='language';
const String PREFS_KEY_ONBOARDING='onBoarding';
const String PREFS_KEY_ISLOGIN='login';
const String PREFS_KEY_HOMEDATASHARED='PREFS_KEY_HOMEDATASHARED';

class AppPreferences
{
  final SharedPreferences sharedPreferences;
  AppPreferences({required this.sharedPreferences});

  void saveHomeDataToShared(String homeDataResponse)
  {
    sharedPreferences.setString(PREFS_KEY_HOMEDATASHARED, homeDataResponse);
  }

  Future<HomeResponse> getHomeShared()async
  {
    String? response=await sharedPreferences.getString(PREFS_KEY_HOMEDATASHARED);
    if(response!=null)
    return HomeResponse.fromJson(json.decode(response));
    else
      {
        throw Exception();
      }
  }

  String getLanguage()
  {
    String? language=sharedPreferences.getString(PREFS_KEY_LANG);
    if(language!=null)
      {
        return language;
      }
    else
      {
        return LanguageType.ENGLISH.getLanguage();
      }
  }

  Future<Locale> getLocale()async
  {
    if(getLanguage()==LanguageType.ENGLISH.getLanguage())
      {
        return ENGLISH_Locale;
      }
    else
      {
        return ARABIC_Locale;
      }
  }

  //onboarding
  Future<void> setIsOnboardingScreenViewed()async
  {
    sharedPreferences.setBool(PREFS_KEY_ONBOARDING, true);
  }

  Future<bool> isOnboardingScreenViewed()async
  {
    return  sharedPreferences.getBool(PREFS_KEY_ONBOARDING)??false;
  }

  Future<void> setIsUserLogin()async
  {
    sharedPreferences.setBool(PREFS_KEY_ISLOGIN, true);
  }

  Future<void> setIsUserLogout()async
  {
    sharedPreferences.setBool(PREFS_KEY_ISLOGIN, false);
  }

  Future<bool> isUserLogin()async
  {
    return  sharedPreferences.getBool(PREFS_KEY_ISLOGIN)??false;
  }

  Future<void> changeLanguage()async
  {
    String language=getLanguage();
    if(language==LanguageType.ENGLISH.getLanguage())
      {
        language=LanguageType.ARABIC.getLanguage();
      }
    else
      {
        language=LanguageType.ENGLISH.getLanguage();
      }

    // String language=getLanguage();
    // if(language==LanguageType.ENGLISH.getLanguage())
    //   {
    //     language=LanguageType.ENGLISH.changeLanguage();
    //   }
    // else
    //   {
    //     LanguageType.ARABIC.changeLanguage();
    //   }

    sharedPreferences.setString(PREFS_KEY_LANG, language);
  }
}