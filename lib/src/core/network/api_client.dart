import 'package:dio/dio.dart';
import 'package:kuick_workflow/src/core/network/return_response.dart';
import '../../config/env/environment_config.dart';
import '../storage/hive/hive_boxes.dart';
import '../storage/storage_keys.dart';
import '../utils/app_logs.dart';

class DioClient {
  final Dio dio;

  DioClient() : dio = Dio() {
    dio.options = BaseOptions(
      baseUrl: EnvironmentConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final headers = await _headers();
          options.headers.addAll(
            headers.headers ?? {'Content-Type': 'application/json'},
          );
          Log.i(options.headers,label: "API headers");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          ReturnResponse.handler(response: response);
          return handler.next(response);
        },
        onError: (error, handler) {
          ReturnResponse.handler(error: error);
          return handler.next(error);
        },
      ),
    );
  }

  Future<Options> _headers() async {
    String? jwt = await getToken();
    return Options(
      headers: {'Authorization': jwt, 'Content-Type': 'application/json'}
        ..removeWhere((key, value) => value == null),
    );
  }

  Future<String?> getToken() async {
    var data = HiveBoxes.userBox.get(StorageKeys.currentUser);
    Log.i("Bearer ${data.data?.token}");
    return "Bearer ${data.data?.token}";
  }
}
