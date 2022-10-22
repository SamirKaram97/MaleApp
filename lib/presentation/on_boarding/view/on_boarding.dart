import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maleapp/app/app_preferances.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/presentation/resources/assets_manger.dart';
import 'package:maleapp/presentation/resources/constant_manger.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/models/slider_model.dart';
import '../../resources/color_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/value_manger.dart';
import '../view_model/onboarding_view_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final AppPreferences _appPreferences=instance<AppPreferences>();
  final PageController controller = PageController();
  final OnboardingViewModel _onboardingViewModel=OnboardingViewModel();

  void _bind()
  {
    _onboardingViewModel.start();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  void dispose() {
    _onboardingViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _onboardingViewModel.outputSliderViewModel,
      builder: (context, snapshot) {
        return _content(snapshot.data);
      }
    );
  }

  Widget _content(SliderViewObject? sliderViewObject) {
    if(sliderViewObject ==null) {
      return const SizedBox();
    }
    return Scaffold(
    backgroundColor: ColorManager.white,
    appBar: AppBar(
      backgroundColor: ColorManager.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    body: _body(sliderViewObject),
    bottomSheet: _bottomSheetWidget(sliderViewObject),
  );
  }

  Widget _bottomSheetWidget(SliderViewObject? sliderViewObject) => Container(
    color: ColorManager.white,
    child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: AppPadding.p6),
              child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                      onPressed: () {
                        _appPreferences.setIsOnboardingScreenViewed();
                         Navigator.pushNamed(context, Routes.loginRoute);

                      },
                      child: Text(
                        AppStrings.skip.tr(),
                        style: Theme.of(context).textTheme.displaySmall,
                      ))),
            ),
            const SizedBox(
              height: AppPadding.p8,
            ),
            Container(
              height: AppSize.s44,
              color: ColorManager.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Visibility(
                          visible: sliderViewObject!.currentPage!=0,
                          child: InkWell(
                              onTap: () {
                                controller.animateToPage(_onboardingViewModel.goPreviousPage(), duration: const Duration(milliseconds:AppConstant.onboardingChangeDelayInMilly ), curve: Curves.bounceInOut);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p12),
                                child: SvgPicture.asset(ImageAssets.arrowLeftIc),
                              )),
                        ),
                      ),
                  SizedBox(
                    width: AppSize.s100,
                    child: Center(
                      child: Row(
                        children: [
                          for(int i=0;i<sliderViewObject.numOfSlide;i++)
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.p6),
                              child: SizedBox(height: AppSize.s12,width: AppSize.s12,child: _mapDots(i,sliderViewObject.currentPage)),
                            )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: InkWell(
                        onTap: () {
                          if(sliderViewObject.currentPage!=sliderViewObject.numOfSlide-1)
                          {
                            controller.animateToPage(_onboardingViewModel.goNextPage(), duration: const Duration(milliseconds:AppConstant.onboardingChangeDelayInMilly ), curve: Curves.bounceInOut);
                          }
                          else
                            {
                               // Navigator.pushNamed(context, Routes.loginRoute);
                            }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          child: SvgPicture.asset(ImageAssets.arrowRightIc),
                        )),
                  ),

                ],
              ),
            )
          ],
        ),
  );

  Widget _mapDots(int index,currentPage) {
    if(index==currentPage) {
      return SvgPicture.asset(ImageAssets.transDot);
    }
    return SvgPicture.asset(ImageAssets.whiteDot);
  }

  Widget _body(SliderViewObject? sliderViewObject) {
    return PageView.builder(
    physics: const BouncingScrollPhysics(),
    onPageChanged: (index) {
      _onboardingViewModel.onPageChanged(index);
    },
    itemBuilder: (context, index) =>OnBoardingPage(object: sliderViewObject!.slideObject),
    itemCount: sliderViewObject!.numOfSlide,
    controller: controller,
  );
  }
}


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key, required this.object}) : super(key: key);
  final SlideObject object;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          object.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: AppPadding.p35,
              left: AppPadding.p38,
              right: AppPadding.p38),
          child: Text(object.subtitle,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center),
        ),
        const SizedBox(
          height: AppSize.s38,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p54),
          child: SvgPicture.asset(
            object.image,
            height: AppSize.s267,
            width: AppSize.s267,
          ),
        ),
        const SizedBox(
          height: AppSize.s76,
        ),
      ],
    );
  }

}


