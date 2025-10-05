import 'dart:developer' as dev;
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
          baseUrl: ApiConstants.apiBaseUrl,
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
    dev.log(
      '🔧 ApiService initialized with baseUrl: ${ApiConstants.apiBaseUrl}',
      name: 'ApiService',
    );

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

  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      dev.log(
        '📤 GET Request: ${_dio.options.baseUrl}$endpoint',
        name: 'ApiService',
      );

      return await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      dev.log(
        '❌ GET Request Error: ${e.type} - ${e.message}',
        name: 'ApiService',
      );
      rethrow;
    }
  }

  Future<Response> postRequest(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
    Options? extraOptions, // extra Dio options to merge or override
  }) async {
    try {
      dev.log(
        '📤 POST Request: ${_dio.options.baseUrl}$endpoint',
        name: 'ApiService',
      );
      dev.log('📦 Request Data: $data', name: 'ApiService');

      Options options = Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) => status != null && status < 500,
      );

      // Merge extraOptions if provided
      if (extraOptions != null) {
        options = options.copyWith(
          headers: {...?options.headers, ...?extraOptions.headers},
          contentType: extraOptions.contentType ?? options.contentType,
          responseType: extraOptions.responseType ?? options.responseType,
          followRedirects:
              extraOptions.followRedirects ?? options.followRedirects,
          validateStatus: extraOptions.validateStatus ?? options.validateStatus,
          receiveTimeout: extraOptions.receiveTimeout ?? options.receiveTimeout,
          sendTimeout: extraOptions.sendTimeout ?? options.sendTimeout,
          extra: {...?options.extra, ...?extraOptions.extra},
          method: extraOptions.method ?? options.method,
          listFormat: extraOptions.listFormat ?? options.listFormat,
        );
      }

      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken,
      );

      dev.log('📥 POST Response: ${response.statusCode}', name: 'ApiService');
      return response;
    } on DioException catch (e) {
      dev.log('❌ POST Request DioException', name: 'ApiService');
      dev.log('Type: ${e.type}', name: 'ApiService');
      dev.log('Message: ${e.message}', name: 'ApiService');
      dev.log('Error: ${e.error}', name: 'ApiService');
      dev.log('URL: ${e.requestOptions.uri}', name: 'ApiService');
      rethrow;
    } catch (e) {
      dev.log('❌ POST Request Unknown Error: $e', name: 'ApiService');
      rethrow;
    }
  }

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

  Future<Response> updateRequest(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.put(
      endpoint,
      data: data,
      queryParameters: queryParams,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
  }

  Future<Response> updateRequestWithFormData(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.put(
      endpoint,
      data: data,
      queryParameters: queryParams,
      options: Options(
        headers: {'Content-Type': 'multipart/form-data', ...?headers},
      ),
      cancelToken: cancelToken,
    );
  }

  Future<Response> deleteRequest(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return _dio.delete(
      endpoint,
      queryParameters: queryParams,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
  }
}
