import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:maleapp/app/app_preferances.dart';
import 'package:maleapp/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


const String CONTENT_TYPE="content-type";
const String AUTHORIZATION="authorization";
const String ACCEPT="accept";
const String DEFAULT_LANGUAGE="language";
const String APPLICATION_JSON="application/json";


class DioFactory
{
  DioFactory({required this.appPreferences});
  final AppPreferences appPreferences;
   Dio dio=Dio();

   //min

   Future<Dio> getDio()async
   {
     String language=appPreferences.getLanguage();

     Map<String,String> headers={
       CONTENT_TYPE:APPLICATION_JSON,
       ACCEPT:APPLICATION_JSON,
       AUTHORIZATION:Constants.token,
       DEFAULT_LANGUAGE:language,
     };

     dio.options=BaseOptions(
       baseUrl: Constants.baseUrl,
       connectTimeout:Constants.connectTimeout,
       receiveTimeout: Constants.receiveTimeout,
       headers: headers,
     );
     if(!kReleaseMode)//only in debug mode
       {
         //todo search about interceptor meaning
         dio.interceptors.add(PrettyDioLogger(
            requestHeader : true,
            requestBody : true,
            responseHeader : true,
         ));

       }
     return dio;
   }


}