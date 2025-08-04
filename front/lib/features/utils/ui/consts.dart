import 'package:flutter/cupertino.dart';

class StadiumBorderRadius extends BorderRadius {
  static const _maxRadiusWithTechBorderLimit = 100000000.0;

  const StadiumBorderRadius()
      : super.all(
          const Radius.circular(_maxRadiusWithTechBorderLimit),
        );
}
