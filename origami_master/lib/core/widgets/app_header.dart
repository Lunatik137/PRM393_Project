import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showLogo;

  const AppHeader({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.showLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: showLogo
          ? Row(
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
          : (title != null ? Text(title!) : null),
      leading: leading,
      actions: actions,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
