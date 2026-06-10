import 'package:flutter/material.dart';

abstract final class AppRadius {
  AppRadius._();

  static const double none = 0;
  static const double sm = 12;
  static const double md = 18;
  static const double lg = 24;
  static const double pill = 999;

  static BorderRadius get small => BorderRadius.circular(sm);
  static BorderRadius get medium => BorderRadius.circular(md);
  static BorderRadius get large => BorderRadius.circular(lg);
  static BorderRadius get fullyRounded => BorderRadius.circular(pill);

  static const BorderRadius card = BorderRadius.all(Radius.circular(md));
  static const BorderRadius button = BorderRadius.all(Radius.circular(md));
  static const BorderRadius input = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius badge = BorderRadius.all(Radius.circular(pill));

  static const BorderRadius topSheet = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );
}
