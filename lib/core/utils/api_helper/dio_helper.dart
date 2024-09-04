import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie/core/error/exceptions.dart';
import 'package:movie/core/error/failures.dart';
import 'package:movie/core/error/failures_strings.dart';

class DioHelper {

  Future<Map<String, String>> header({required String endPoint}) async {
    Map<String, String> headers = {};
    return headers;
  }

  String getTypeOfFailure(Failure failure) {
    switch (failure.runtimeType) {
      case const (UnauthorizedFailure):
        return Strings.unauthorizedFailureMassage;
      case const (ServerFailure):
        return Strings.serverFailureMessage;
      case const (InternetFailure):
        return Strings.checkYourInternet;
      default:
        return failure.errorMessage ?? "UnExpected Error";
    }
  }

  static Failure buildFailure(dynamic e, {String? message1}) {
    switch (e.runtimeType) {
      case const (ServerException):
        return ServerFailure();
      case const (UnauthorizedException):
        return UnauthorizedFailure();
      case const (InternetException):
        return InternetFailure();
      case const (ErrorModelException):
        return ErrorMessageFailure(message: e.errorMessage);
      default:
        return ErrorMessageFailure(message: e.toString());
    }
  }

  static dynamic handleDioError({DioException? dioError, String? endpointName}) {
    if (kDebugMode) {
      log("dioError${dioError?.message}");
      log('endpointName$endpointName');
    }

    switch (dioError!.type) {
      case DioExceptionType.badResponse:
        throw handleStatuesCodeResponse(
            response: dioError.response, endpointName: endpointName);
      case DioExceptionType.connectionError:
        throw InternetException();
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        throw handleStatuesCodeResponse(
            response: dioError.response, endpointName: endpointName);
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutException();
    }
  }

  static Exception handleStatuesCodeResponse({Response? response, String? endpointName}) {
    if (kDebugMode) {
      log("end point Name =$endpointName");
      log("status code${response?.statusCode}");
      log("error response${response?.data}");
    }
    switch (response?.statusCode) {
      case 500:
        throw ServerException();
      case 401:
        throw UnauthorizedException();
      default:
        if (response?.data.runtimeType == String) {
          throw ErrorModelException(errorMessage: response!.data);
        } else {
          throw ErrorModelException.fromJson(response!.data);
        }
    }
  }
}
