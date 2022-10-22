import 'dart:async';

import 'package:maleapp/app/app_preferances.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/domain/usecase/login_usecase.dart';
import 'package:maleapp/presentation/base/view_model/base_view_model.dart';
import 'package:maleapp/presentation/common/freezed_data_classes.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';


class LoginViewModel extends BaseViewModel with LoginViewModelInput,LoginViewModelOutput
{
  final StreamController _userNameStreamController=StreamController<String>.broadcast();
  final StreamController _passwordStreamController=StreamController<String>.broadcast();
  final StreamController _loginButtonStreamController=StreamController<void>.broadcast();
  final StreamController isLoginSuccessfullyStreamController=StreamController<bool>();
  final AppPreferences _appPreferences=instance<AppPreferences>();


  final LoginUseCase loginUseCase;
  LoginViewModel({required this.loginUseCase});
  var loginData=LoginObject('', '');

  //base
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _loginButtonStreamController.close();
    isLoginSuccessfullyStreamController.close();
  }


  //input
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;





  @override
  login()async {

    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    var responseOrFailure=await loginUseCase.execute(LoginInputModel(password: loginData.password, userName: loginData.userName));
    responseOrFailure.fold((failure) {
      inputState.add(ErrorState(stateRendererType: StateRendererType.POPUP_ERROR_STATE,message: failure.message));
      print(failure.message);
    }, (model) {
      _appPreferences.setIsUserLogin();
      isLoginSuccessfullyStreamController.add(true);
      print(model.customerModel?.name);
    });
   }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginData=loginData.copyWith(password: password);
    inputButtonEnable.add(null);
  }
  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginData=loginData.copyWith(userName: userName);
    inputButtonEnable.add(null);
  }

  //output
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  //hidden function
  bool _isUserNameValid(String userName)
  {
    if(userName.isEmpty)
      {
        return false;
      }
    return true;
  }
  bool _isPasswordValid(String password)
  {
    if(password.isEmpty||password.length<6)
    {
      return false;
    }
    return true;
  }

  bool _isButtonEnabled()
  {
    if(_isUserNameValid(loginData.userName)&&_isPasswordValid(loginData.password))
      {
        return true;
      }
    return false;
  }

  @override
  Sink get inputButtonEnable => _loginButtonStreamController.sink;

  @override
  // TODO: implement outIsButtonEnable
  Stream<bool> get outIsButtonEnable => _loginButtonStreamController.stream.map((event) => _isButtonEnabled());
}

abstract class LoginViewModelInput
{
  setUserName(String userName);
  setPassword(String password);

  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputButtonEnable;
}
abstract class LoginViewModelOutput
{
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outIsButtonEnable;

}