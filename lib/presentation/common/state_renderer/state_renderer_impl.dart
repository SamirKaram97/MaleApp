import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/app/constants.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:maleapp/presentation/resources/color_manger.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';

abstract class FlowState
{
  String getMessage();
  StateRendererType getStateRendererType();
}


class LoadingState extends FlowState
{
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, this.message=Constants.empty});

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }


  @override
  String getMessage() {
    return message;
  }

}


class ErrorState extends FlowState
{
  StateRendererType stateRendererType;
  String message;
  ErrorState({required this.stateRendererType, this.message='error'});

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }

}

class EmptyState extends FlowState
{
  StateRendererType stateRendererType;
  String message;
  EmptyState({required this.stateRendererType, this.message=Constants.empty});

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }


}

class ContentState extends FlowState
{
  String message;
  ContentState({this.message=Constants.empty,});


  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.CONTENT_STATE;
  }

}

class SuccessState extends FlowState
{
  StateRendererType stateRendererType;
  String message;
  SuccessState({required this.stateRendererType, this.message=''});

  @override
  String getMessage() {
    return message;
  }


  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }

}


extension FlowStateExtension on FlowState
{
  Widget getScreenWidget(context, Widget contentWidget, Function retryActionFunction)
  {
    switch(runtimeType)
    {
      case LoadingState:{
        if(getStateRendererType() == StateRendererType.POPUP_LOADING_STATE)
          {
            showDialogFunction(context, getStateRendererType(),AppStrings.loading.tr());
            return contentWidget;
          }
        else
          {
            return StateRenderer(stateRendererType: getStateRendererType(), retryFunction: retryActionFunction,message: getMessage(),);
          }
      }

      case ErrorState:{
        if(getStateRendererType() == StateRendererType.POPUP_ERROR_STATE)
        {
          dismissOpenedPopup(context);
          showDialogFunction(context,getStateRendererType(),AppStrings.error.tr(),message: getMessage());
          return contentWidget;
        }
        else
        {
          return StateRenderer(stateRendererType: getStateRendererType(), retryFunction: retryActionFunction,message: getMessage(),);
        }

      }

      case EmptyState:{
        return StateRenderer(stateRendererType: getStateRendererType(), retryFunction: retryActionFunction);
      }

      case ContentState:{
        dismissOpenedPopup(context);
        return contentWidget;
      }

      case SuccessState:{
        dismissOpenedPopup(context);
        showDialogFunction(context,getStateRendererType(),AppStrings.success.tr(),message: getMessage());
        return contentWidget;
      }

      default:  {
        dismissOpenedPopup(context);
        return  contentWidget;}

    }

  }
}

// Widget _getPopUpScreen(StateRendererType stateRendererType,Function retryActionFunction)
// {
//   if(stateRendererType == StateRendererType.POPUP_LOADING_STATE)
//     {
//       return Stack(
//         children: [
//
//           StateRenderer(stateRendererType: StateRendererType.CONTENT_STATE, retryFunction: retryActionFunction,),
//           StateRenderer(stateRendererType: StateRendererType.POPUP_LOADING_STATE, retryFunction: retryActionFunction,),
//         ],
//       );
//     }
//   else if(stateRendererType == StateRendererType.POPUP_ERROR_STATE)
//     {
//       return Stack(
//         children: [
//
//           StateRenderer(stateRendererType: StateRendererType.CONTENT_STATE, retryFunction: retryActionFunction,),
//           StateRenderer(stateRendererType: StateRendererType.POPUP_ERROR_STATE, retryFunction: retryActionFunction,),
//         ],
//       );
//     }
//   else
//     {
//       return Stack(
//         children: [
//
//           StateRenderer(stateRendererType: StateRendererType.CONTENT_STATE, retryFunction: retryActionFunction,),
//           Container(color: ColorManager.black,)
//         ],
//       );
//     }
//
// }
//
// Widget _getFullScreen(StateRendererType stateRendererType,Function retryActionFunction)
// {
//   if(stateRendererType == StateRendererType.FULL_SCREEN_EMPTY_STATE)
//   {
//      return StateRenderer(stateRendererType:StateRendererType.FULL_SCREEN_EMPTY_STATE, retryFunction: retryActionFunction,);
//   }
//   else if(stateRendererType == StateRendererType.FULL_SCREEN_LOADING_STATE)
//   {
//     return StateRenderer(stateRendererType:StateRendererType.FULL_SCREEN_LOADING_STATE, retryFunction: retryActionFunction,);
//   }
//   else if(stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE)
//     {
//       return StateRenderer(stateRendererType:StateRendererType.FULL_SCREEN_ERROR_STATE, retryFunction: retryActionFunction,);
//     }
//   else
//     {
//       return Container(color: ColorManager.black,);
//     }
// }

void showDialogFunction(context,StateRendererType stateRendererType,String title,{String message=''})
{

  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(context: context, builder: (context)=>StateRenderer(message: message,stateRendererType: stateRendererType, retryFunction: (){},title: title,));
  });

}

 isPopupOpened(context)
{
   return ModalRoute.of(context)?.isCurrent!=true;
}

void dismissOpenedPopup(context)
{
  if(isPopupOpened(context))
    {
      Navigator.of(context,rootNavigator: true).pop(true);
    }
}

