import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:maleapp/presentation/login/view_model/login_view_model.dart';
import 'package:maleapp/presentation/resources/color_manger.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';
import 'package:maleapp/presentation/resources/value_manger.dart';
import 'package:maleapp/presentation/resources/routes_manger.dart';

import '../../resources/assets_manger.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel loginViewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: loginViewModel.outputState,
        builder: (context, snapshot) {
          print(snapshot.data);
          if(snapshot.data!=null)
            {
              return snapshot.data!.getScreenWidget(context,_content(),(){});
            }
          else
            {
              return _content();
            }
        },
      ),
    );
  }

  @override
  void dispose() {
    loginViewModel.dispose();
    super.dispose();
  }

  void bind() {
    loginViewModel.start();
    _userNameController.addListener(() {
      loginViewModel.setUserName(_userNameController.text);

    });
    _passwordController.addListener(() {
      loginViewModel.setPassword(_passwordController.text);
    });

    loginViewModel.isLoginSuccessfullyStreamController.stream.listen((isLoginSuccessfullyStreamController) {
      if(isLoginSuccessfullyStreamController)
        {
         Navigator.of(context).pushReplacementNamed(Routes.mainRoute) ;
        }
    });
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  Widget _content() =>  Padding(
    padding: const EdgeInsets.all(AppPadding.p20),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: AppPadding.p100),
            child: Image(image: AssetImage(ImageAssets.splashLogo)),
          ),
          const SizedBox(
            height: AppSize.s46,
          ),
          StreamBuilder<bool>(
              stream: loginViewModel.outIsUserNameValid,
              builder: (context, snapshot) {

                return TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: AppStrings.userName.tr(),
                      labelText: AppStrings.userName.tr(),
                      errorText: (snapshot.data??true)?null:AppStrings.userNameValidErrorMessage.tr()),
                );
              }),
          const SizedBox(
            height: AppSize.s20,
          ),
          StreamBuilder<bool>(
              stream: loginViewModel.outIsPasswordValid,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration:  InputDecoration(
                      hintText: AppStrings.password.tr(),
                      labelText: AppStrings.password.tr(),
                      errorText: (snapshot.data??true)?null:AppStrings.passwordValidErrorMessage.tr()),
                );
              }
          ),
          const SizedBox(
            height: AppSize.s46,
          ),
          SizedBox(
              width: double.infinity,
              child: StreamBuilder<bool>(
                  stream: loginViewModel.outIsButtonEnable,
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    return ElevatedButton(
                      onPressed: (snapshot.data??false)?(){
                        loginViewModel.login();
                      }:null,
                      child:  Text(AppStrings.login.tr()),
                    );
                  }
              )),
          const SizedBox(
            height: AppSize.s20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                  },
                  child: Text(
                    AppStrings.forgetPassword.tr(),
                    style: Theme.of(context).textTheme.labelSmall,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.registerRoute);
                  },
                  child: Text(AppStrings.notAMember.tr(),
                      style: Theme.of(context).textTheme.labelSmall)),
            ],
          )
        ],
      ),
    ),
  );
}
