import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/core/theme/app_theme.dart';
import 'package:origami_master/core/theme/app_colors.dart';

void main() {
  test('AppTheme.light provides a valid ThemeData', () {
    final theme = AppTheme.light;
    expect(theme.useMaterial3, isTrue);
    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.scaffoldBackgroundColor, AppColors.background);
  });
}
