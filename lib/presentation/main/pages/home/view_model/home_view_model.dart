import 'dart:async';
import 'dart:ffi';
import 'package:maleapp/domain/models/home_model.dart';
import 'package:maleapp/domain/usecase/getHome_usecase.dart';
import 'package:maleapp/presentation/base/view_model/base_view_model.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeViewModel({required this.getHomeUseCase});

  final StreamController _homeViewObjectStreamController =
      BehaviorSubject<HomeViewObjectWithoutNull>();

  final GetHomeUseCase getHomeUseCase;

  @override
  void start() {
    getHomeData();
  }

  @override
  void dispose() {
    _homeViewObjectStreamController.close();
    super.dispose();
  }

  void getHomeData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    var responseOrFailure = await getHomeUseCase.execute(Void);
    responseOrFailure.fold((failure) {

      inputState.add(ErrorState(stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,message: failure.message));
    }, (model) {
      inputHomeViewObjectWithoutNull.add(HomeViewObjectWithoutNull(HomeViewObject(banners: model.homeDataModel.bannersModels,services: model.homeDataModel.servicesModel,stores: model.homeDataModel.storesModels)));
      inputState.add(ContentState());
    });
  }

  @override
  Sink get inputHomeViewObjectWithoutNull => _homeViewObjectStreamController.sink;

  @override
  Stream<HomeViewObjectWithoutNull> get outputHomeViewObjectWithoutNull =>
      _homeViewObjectStreamController.stream.map((object) => object);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeViewObjectWithoutNull;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObjectWithoutNull> get outputHomeViewObjectWithoutNull;

}


class HomeViewObject
{
  List<BannerModel> banners;
  List<ServiceModel> services;
  List<StoreModel> stores;

  HomeViewObject({required this.stores,required this.services,required this.banners,});
}

class HomeViewObjectWithoutNull
{
  HomeViewObject homeViewObject;
  HomeViewObjectWithoutNull(this.homeViewObject);
}


