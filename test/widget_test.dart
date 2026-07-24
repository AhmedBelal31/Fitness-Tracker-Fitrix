import 'package:fitrix/core/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App Router smoke test', (WidgetTester tester) async {
    final appRouter = AppRouter();
    expect(appRouter, isNotNull);
  });
}

