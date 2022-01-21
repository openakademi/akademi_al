import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/onboarding_1/onboarding_1.png",
        fit: BoxFit.cover,
        width: 335.w,
        height: 240.h,
      ),
    );
  }
}
