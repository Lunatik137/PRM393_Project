import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showLogo;
  final PreferredSizeWidget? bottom;

  const AppHeader({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showLogo = false,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: showLogo
          ? Row(
              mainAxisSize: MainAxisSize.min, // Ensures it centers well
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: Colors.brown,
                ), // Placeholder for logo
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Origami',
                  style: AppTextStyles.sectionTitle.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            )
          : (title != null ? Text(title!, style: AppTextStyles.titleLarge) : null),
      leading: leading,
      actions: actions,
      centerTitle: true,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    double height = kToolbarHeight;
    if (bottom != null) {
      height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(height);
  }
}
