import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../generated/l10n.dart';
import '../common_ui/widgets/app_logger.dart';
import 'error/failures.dart';

typedef Parser<T> = T Function(dynamic data);

class NetworkUtils {
  static Future<Either<Failure, T>> handleRequest<T>({
    required Future<Response> Function() request,
    required T Function(dynamic data) parser,
  }) async {
    try {
      final response = await request();
      AppLogger.i(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final result = parser(response.data);
          return right(result);
        } catch (parseError) {
          AppLogger.e('Parsing error: ${parseError.toString()}');
          AppLogger.e('Response data: ${response.data}');

          // More specific error handling for type conversion errors
          if (parseError.toString().contains('is not a subtype of type')) {
            return left(
              ServerFailure('Data format error: ${parseError.toString()}'),
            );
          }

          return left(ServerFailure('Failed to parse response data'));
        }
      } else {
        AppLogger.e(response.data);
        return left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } catch (e) {
      AppLogger.e('Request error: ${e.toString()}');

      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(S.current.some_thing_went_wrong));
    }
  }

  static Future<Either<Failure, List<T>>> handleListRequest<T>({
    required Future<Response> Function() request,
    required T Function(dynamic item) parser,
  }) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is List) {
          final result = data.map((item) => parser(item)).toList();
          return right(result);
        } else {
          return left(ServerFailure(S.current.some_thing_went_wrong));
        }
      } else {
        return left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } catch (e) {
      AppLogger.e('Request error: ${e.toString()}');
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(S.current.some_thing_went_wrong));
    }
  }

  static Future<Either<Failure, List<T>>> handleListWithDataRequest<T>({
    required Future<Response> Function() request,
    required T Function(dynamic item) parser,
  }) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data is Map && data['data'] is List) {
          final listData = data['data'] as List;
          final result = listData.map((item) => parser(item)).toList();
          return right(result);
        } else {
          return left(ServerFailure(S.current.some_thing_went_wrong));
        }
      } else {
        return left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } catch (e) {
      AppLogger.e('Request error: ${e.toString()}');
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(S.current.some_thing_went_wrong));
    }
  }
}
