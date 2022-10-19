import 'package:dio/dio.dart';
import 'package:maleapp/data/networks/failure.dart';

class ErrorHandler implements Exception{
  late Failure failure;

  ErrorHandler.handle(dynamic error) {

    if (error is DioError)
    {
      failure=_getDioFailure(error);
    }
    else
    {
      failure = DataSource.DEFAULT.getFailure();

    }
  }

  Failure _getDioFailure(DioError error)
  {
    switch(error.type)
    {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();

      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();

      case DioErrorType.response:
        return _getResponseError(error);


      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();

    }
  }


  Failure _getResponseError(DioError responseError)
  {
    if(responseError.response?.statusMessage!=null&&responseError.response?.statusCode!=null)
      {
        return Failure(message: responseError.response!.statusMessage!, code: responseError.response!.statusCode!);
      }
    else
      {
        return DataSource.DEFAULT.getFailure();
      }
  }
}
//todo with omran enum video
enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET,
  DEFAULT
}

class ResponseCode {
  static int SUCCESS = 200;
  static int NO_CONTENT = 201;
  static int BAD_REQUEST = 400;
  static int FORBIDDEN = 403;
  static int UNAUTHORISED = 401;
  static int NOT_FOUND = 404;
  static int INTERNAL_SERVER_ERROR = 500;

  //local
  static int CONNECT_TIMEOUT = -1;
  static int CANCEL = -2;

  static int RECEIVE_TIMEOUT = -3;
  static int SEND_TIMEOUT = -4;
  static int CACHE_ERROR = -5;
  static int NO_INTERNET = -6;
  static int DEFAULT = -7;
}

class ResponseMessage {
  static String SUCCESS = "Success";
  static String NO_CONTENT = "Success, But no content.";
  static String BAD_REQUEST = "Bad request, Try again later.";
  static String FORBIDDEN = "Forbidden, Try again later.";
  static String UNAUTHORISED = "Unauthorised, Try again later.";
  static String NOT_FOUND = "Not found, Try again later.";
  static String INTERNAL_SERVER_ERROR = "Internal server error.";

  //local
  static String CONNECT_TIMEOUT = "connect timeout, Try again later.";
  static String CANCEL = "Canceled, Try again later.";
  static String RECEIVE_TIMEOUT = "Receive timeout, Try again later";
  static String SEND_TIMEOUT = "Send timeout, Try again later";
  static String CACHE_ERROR = "Cache error, Try again later";
  static String NO_INTERNET = "No internet, Try again later";

  static String DEFAULT = "Unknow error, Try again later";
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(
            code: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS);

      case DataSource.NO_CONTENT:
        return Failure(
            code: ResponseCode.NO_CONTENT, message: ResponseMessage.NO_CONTENT);

      case DataSource.BAD_REQUEST:
        return Failure(
            code: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(
            code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHORISED:
        return Failure(
            code: ResponseCode.UNAUTHORISED,
            message: ResponseMessage.UNAUTHORISED);

      case DataSource.NOT_FOUND:
        return Failure(
            code: ResponseCode.NOT_FOUND, message: ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            code: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(
            code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);

      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            code: ResponseCode.RECEIVE_TIMEOUT,
            message: ResponseMessage.RECEIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(
            code: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET:
        return Failure(
            code: ResponseCode.NO_INTERNET,
            message: ResponseMessage.NO_INTERNET);

      case DataSource.DEFAULT:
        return Failure(
            code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }

}
class ApiInternalState
{
  static const int success=1;
  static const int failed=0;
}
