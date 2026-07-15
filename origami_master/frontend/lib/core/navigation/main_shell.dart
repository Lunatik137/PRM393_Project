import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/tab_refresh_notifier.dart';
import '../widgets/app_bottom_navigation.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
    // Trigger refresh for the target tab
    switch (index) {
      case 0:
        homeTabRefresh.value++;
      case 2:
        galleryTabRefresh.value++;
      case 3:
        profileTabRefresh.value++;
    }
  }
}
