import 'package:maleapp/app/app_preferances.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/data/networks/error_handler.dart';
import 'package:maleapp/data/resposes/store_details_response.dart';

import '../../resposes/home_response.dart';

const String CACHED_HOME_KEY="CACHED_HOME_KEY";
const String CACHED_STORE_DETAILS_KEY="CACHED_STORE_DETAILS_KEY";

abstract class LocalDataSource
{

  Future<HomeResponse> getHome();
  Future<HomeResponse> getHomeShared();
  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveHomeData(HomeDataResponse homeDataResponse);
  void saveHomeDataToShared(String homeDataResponse);
  Future<void> saveStoreDetailsData(StoreDetailsResponse storeDetailsResponse);
  void clearCache();
}

class LocalDataSourceImpl implements LocalDataSource
{
  final AppPreferences _appPreferences=instance<AppPreferences>();
  Map<String,CashedItem> cachedMap={};

  @override
  Future<HomeResponse> getHome()async {
    if(cachedMap[CACHED_HOME_KEY]?.data!=null)
      {
        int delayTime=(DateTime.now().millisecondsSinceEpoch)-(cachedMap[CACHED_HOME_KEY]!.cachedTime);
        if(delayTime<60000)
        {
          return HomeResponse(homeDataResponse: cachedMap[CACHED_HOME_KEY]!.data);
        }
        else
          {
            throw ErrorHandler.handle(DataSource.CACHE_ERROR);
          }
      }
    else
      {
        throw ErrorHandler.handle(DataSource.CACHE_ERROR);
      }


  }

  @override
  Future<void> saveHomeData(HomeDataResponse homeDataResponse)async {
    cachedMap[CACHED_HOME_KEY]=CashedItem(data: homeDataResponse);
  }

  @override
  void clearCache()
  {
    cachedMap.clear();
  }
  void removeFromCache(String key)
  {
    cachedMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails()async {
    print(cachedMap[CACHED_STORE_DETAILS_KEY]?.data);
    print(cachedMap[CACHED_STORE_DETAILS_KEY]?.data!=null);
    print(cachedMap[CACHED_STORE_DETAILS_KEY]!=null);
    print(cachedMap[CACHED_STORE_DETAILS_KEY]?.data.id);

    if(cachedMap[CACHED_STORE_DETAILS_KEY]?.data!=null)
    {
      int delayTime=(DateTime.now().millisecondsSinceEpoch)-(cachedMap[CACHED_STORE_DETAILS_KEY]!.cachedTime);
      print(delayTime);
      if(delayTime<60000)
      {
        return cachedMap[CACHED_STORE_DETAILS_KEY]!.data;
      }
      else
      {
        print("error from first");
        throw ErrorHandler.handle(DataSource.CACHE_ERROR);
      }
    }
    else
    {
      print("error from second");
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsData(StoreDetailsResponse storeDetailsResponse)async {
    cachedMap[CACHED_STORE_DETAILS_KEY]=CashedItem(data: storeDetailsResponse);
  }

  @override
  void saveHomeDataToShared(String homeDataResponse) {
    _appPreferences.saveHomeDataToShared(homeDataResponse);
  }

  @override
  Future<HomeResponse> getHomeShared()async {
    return await _appPreferences.getHomeShared();
  }



}

class CashedItem // 34an a7t el time m3 data bs knt t2dr t3ml el map <String,HomeResponse> bs 34an el time
{
  dynamic data;
  int cachedTime=DateTime.now().millisecondsSinceEpoch;

  CashedItem({required this.data});
}



