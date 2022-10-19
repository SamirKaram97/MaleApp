import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:maleapp/domain/usecase/register_usecase.dart';
import 'package:maleapp/presentation/base/view_model/base_view_model.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';

import '../../common/freezed_data_classes.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _userNameValidStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberValidStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailValidStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordValidStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePicValidStreamController =
      StreamController<File>.broadcast();
  final StreamController _buttonValidStreamController =
      StreamController<void>.broadcast();
  final StreamController _userRegisterStreamController =
      StreamController<void>.broadcast();

  final ImagePicker _picker = ImagePicker();

  final RegisterUseCase registerUseCase;

  RegisterObject registerObject = RegisterObject('', '', '', '');

  RegisterViewModel({required this.registerUseCase});

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameValidStreamController.close();
    _mobileNumberValidStreamController.close();
    _emailValidStreamController.close();
    _passwordValidStreamController.close();
    _buttonValidStreamController.close();
    _userRegisterStreamController.close();
    super.dispose();
  }

  setEmail(String email) {
    registerObject = registerObject.copyWith(email: email);
    inputEmail.add(email);
    inputButtonValid.add(null);
  }

  setPassword(String password) {
    registerObject = registerObject.copyWith(password: password);
    inputPassword.add(password);
    inputButtonValid.add(null);
  }

  setUserName(String userName) {
    registerObject = registerObject.copyWith(userName: userName);
    inputUserName.add(userName);
    inputButtonValid.add(null);
  }

  setMobileNumber(String mobileNumber) {
    registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    inputMobileNumber.add(mobileNumber);
    inputButtonValid.add(null);
  }

  register() async {
    // inputState.add(
    //     LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    RegisterInputModel registerInputModel = RegisterInputModel(
        password: registerObject.password,
        userName: registerObject.userName,
        mobileNumber: registerObject.mobileNumber,
        email: registerObject.email);
    var responseOrFailure = await registerUseCase.execute(registerInputModel);
    responseOrFailure.fold((failure) {
      // inputState.add(ErrorState(
      //     stateRendererType: StateRendererType.POPUP_ERROR_STATE,
      //     message: failure.message));//todo refactor that
      inputUserRegisterSuccess.add(null);
      inputState.add(ContentState());
    }, (model) {
      inputState.add(SuccessState(
          stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
          message: 'registered successfully'));
      inputUserRegisterSuccess.add(null);
    });
  }

  setImage()async
  {
   var image=await  _picker.pickImage(source: ImageSource.gallery);
   if(image!=null)
     {
       print(image.path);
       inputProfilePic.add(File(image.path));
     }
  }


  //inputs methods
  @override
  Sink get inputEmail => _emailValidStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordValidStreamController.sink;

  @override
  Sink get inputUserName => _userNameValidStreamController.sink;

  @override
  Sink get inputProfilePic => _profilePicValidStreamController.sink;

  @override
  Sink get inputButtonValid => _buttonValidStreamController.sink;



  //outputs methods
  @override
  Stream<bool> get outputEmailValid =>
      _emailValidStreamController.stream.map((email) => _isValid([email]));

  @override
  Stream<bool> get outputMobileNumberValid =>
      _mobileNumberValidStreamController.stream
          .map((mobile) => _isValid([mobile]));

  @override
  Stream<bool> get outputPasswordValid => _passwordValidStreamController.stream
      .map((password) => _isValid([password]));

  @override
  Stream<bool> get outputUserNameValid => _userNameValidStreamController.stream
      .map((userName) => _isValid([userName]));

  @override
  Stream<File> get outputProfilePicValid =>
      _profilePicValidStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputButtonValid {
    return _buttonValidStreamController.stream.map((event) => isAllInputsValid());
  }

  bool _isValid(List<String> items) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].length == 0) {
        return false;
      }
    }
    return true;
  }
  bool isAllInputsValid()
  {
    return _isValid([
      registerObject.email,
      registerObject.password,
      registerObject.userName,
      registerObject.mobileNumber
    ]);
  }

  @override
  Stream<String?> get outputUserNameError => outputUserNameValid.map((isValid) {
    if(isValid)
      {return null;}
    else
      {return 'error from update';}
  });

  @override
  Sink get inputUserRegisterSuccess => _userRegisterStreamController.sink;

  @override
  Stream<bool> get outIsUserRegisterSuccess => _userRegisterStreamController.stream.map((_) => true);
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputEmail;

  Sink get inputMobileNumber;

  Sink get inputProfilePic;

  Sink get inputButtonValid;

  Sink get inputUserRegisterSuccess;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputUserNameValid;

  Stream<String?> get outputUserNameError;

  Stream<bool> get outputEmailValid;

  Stream<bool> get outputPasswordValid;

  Stream<bool> get outputMobileNumberValid;

  Stream<File> get outputProfilePicValid;

  Stream<bool> get outputButtonValid;

  Stream<bool> get outIsUserRegisterSuccess;
}
