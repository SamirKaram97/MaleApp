import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../resources/value_manger.dart';
import '../view_model/store_details_view_model.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _storeDetailsViewModel =
      instance<StoreDetailsViewModel>();

  @override
  void initState() {
    _blind();
    super.initState();
  }
  void _blind() {
    _storeDetailsViewModel.start();
  }

  @override
  void dispose() {
    _storeDetailsViewModel.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<FlowState>(
        stream: _storeDetailsViewModel.outputState,
        builder: (context, snapshot) {
          if(snapshot!=null&& snapshot.data!=null)
           { return snapshot.data!.getScreenWidget(context, _content(), (){_storeDetailsViewModel.start();});}
          return LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE).getScreenWidget(context, _content(), (){_storeDetailsViewModel.start();});
        }
      ),
    );
  }

  Widget _content() => SingleChildScrollView(
    child: StreamBuilder<StoreDetailsViewObject>(
        stream: _storeDetailsViewModel.outputStoreDetailsViewObject,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _getImageWidget(snapshot.data?.image),
              _getTitleWidget(AppStrings.details.tr()),
              _getText(snapshot.data?.details),
              _getTitleWidget(AppStrings.services.tr()),
              _getText(snapshot.data?.services),
              _getTitleWidget(AppStrings.aboutStore.tr()),
              _getText(snapshot.data?.aboutStore),
            ]),
          );
        }),
  );

  Widget _getImageWidget(String? image) => Container(
    margin: const EdgeInsets.only(bottom: AppMargin.m18),
        height: AppSize.s200,
        width: double.infinity,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(AppSize.s8))),
        child: image!=null?Image.network(
          image,
          fit: BoxFit.cover,
        ):Container(),
      );

  Widget _getTitleWidget(String? title) => Padding(
    padding: const EdgeInsets.only(bottom: AppPadding.p8),
    child: title!=null?Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ):Container(),
  );

  Widget _getText(String? text) => Padding(
    padding: const EdgeInsets.only(bottom: AppPadding.p16),
    child: Wrap(
      children: [
        text!=null?Text(text,style: Theme.of(context).textTheme.bodyMedium,):Container()
      ],
    ),
  );
}
