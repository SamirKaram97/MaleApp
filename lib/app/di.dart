import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maleapp/data/data_source/local_data_source/local_data_source.dart';
import 'package:maleapp/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:maleapp/data/networks/dio_factory.dart';
import 'package:maleapp/data/networks/network_info.dart';
import 'package:maleapp/data/repository/repository.dart';
import 'package:maleapp/domain/usecase/forgot_password_usecase.dart';
import 'package:maleapp/domain/usecase/getHome_usecase.dart';
import 'package:maleapp/domain/usecase/login_usecase.dart';
import 'package:maleapp/domain/usecase/register_usecase.dart';
import 'package:maleapp/presentation/base/view_model/base_view_model.dart';
import 'package:maleapp/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:maleapp/presentation/login/view_model/login_view_model.dart';
import 'package:maleapp/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:maleapp/presentation/store_details/view/store_details_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/networks/app_api.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/get_store_details_usecase.dart';
import '../presentation/register/view_model/register_view_model.dart';
import '../presentation/store_details/view_model/store_details_view_model.dart';
import 'app_preferances.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //shared preference
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //App preference
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance()));

  //internet connection checker
  instance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: instance()));

  //dio Factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(appPreferences: instance()));

  //dio
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDatasource>(() =>
      RemoteDatasourceImpl(appServiceClient: instance<AppServiceClient>()));

  instance.registerLazySingleton<LocalDataSource>(() =>
      LocalDataSourceImpl());

  //repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
      networkInfo: instance(), remoteDatasource: instance<RemoteDatasource>(),localDatasource: instance<LocalDataSource>()));
}

initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    // to sure there are not instance registered //todo search about that
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(repository: instance<Repository>()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(loginUseCase: instance<LoginUseCase>()));
  }
}

initForgotPasswordModule() async {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    // to sure there are not instance registered //todo search about that
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(repository: instance<Repository>()));

    instance.registerFactory<ForgotPasswordViewModel>(() =>
        ForgotPasswordViewModel(
            forgotPasswordUseCase: instance<ForgotPasswordUseCase>()));
  }
}

initRegisterModule() async {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    // to sure there are not instance registered //todo search about that
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(repository: instance<Repository>()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(registerUseCase: instance<RegisterUseCase>()));
  }
}

initHomeModule() async {
  if (!GetIt.I.isRegistered<GetHomeUseCase>()) {
    // to sure there are not instance registered //todo search about that
    instance.registerFactory<GetHomeUseCase>(
            () => GetHomeUseCase(repository: instance<Repository>()));
    instance.registerFactory<HomeViewModel>(
            () => HomeViewModel(getHomeUseCase: instance<GetHomeUseCase>()));
  }
}


initStroeDetailsModule() async {
  if (!GetIt.I.isRegistered<GetStoreDetailsUseCase>()) {
    // to sure there are not instance registered //todo search about that
    instance.registerFactory<GetStoreDetailsUseCase>(
            () => GetStoreDetailsUseCase(repository: instance<Repository>()));
    instance.registerFactory<StoreDetailsViewModel>(
            () => StoreDetailsViewModel(getStoreDetailsUseCase: instance<GetStoreDetailsUseCase>()));
  }
}

