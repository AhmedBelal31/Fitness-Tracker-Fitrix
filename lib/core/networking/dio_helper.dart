import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';
import 'auth_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.apiBaseUrl,
          connectTimeout: const Duration(seconds: 120),
          receiveTimeout: const Duration(seconds: 120),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          // Add this to get more detailed error information
          validateStatus: (status) {
            // Accept all status codes to handle them manually
            return status != null && status < 500;
          },
        ),
      ) {
    _dio.interceptors.addAll([
      AuthInterceptor(_dio),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    ]);
  }

  // ========== GET REQUEST ==========
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  // ========== POST REQUEST (JSON) ==========
  Future<Response> postRequest(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {'Content-Type': 'application/json', ...?headers},
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  // ========== POST REQUEST (FormData) ==========
  Future<Response> postRequestWithFormData(
    String endpoint,
    FormData formData, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.post(
      endpoint,
      data: formData,
      options: Options(
        headers: {'Content-Type': 'multipart/form-data', ...?headers},
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  // ========== PUT REQUEST (JSON) ==========
  Future<Response> putRequest(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {'Content-Type': 'application/json', ...?headers},
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  // ========== PUT REQUEST (FormData) ==========
  Future<Response> putRequestWithFormData(
    String endpoint,
    FormData formData, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.put(
      endpoint,
      data: formData,
      options: Options(
        headers: {'Content-Type': 'multipart/form-data', ...?headers},
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  // ========== PATCH REQUEST (JSON) ==========
  Future<Response> patchRequest(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.patch(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {'Content-Type': 'application/json', ...?headers},
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }
  // core/networking/api_service.dart

  // ========== PATCH REQUEST (URL Encoded) ==========
  Future<Response> patchRequestWithUrlEncoded(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.patch(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        // ✅ Use application/x-www-form-urlencoded
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          ...?headers,
        },
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  Future<Response> patchRequestWithFormData(
    String endpoint,
    FormData formData, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.patch(
      endpoint,
      data: formData,
      options: Options(
        headers: {'Content-Type': 'multipart/form-data', ...?headers},
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  // ========== DELETE REQUEST ==========
  Future<Response> deleteRequest(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.delete(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
    );
  }

  // ========== DOWNLOAD FILE ==========
  Future<Response> downloadFile(
    String endpoint,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.download(
      endpoint,
      savePath,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // ========== UPLOAD FILE ==========
  Future<Response> uploadFile(
    String endpoint,
    String filePath, {
    String fileKey =
        'file', // 👈 Remove the ? (make it non-nullable with default value)
    Map<String, dynamic>? additionalData,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    final formData = FormData.fromMap({
      fileKey: await MultipartFile.fromFile(filePath),
      if (additionalData != null) ...additionalData,
    });

    return _dio.post(
      endpoint,
      data: formData,
      options: Options(
        headers: {'Content-Type': 'multipart/form-data'},
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      ),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }
}
