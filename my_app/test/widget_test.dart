import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/core/constants/app_strings.dart';

void main() {
  test('app title matches thesis project branding', () {
    expect(AppStrings.appTitle, 'MalGuard');
  });
}
