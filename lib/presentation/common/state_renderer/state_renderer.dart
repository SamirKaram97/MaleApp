import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maleapp/presentation/resources/assets_manger.dart';
import 'package:maleapp/presentation/resources/color_manger.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';
import 'package:maleapp/presentation/resources/styles_manger.dart';
import 'package:maleapp/presentation/resources/value_manger.dart';

enum StateRendererType
{
  //popup
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS_STATE,


  //fullscreen
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  FULL_SCREEN_EMPTY_STATE,


  //genral
  CONTENT_STATE
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryFunction;

  StateRenderer({Key? key,required this.stateRendererType,this.message="loading",this.title='',required this.retryFunction}) : super(key: key); //todo app strings


  @override
  Widget build(BuildContext context) {
    print(message);
    return _getStateWidget(context);
  }

  Widget _getStateWidget(context)
  {
    switch(stateRendererType)
    {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopupDialog(context,[_getAnimatedImageItem(JsonAssets.loadingJson),_getTitleItem(title)]);

      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopupDialog(context,[_getAnimatedImageItem(JsonAssets.errorJson),_getTitleItem(title),_getMessageItem(message),_getRetryButtonItem(context,AppStrings.tryAgain.tr())]);


      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getColumnItems([_getAnimatedImageItem(JsonAssets.loadingJson),_getTitleItem(title)]);

      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getColumnItems([_getAnimatedImageItem(JsonAssets.errorJson),_getTitleItem(message),_getRetryButtonItem(context,AppStrings.tryAgain.tr())]);


      case StateRendererType.FULL_SCREEN_EMPTY_STATE:
        return _getColumnItems([_getAnimatedImageItem(JsonAssets.emptyJson),_getTitleItem(title),_getRetryButtonItem(context,AppStrings.tryAgain.tr())]);

      case StateRendererType.CONTENT_STATE:
        return Container(color: Colors.red,);

      case StateRendererType.POPUP_SUCCESS_STATE:
        return _getPopupDialog(context,[_getAnimatedImageItem(JsonAssets.emptyJson),_getTitleItem(title),_getMessageItem(message),_getRetryButtonItem(context,AppStrings.ok.tr())]);;



      default:
        return Container(color: Colors.red,);
    }

  }

  Widget _getPopupDialog(context,List<Widget> widgets)
  {
    return Container(
      color: Colors.black12,
      child: Center(
        child: Dialog(
          elevation: AppSize.s1_5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s14)),
          backgroundColor: Colors.transparent,
          child: _getItemsOfDialog(widgets),
        ),
      ),
    );
  }

  Widget _getItemsOfDialog(List<Widget> widgets)
  {
    return Container(
      color: ColorManager.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  Widget _getColumnItems(List<Widget> widgets) => Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
  );

  Widget _getAnimatedImageItem(String json)=>SizedBox(height: 100,width: 100,child: Lottie.asset(json),);

  Widget _getTitleItem(String text)=> Text(text,style: getRegularStyle(color: ColorManager.black,fontSize: AppSize.s18),);

  Widget _getMessageItem(String text)=> Text(text,style: getRegularStyle(color: ColorManager.black,fontSize: AppSize.s14
  ),);

  Widget _getRetryButtonItem(context,String buttonText) => ElevatedButton(onPressed: (){
    if(stateRendererType == StateRendererType.POPUP_ERROR_STATE||stateRendererType==StateRendererType.POPUP_SUCCESS_STATE)
      {
        Navigator.pop(context);
      }
    else
      {
          retryFunction.call();
      }
  }, child:   Text(buttonText));//todo app Strings





}
