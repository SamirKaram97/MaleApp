import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:maleapp/domain/usecase/forgot_password_usecase.dart';
import 'package:maleapp/presentation/base/view_model/base_view_model.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';

import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel with ForgotPasswordViewModelInputs,ForgotPasswordViewModelOutputs
{
  final StreamController emailController=StreamController<String>.broadcast();
  final ForgotPasswordUseCase forgotPasswordUseCase;
  ForgotPasswordObject forgotPasswordObject=ForgotPasswordObject('');

  ForgotPasswordViewModel({required this.forgotPasswordUseCase});

  @override
  void start() {
    inputState.add(ContentState());
  }
  @override
  void dispose() {
    super.dispose();
    emailController.close();
  }



  void setEmail(String email)
  {
    inputEmail.add(email);
    forgotPasswordObject=forgotPasswordObject.copyWith(email: email);

  }

  @override
  Sink get inputEmail => emailController.sink;

  @override
  Stream<bool> get outputEmailValid => emailController.stream.map((email) => _isEmailValid(email));


  bool _isEmailValid(String email)
  {
    return (email.length>5&&email.contains('@'));
  }

  send()async
  {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE,message: AppStrings.loading.tr()));
    var modelOrFailure=await forgotPasswordUseCase.execute(ForgotPasswordInputModel(email: forgotPasswordObject.email));
    modelOrFailure.fold((failure) {

     inputState.add(ErrorState(stateRendererType: StateRendererType.POPUP_ERROR_STATE,message: failure.message));
    }, (model) {
      inputState.add(SuccessState(stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,message: model.support));
    });
  }

}

abstract class ForgotPasswordViewModelInputs
{
  Sink get inputEmail;
}

abstract class ForgotPasswordViewModelOutputs
{
  Stream<bool> get outputEmailValid;
}

