import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/presentation/base/view_model/base_view_model.dart';

import '../../../domain/models/slider_model.dart';
import '../../resources/assets_manger.dart';
import '../../resources/strings_manger.dart';

class OnboardingViewModel extends BaseViewModel with OnboardingViewModelInputs,OnboardingViewModelOutputs
{
  final StreamController _streamController=StreamController<SliderViewObject>();
  late final List<SlideObject> _list;
  late int _currentPage;

  @override
  void start() {
    _list = _getObjects();
    _currentPage = 0;
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  List<SlideObject> _getObjects() => [
    SlideObject(
        title: AppStrings.onboardingTitle1.tr(),
        subtitle: AppStrings.onboardingSubTitle1.tr(),
        image: ImageAssets.onboardingLogo1),
    SlideObject(
        title: AppStrings.onboardingTitle2.tr(),
        subtitle: AppStrings.onboardingSubTitle2.tr(),
        image: ImageAssets.onboardingLogo2),
    SlideObject(
        title: AppStrings.onboardingTitle3.tr(),
        subtitle: AppStrings.onboardingSubTitle3.tr(),
        image: ImageAssets.onboardingLogo3),
    SlideObject(
        title: AppStrings.onboardingTitle4.tr(),
        subtitle: AppStrings.onboardingSubTitle4.tr(),
        image: ImageAssets.onboardingLogo4),
  ];

  @override
  int goNextPage() {
    _currentPage++;
    return _currentPage;
  }

  @override
  int goPreviousPage() {
    _currentPage--;
    return _currentPage;
  }

  @override
  void onPageChanged(int index) {
    _currentPage=index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewModel =>_streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewModel => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _postDataToView()
  {
    inputSliderViewModel.add(SliderViewObject(currentPage: _currentPage,numOfSlide: _list.length,slideObject: _list[_currentPage]));
  }


}

abstract class OnboardingViewModelInputs
{
  int goNextPage();
  int goPreviousPage();
  void onPageChanged(int index);
  Sink get inputSliderViewModel;
}

abstract class OnboardingViewModelOutputs
{
  Stream<SliderViewObject> get outputSliderViewModel;
}

