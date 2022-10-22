import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maleapp/app/app_preferances.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/presentation/register/view_model/register_view_model.dart';

import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
import '../../resources/value_manger.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _profilePictureController = TextEditingController();

  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final AppPreferences _appPreferences=instance<AppPreferences>();


  @override
  void initState() {
    _blind();
    super.initState();
  }

  void _blind() {
    _registerViewModel.start();
    _nameController.addListener(() {
      _registerViewModel.setUserName(_nameController.text);
    });

    _emailController.addListener(() {
      _registerViewModel.setEmail(_emailController.text);
    });

    _mobileNumberController.addListener(() {
      _registerViewModel.setMobileNumber(_mobileNumberController.text);
    });

    _passwordController.addListener(() {
      _registerViewModel.setPassword(_passwordController.text);
    });

    _registerViewModel.outIsUserRegisterSuccess.listen((event) {
      _appPreferences.setIsUserLogin();
     SchedulerBinding.instance.addPostFrameCallback((_) {
       Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
     });
    });
  }
  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _registerViewModel.outputState,
        builder: (context, snapshot) {
          print("reg ${snapshot.data}");
          return snapshot.data?.getScreenWidget(context, _content(), () {}) ??
              _content();
        },
      ),
    );
  }

  Widget _content() => Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: AppPadding.p100),
                child: Image(image: AssetImage(ImageAssets.splashLogo)),
              ),
              StreamBuilder<String?>(
                  stream: _registerViewModel.outputUserNameError,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: AppStrings.name.tr(),
                          errorText: snapshot.data),
                    );
                  }),
              const SizedBox(
                height: AppSize.s12,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          print('Select country: ${country.displayName}');
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: AppSize.s8),
                      child: SizedBox(
                        height: AppSize.s32,
                        width: AppSize.s32,
                        child: SvgPicture.asset(ImageAssets.egyptFlag),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSize.s22,
                  ),
                  Expanded(
                    child: StreamBuilder<bool>(
                        stream: _registerViewModel.outputMobileNumberValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _mobileNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: AppStrings.mobileNumber.tr(),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : AppStrings.mobileNumberValidErrorMessage.tr()),
                          );
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              StreamBuilder<bool>(
                  stream: _registerViewModel.outputEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: AppStrings.email.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.emailValidErrorMessage.tr()),
                    );
                  }),
              const SizedBox(
                height: AppSize.s12,
              ),
              StreamBuilder<bool>(
                  stream: _registerViewModel.outputPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: AppStrings.password.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.passwordValidErrorMessage.tr()),
                    );
                  }),
              const SizedBox(
                height: AppSize.s12,
              ),
              StreamBuilder<File>(stream: _registerViewModel.outputProfilePicValid,builder: (context, snapshot) {
                return TextFormField(
                  controller: _profilePictureController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefix: snapshot.data!=null?Container(width: 50,height:50,child: Image.file(snapshot.data!)):SizedBox(),
                      suffixIcon: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: SvgPicture.asset(ImageAssets.camera),
                        ),
                        onTap: () {
_registerViewModel.setImage();
                        },
                      ),
                      hintText: AppStrings.profilePicture.tr(),
                      ),
                );
              }),
              const SizedBox(
                height: AppSize.s26,
              ),
              SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<bool>(
                      stream: _registerViewModel.outputButtonValid,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                            onPressed: (snapshot.data == true) ? () {
                              _registerViewModel.register();
                            } : null,
                            child: Text(AppStrings.register.tr()));
                      })),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginRoute);
                  },
                  child: Text(AppStrings.alreadyHaveAnAccount.tr(),
                      style: Theme.of(context).textTheme.labelSmall)),
            ],
          ),
        ),
      );
}
