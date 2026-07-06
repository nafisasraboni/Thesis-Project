import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_app/app.dart';
import 'package:my_app/core/constants/app_strings.dart';

void main() {
  testWidgets('navigates from splash to dashboard after initialization', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: MalwareDetectionApp()));

    expect(find.text(AppStrings.appTitle), findsOneWidget);
    expect(find.text(AppStrings.splashHeadline), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Quick Scan'), findsOneWidget);
  });
}
