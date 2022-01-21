// ignore: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonSize { Zero, Small, Medium, Big }

// ignore: non_constant_identifier_names
final ButtonSizeToEdgeInsets = {
  ButtonSize.Zero: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 4.0.w),
  ButtonSize.Small: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 24.0.w),
  ButtonSize.Medium: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 24.0.w),
  ButtonSize.Big: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 24.0.w),
};
