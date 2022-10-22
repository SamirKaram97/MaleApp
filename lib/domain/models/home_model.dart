class HomeModel {
  HomeDataModel homeDataModel;

  HomeModel({required this.homeDataModel});
}

class HomeDataModel {
  List<ServiceModel> servicesModel;

  List<BannerModel> bannersModels;

  List<StoreModel> storesModels;

  HomeDataModel(
      {required this.servicesModel,
      required this.bannersModels,
      required this.storesModels});
}

class ServiceModel {
  int id;

  String title;

  String image;

  ServiceModel({required this.id, required this.title, required this.image});
}

class BannerModel {
  int id;

  String title;

  String image;

  String link;

  BannerModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.link});
}

class StoreModel {
  int id;

  String title;

  String image;

  StoreModel({required this.id, required this.title, required this.image});
}
