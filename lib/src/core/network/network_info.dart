import 'dart:convert';
import 'package:dio/dio.dart';
import '../../config/constants/strings.dart';
import '../errors/exceptions.dart' show FetchDataException;
import '../utils/app_logs.dart';
import 'api_client.dart';
import 'model/error_res.dart';

class NetworkCalls {
  final DioClient dioClient;

  NetworkCalls({required this.dioClient});

  //============================================================================
  //  **   Get Method   **
  //============================================================================

  Future performGet(
    String url, {
    void Function(int, int)? onReceiveProgress,
        Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return performRequest(
      () async => await dioClient.dio.get(
        url,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      ),
    );
  }

  //============================================================================
  //  **   Post Method   **
  //============================================================================

  Future performPost(
    String url,
    dynamic bodyData, {
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return performRequest(
      () async => await dioClient.dio.post(
        url,
        data: bodyData,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      ),
    );
  }

  //============================================================================

  //============================================================================
  //  **   Delete Method   **
  //============================================================================

  Future performDelete(
    String url,
    dynamic bodyData, {
    CancelToken? cancelToken,
        Map<String, dynamic>? headers,
  }) async {
    return performRequest(
      () async => await dioClient.dio.delete(
        url,
        data: bodyData,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      ),
    );
  }

  //============================================================================
  //  **   Put Method   **
  //============================================================================

  Future performPut(
    String url,
    dynamic bodyData, {
    void Function(int, int)? onReceiveProgress,
        Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return performRequest(
      () async => await dioClient.dio.put(
        url,
        data: bodyData,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      ),
    );
  }

  //============================================================================
  //  **   Patch Method   **
  //============================================================================

  Future performPatch(
    String url,
    dynamic bodyData, {
    void Function(int, int)? onReceiveProgress,
        Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    return performRequest(
      () async => await dioClient.dio.patch(
        url,
        data: bodyData,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      ),
    );
  }

  //============================================================================
  //  **   MultiPart Method   **
  //============================================================================

  Future performMultipart(
    String url,
    bodyData, {
    void Function(int p1, int p2)? onReceiveProgress,
    void Function(int p1, int p2)? onSendProgress,
        Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) {
    return performRequest(
      () async => await dioClient.dio.post(
        url,
        data: FormData.fromMap(bodyData),
        onSendProgress: onSendProgress,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      ),
    );
  }

  //==============================================================================
  //  ** Perform Data Request Function **
  //==============================================================================

  Future<dynamic> performRequest(Future<Response> Function() request) async {
    dynamic resJson;

    try {
      final response = await request();
      resJson = response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        Log.e(FetchDataException(ExceptionPrefix.noInternetMsg));
        throw ExceptionPrefix.noInternetMsg;
      } else {
        ErrorRes error = errorResFromJson(json.encode(e.response?.data));
        if (e.response == null) {
          throw e.error ?? ExceptionPrefix.defaultErrorMsg;
        } else if (error.error != null) {
          throw (error.error is String ? error.error : error.message) ??
              ExceptionPrefix.defaultErrorMsg;
        } else {
          throw error.message ?? ExceptionPrefix.defaultErrorMsg;
        }
      }
    }
    if (json.decode(json.encode(resJson))["errors"] != null) {
      throw ExceptionPrefix.defaultErrorMsg;
    }

    return resJson;
  }
}
