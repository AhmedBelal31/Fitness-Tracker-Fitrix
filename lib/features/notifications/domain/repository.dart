import 'package:dartz/dartz.dart';
import '../../../core/networking/error/failures.dart';
import '../data/models/notification_model.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationModel>>> getNotifications({
    int pageSize = 20,
    int pageNumber = 1,
    bool unreadOnly = false,
  });

  Future<Either<Failure, int>> getUnreadCount();

  Future<Either<Failure, void>> markAsRead(String notificationId);

  Future<Either<Failure, void>> markAllAsRead();

  Future<Either<Failure, void>> deleteNotification(String notificationId);
}
