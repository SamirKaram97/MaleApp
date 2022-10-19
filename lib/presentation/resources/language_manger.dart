import 'package:flutter/material.dart';

enum LanguageType
{
  ENGLISH,
  ARABIC
}




  const String ENGLISH='en';
  const String ARABIC='ar';
  const String ASSET_PATH_LOCALISATION='assets/translations';

  const Locale ENGLISH_Locale=Locale('en','US');
  const Locale ARABIC_Locale=Locale('ar','SA');


extension LangEx on LanguageType
{
  String getLanguage()
  {
    switch(this){
      case LanguageType.ENGLISH:
        return ENGLISH;

      case LanguageType.ARABIC:
        return ARABIC;

    }
}
  String changeLanguage()
  {
    switch(this){
      case LanguageType.ENGLISH:
        return ARABIC;

      case LanguageType.ARABIC:
        return ENGLISH;

    }
  }

}
