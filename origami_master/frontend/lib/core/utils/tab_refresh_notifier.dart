import 'package:flutter/foundation.dart';

/// Global tab refresh notifiers.
/// Increment the notifier to trigger a reload on the corresponding tab.
final homeTabRefresh = ValueNotifier<int>(0);
final galleryTabRefresh = ValueNotifier<int>(0);
final profileTabRefresh = ValueNotifier<int>(0);
