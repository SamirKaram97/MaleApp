import 'dart:async';
import 'dart:ffi';

import 'package:maleapp/presentation/base/view_model/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecase/get_store_details_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class StoreDetailsViewModel extends BaseViewModel with StoreDetailsViewModelInputs,StoreDetailsViewModelOutputs
{
  StoreDetailsViewModel({required this.getStoreDetailsUseCase});

  final StreamController _storeDetailsController=BehaviorSubject<StoreDetailsViewObject>();
  GetStoreDetailsUseCase getStoreDetailsUseCase;

  @override
  void start() {
    getStoreDetails();
  }

  @override
  void dispose() {
    _storeDetailsController.close();
    super.dispose();
  }

  getStoreDetails()async
  {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    var responseOrFailure=await getStoreDetailsUseCase.execute(Void);
    responseOrFailure.fold((failure) {
      inputState.add(ErrorState(stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,message: failure.message));
    }, (model) {
      inputStoreDetailsViewObject.add(StoreDetailsViewObject(services: model.services,details: model.details,id: model.id,image: model.image,aboutStore: model.about));
      inputState.add(ContentState());
    });
  }

  @override
  Sink get inputStoreDetailsViewObject =>_storeDetailsController.sink;

  @override
  Stream<StoreDetailsViewObject> get outputStoreDetailsViewObject =>_storeDetailsController.stream.map((storeDetailsViewModelOutputs) => storeDetailsViewModelOutputs);
}


abstract class StoreDetailsViewModelInputs
{
  Sink  get inputStoreDetailsViewObject;
}


abstract class StoreDetailsViewModelOutputs
{
  Stream<StoreDetailsViewObject> get outputStoreDetailsViewObject;
}


class StoreDetailsViewObject
{
  String image;
  String details;
  int id;
  String services;
  String aboutStore;

  StoreDetailsViewObject({required this.id,required this.image,required this.services,required this.aboutStore,required this.details});
}
