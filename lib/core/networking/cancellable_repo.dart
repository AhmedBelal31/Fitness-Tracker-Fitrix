import 'package:dio/dio.dart';

mixin CancellableRepo {
  static CancelToken _sharedCancelToken = CancelToken();

  CancelToken get cancelToken => _sharedCancelToken;

  void cancelRequests([String reason = "Cancelled"]) {
    //   if (!_sharedCancelToken.isCancelled) {
    //     _sharedCancelToken.cancel(reason);
    //   }
    //   _sharedCancelToken = CancelToken();
  }
}
