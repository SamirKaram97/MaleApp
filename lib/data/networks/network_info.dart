import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo
{
  Future<bool> isNetworkConnectionWork();
}

class NetworkInfoImpl implements NetworkInfo
{
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl({required this.internetConnectionChecker});


  @override
  Future<bool> isNetworkConnectionWork()async {
    return internetConnectionChecker.hasConnection;
  }

}