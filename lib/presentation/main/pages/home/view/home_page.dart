import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/domain/models/home_model.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:maleapp/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:maleapp/presentation/resources/assets_manger.dart';
import 'package:maleapp/presentation/resources/color_manger.dart';
import 'package:maleapp/presentation/resources/value_manger.dart';

import '../../../../resources/routes_manger.dart';
import '../../../../resources/strings_manger.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  void _bind() {
    _homeViewModel.start();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _homeViewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(context, _content(context), () {
              _homeViewModel.start();
            }) ??
            Container());
  }

  Widget _content(context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: StreamBuilder<HomeViewObjectWithoutNull>(
            stream: _homeViewModel.outputHomeViewObjectWithoutNull,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getCarouselWidget(snapshot.data?.homeViewObject.banners),
                  _getTitleWidget('Services'),
                  _getServicesWidget(snapshot.data?.homeViewObject.services),
                  _getTitleWidget('Stores'),
                  _getStoresWidget(snapshot.data?.homeViewObject.stores)
                ],
              );
            }
          ),
        ),
      );

  Widget _getCarouselWidget(List<BannerModel>? banners) {
    if(banners!=null)
      {
    return CarouselSlider(
    items: banners.map((banner) => SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: ColorManager.black),
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(banner.image,fit: BoxFit.cover,)),
      ),
    )).toList()??[],

    options: CarouselOptions(
        autoPlay: true,
        height: 150,
        enableInfiniteScroll: true,
        enlargeCenterPage: true
    ),
  );}
    else {
      return Container();
    }
  }

  Widget _getTitleWidget(String title) => Padding(
    padding: const EdgeInsets.only(top: AppSize.s16),
    child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
  );

  Widget _getServicesWidget(List<ServiceModel>? services) {
    if(services!=null)
    {return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSize.s8),
        child: Container(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
              services.map((service) => Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 130,
                        width: 150,
                        child: ClipRRect(child: Image.network(service.image,fit: BoxFit.fill,))),
                    Text(
                      service.title,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                color: ColorManager.white,
                elevation: AppSize.s1_5,
                shadowColor: ColorManager.grey4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppPadding.p8),
                    side: BorderSide(
                        color: ColorManager.white, width: AppSize.s1_5)),
              )).toList()??[]

              ,
            )),
      );}
    else {
      return Container();
    }
  }

  Widget _getStoresWidget(List<StoreModel>? stores) {
    if(stores!=null)
    {return Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            mainAxisSpacing: AppSize.s10,
            crossAxisSpacing: AppSize.s10,
            crossAxisCount: 2,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children:
            stores.map((store) =>  SizedBox(
              height: 50,
              width: 50,
              child: InkWell(onTap: (){
                Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
              },child: Image.network(store.image,fit: BoxFit.cover,)),
            )).toList()??[]

            ,
          )
        ],
      );}
    else{
      return Container();
    }
  }
}

//builder
// builder: (context, snapshot) =>
// snapshot.data?.getScreenWidget(
// context, _content(context), (){_homeViewModel.start();}) ??
// LoadingState(
// stateRendererType:
// StateRendererType.FULL_SCREEN_LOADING_STATE)
// .getScreenWidget(context, _content(context), () {}));
