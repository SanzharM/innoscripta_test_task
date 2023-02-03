import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstraints {
  static final padding = 20.w;
  static final spaceBetween = 10.w;

  static const radius = 12.0;
  static const borderRadius = BorderRadius.all(Radius.circular(radius));
  static const borderRadiusTLR = BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );
}
