import 'package:maleapp/app/constants.dart';
import 'package:maleapp/app/extensions.dart';
import 'package:maleapp/data/resposes/Authentication_respose.dart';
import 'package:maleapp/data/resposes/forgot_password_response.dart';
import 'package:maleapp/data/resposes/home_response.dart';
import 'package:maleapp/data/resposes/store_details_response.dart';
import 'package:maleapp/domain/models/forgot_password_model.dart';
import 'package:maleapp/domain/models/home_model.dart';
import 'package:maleapp/domain/models/login_model.dart';
import 'package:maleapp/presentation/resources/strings_manger.dart';

import '../../domain/models/store_details_model.dart';

extension NonNullableCustomer on CustomerResponse?
{
  CustomerModel toDomain()
  {
    return CustomerModel(name: this?.name.orEmpty()??Constants.empty,id: this?.id.orEmpty()??Constants.empty,numOfNotifications: this?.numOfNotifications??Constants.zero);
  }
}

extension NonNullableContact on ContactsResponse?
{
  ContactsModel toDomain()
  {
    return ContactsModel(email: this?.email.orEmpty()??Constants.empty,link: this?.link.orEmpty()??Constants.empty,phone: this?.phone.orEmpty()??Constants.empty);
  }
}

extension NonNullableAuthentication on AuthenticationResponse?
{
  AuthenticationModel toDomain()
  {
    return AuthenticationModel(customerModel: this?.customerResponse.toDomain(),contactsModel: this?.contactsResponse.toDomain());
  }
}

extension NonNullableForgotPassword on ForgotPasswordResponse?
{
  ForgotPasswordModel toDomain()
  {
    return ForgotPasswordModel(support: this?.support.orEmpty()??Constants.empty);
  }
}


//home

extension NonNullableStore on StoreResponse?
{
  StoreModel toDomain()
  {
    return StoreModel(id: this?.id.orZero()??Constants.zero, title: this?.title.orEmpty()??Constants.empty, image: this?.image.orEmpty()??Constants.empty);
  }
}

extension NonNullableService on ServiceResponse?
{
  ServiceModel toDomain()
  {
    return ServiceModel(id: this?.id.orZero()??Constants.zero, title: this?.title.orEmpty()??Constants.empty, image: this?.image.orEmpty()??Constants.empty);
  }
}

extension NonNullableBanner on BannerResponse?
{
  BannerModel toDomain()
  {
    return BannerModel(id: this?.id.orZero()??Constants.zero, title: this?.title.orEmpty()??Constants.empty, image: this?.image.orEmpty()??Constants.empty,link: this?.link.orEmpty()??Constants.empty);
  }
}

extension NonNullableHomeData on HomeDataResponse?
{
  HomeDataModel toDomain()
  {
    List<ServiceModel> services=this?.servicesResponse.map((serviceResponse) => serviceResponse.toDomain()).toList()??const Iterable.empty().cast<ServiceModel>().toList();
    List<StoreModel> stores=this?.storesResponses.map((storeResponse) => storeResponse.toDomain()).toList()??const Iterable.empty().cast<StoreModel>().toList();
    List<BannerModel> banners=this?.bannersResponses.map((bannerResponse) => bannerResponse.toDomain()).toList()??const Iterable.empty().cast<BannerModel>().toList();
    return HomeDataModel(bannersModels: banners,servicesModel: services,storesModels: stores);
  }
}

extension NonNullableHome on HomeResponse
{
  HomeModel toDomain()
  {
    return HomeModel(homeDataModel: this.homeDataResponse.toDomain());
  }
}



extension NonNullableStoreDetails on StoreDetailsResponse?
{
  StoreDetailsModel toDomain()
  {
    return StoreDetailsModel(about: this?.about.orEmpty()??Constants.empty,services: this?.services.orEmpty()??Constants.empty,details: this?.details.orEmpty()??Constants.empty,image: this?.image.orEmpty()??Constants.empty,title: this?.title.orEmpty()??Constants.empty,id: this?.id.orZero()??Constants.zero);
  }
}

//another way
// extension NonNullableStore on List<StoreResponse?>
// {
//   List<StoreModel> toDomain()
//   {
//     List<StoreModel> list=[];
//     forEach((element) {
//       list.add(StoreModel(id: element?.id.orEmpty()??'', title:element?.title.orEmpty()??'' ,image: element?.image.orEmpty()??''));
//     });
//     return list;
//   }
// }
//
// extension NonNullableService on List<ServiceResponse?>
// {
//   List<ServiceModel> toDomain()
//   {
//     List<ServiceModel> list=[];
//     forEach((element) {
//       list.add(ServiceModel(id: element?.id.orEmpty()??'', title:element?.title.orEmpty()??'' ,image: element?.image.orEmpty()??''));
//     });
//     return list;
//   }
// }
//
// extension NonNullableBanner on List<BannerResponse?>
// {
//   List<BannerModel> toDomain()
//   {
//
//     List<BannerModel> list=[];
//
//     forEach((element) {
//       list.add(BannerModel(id: element?.id.orEmpty()??'', title:element?.title.orEmpty()??'' ,image: element?.image.orEmpty()??'',link:element?.link.orEmpty()??'' ));
//     });
//     return list;
//   }
// }
