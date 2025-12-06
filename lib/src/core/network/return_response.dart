import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import '../../config/constants/status_codes.dart';
import '../../features/auth/service/auth_service.dart';
import '../di/service_locator.dart';
import '../errors/exceptions.dart';
import '../utils/app_logs.dart';

/// A helper class that standardizes API responses and exceptions.
class ReturnResponse {
  /// Handles Dio responses or errors and returns parsed data or throws appropriate exceptions.
  static dynamic handler({DioException? error, Response? response}) {
    if (response != null && StatusCodes.success.contains(response.statusCode)) {
      return response.data;
    } else {
      return _handleError(error);
    }
  }

  static dynamic _handleError(DioException? error) {
    final int? statusCode = error?.response?.statusCode;
    final DioException errorData = extractErrorData(error);
    final String? responseText = errorData.response?.data?.toString();

    if (StatusCodes.informational.contains(statusCode)) {
      Log.e(InformationalException(responseText));
      throw InformationalException(responseText);
    } else if (StatusCodes.redirection.contains(statusCode)) {
      Log.e(RedirectionStatusException(responseText));
      throw RedirectionStatusException(responseText);
    } else if (StatusCodes.badRequest.contains(statusCode)) {
      Log.e(BadRequestException(responseText));
      throw BadRequestException(responseText);
    } else if (StatusCodes.unauthorized.contains(statusCode)) {
      sl<AuthService>().logout();
      Log.e(UnAuthoriseException(responseText));
      throw UnAuthoriseException(responseText);
    } else if (StatusCodes.notFound.contains(statusCode)) {
      Log.e(NotFoundException(responseText));
      throw NotFoundException(responseText);
    } else if (StatusCodes.requestTimeout.contains(statusCode)) {
      Log.e(ServerRequestTimeOutException(responseText));
      throw ServerRequestTimeOutException(responseText);
    } else if (StatusCodes.clientError.contains(statusCode)) {
      Log.e(ClientException(responseText));
      throw ClientException(responseText);
    } else if (StatusCodes.serverError.contains(statusCode)) {
      Log.e(ErrorFromServerSideException(responseText));
      throw ErrorFromServerSideException(responseText);
    } else {
      final unknown = FetchDataException(
        "Error communicating with server (Status Code: $statusCode)",
      );
      Log.e(unknown);
      throw unknown;
    }
  }
}

dio.DioException extractErrorData(dio.DioException? error) {
  return DioException(
    response: dio.Response(
      data: error?.response?.data,
      statusCode: error?.response?.statusCode,
      requestOptions: error!.requestOptions,
    ),
    requestOptions: error.requestOptions,
    type: error.type,
  );
}
