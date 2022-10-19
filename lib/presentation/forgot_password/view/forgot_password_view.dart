import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:maleapp/presentation/forgot_password/view_model/forgot_password_view_model.dart';

import '../../resources/assets_manger.dart';
import '../../resources/strings_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../resources/value_manger.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final ForgotPasswordViewModel _forgotPasswordViewModel =
      instance<ForgotPasswordViewModel>();

  @override
  void initState() {
    _blind();
    super.initState();
  }

  void _blind() {
    _emailController.addListener(() {
      _forgotPasswordViewModel.setEmail(_emailController.text);
    });
  }

  @override
  void dispose() {
    _forgotPasswordViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _forgotPasswordViewModel.outputState,
        builder: (context, snapshot) {
          print(snapshot.data);
          return snapshot.data?.getScreenWidget(context,_content(),(){})??_content();
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
              const SizedBox(
                height: AppSize.s46,
              ),
              StreamBuilder<bool>(
                  stream: _forgotPasswordViewModel.outputEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: AppStrings.email.tr(),
                          labelText: AppStrings.email.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.userNameValidErrorMessage.tr()),
                    );
                  }),
              const SizedBox(
                height: AppSize.s20,
              ),
              SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<bool>(
                      stream: _forgotPasswordViewModel.outputEmailValid,
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        return ElevatedButton(
                          onPressed: (snapshot.data ?? false) ? () {
                            _forgotPasswordViewModel.send();
                          } : null,
                          child:  Text(AppStrings.send.tr()),
                        );
                      })),
              const SizedBox(
                height: AppSize.s20,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(AppStrings.resend.tr(),
                      style: Theme.of(context).textTheme.labelSmall)),
            ],
          ),
        ),
      );
}
