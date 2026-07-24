import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitrix/core/common_ui/widgets/app_logger.dart';
import 'package:fitrix/features/notifications/domain/repository.dart';
import 'dart:developer';
import '../../../core/networking/dio_helper.dart';
import '../../../core/networking/error/failures.dart';
import '../data/models/notification_model.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final ApiService apiService;

  NotificationsRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications({
    int pageSize = 20,
    int pageNumber = 1,
    bool unreadOnly = false,
  }) async {
    try {
      final response = await apiService.get(
        '/Notification/my-notifications',
        queryParameters: {
          'pageSize': pageSize,
          'pageNumber': pageNumber,
          'unreadOnly': unreadOnly,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data as List<dynamic>;
        final notifications = data
            .map(
              (json) =>
                  NotificationModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        AppLogger.d('✅ Fetched ${notifications.length} notifications');
        return Right(notifications);
      } else {
        return Left(
          ServerFailure(
            'Failed to load notifications: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      log('❌ getNotifications failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in getNotifications', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final response = await apiService.get('/Notification/unread-count');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data as int);
      } else {
        return Left(
          ServerFailure(
            'Failed to load unread count: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      log('❌ getUnreadCount failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in getUnreadCount', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String notificationId) async {
    try {
      final response = await apiService.putRequest(
        '/Notification/$notificationId/mark-read',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(
          ServerFailure(
            'Failed to mark notification as read: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      log('❌ markAsRead failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in markAsRead', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      final response = await apiService.putRequest(
        '/Notification/mark-all-read',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(
          ServerFailure(
            'Failed to mark all notifications as read: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      log('❌ markAllAsRead failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in markAllAsRead', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
    String notificationId,
  ) async {
    try {
      final response = await apiService.deleteRequest(
        '/Notification/$notificationId',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(
          ServerFailure(
            'Failed to delete notification: ${response.statusMessage}',
          ),
        );
      }
    } on DioException catch (e) {
      log('❌ deleteNotification failed', error: e);
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      log('❌ Unexpected error in deleteNotification', error: e);
      return Left(UnexpectedFailure('Unexpected error: $e'));
    }
  }
}
