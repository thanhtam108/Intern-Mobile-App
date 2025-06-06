import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vietcook1/core/data/network/exceptions/error_message.dart';
import 'package:vietcook1/core/data/network/model/error_response_dto.dart';

import 'status_code.dart';

class AppException implements Exception {
  final int? statusCode;
  final String? message;
  final String? errorCode;

  AppException({this.statusCode, this.message, this.errorCode});

  static AppException parse(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return AppException(
        statusCode: StatusCode.connectTimeout,
        message: ErrorMessage.timeoutError,
        errorCode: ErrorMessage.timeoutError,
      );
    } else if (error.type == DioExceptionType.sendTimeout) {
      return AppException(
        statusCode: StatusCode.sendTimeout,
        message: ErrorMessage.timeoutError,
        errorCode: ErrorMessage.timeoutError,
      );
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return AppException(
        statusCode: StatusCode.receiveTimeout,
        message: ErrorMessage.timeoutError,
      );
    } else if (error.type == DioExceptionType.cancel) {
      return AppException(
        statusCode: StatusCode.cancel,
        message: ErrorMessage.cancelError,
        errorCode: ErrorMessage.cancelError,
      );
    } else if (error.type == DioExceptionType.badResponse) {
      final baseRp = ErrorResponseDto.fromJson(error.response!.data);

      return AppException(
        statusCode: StatusCode.badRequest,
        message: baseRp.message,
        errorCode: baseRp.code,
      );
    } else if (error.type == DioExceptionType.unknown) {
      if (error.error is SocketException) {
        return AppException(
          statusCode: StatusCode.internalServerError,
          message: ErrorMessage.internalServerError,
          errorCode: ErrorMessage.internalServerError,
        );
      } else {
        return AppException(
          statusCode: StatusCode.unknown,
          message: ErrorMessage.unknownError,
          errorCode: ErrorMessage.unknownError,
        );
      }
    } else {
      return AppException(
        statusCode: StatusCode.unknown,
        message: ErrorMessage.unknownError,
        errorCode: ErrorMessage.unknownError,
      );
    }
  }
}
