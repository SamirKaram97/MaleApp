


import 'package:flutter/material.dart';
import 'package:maleapp/presentation/resources/font_manger.dart';

TextStyle _getTextStyle({required Color color,String fontFamily=FontConstants.fontsFamily,required FontWeight fontWeight,double fontSize=FontSize.s12})
{
  return TextStyle(color: color,fontFamily: fontFamily,fontSize: fontSize,fontWeight: fontWeight);
}

//bold
TextStyle getBoldStyle({required Color color,double fontSize=FontSize.s12})
{
  return _getTextStyle(color: color, fontWeight: FontWeightManger.bold,fontSize: fontSize);
}


//semiBold
TextStyle getSemiBoldStyle({required Color color,double fontSize=FontSize.s12})
{
  return _getTextStyle(color: color, fontWeight: FontWeightManger.semiBold,fontSize: fontSize);
}

//medium
TextStyle getMediumStyle({required Color color,double fontSize=FontSize.s12})
{
  return _getTextStyle(color: color, fontWeight: FontWeightManger.medium,fontSize: fontSize);
}

//regular
TextStyle getRegularStyle({required Color color,double fontSize=FontSize.s12})
{
  return _getTextStyle(color: color, fontWeight: FontWeightManger.regular,fontSize: fontSize);
}

//light
TextStyle getLightStyle({required Color color,double fontSize=FontSize.s12})
{
  return _getTextStyle(color: color, fontWeight: FontWeightManger.light,fontSize: fontSize);
}


