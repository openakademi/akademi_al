import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingTracker extends StatelessWidget {
  final int index;

  const OnboardingTracker({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 18.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.0.h),
            child: BaseText(
              type: TextTypes.d1,
              text: s.onboarding_tracker(index),
              textColor: AntColors.gray7,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 1.0.w),
                child: Container(
                  width: 12.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      color: index >= 1 ? AntColors.blue6 :AntColors.gray4,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1.0),
                          bottomLeft: Radius.circular(1.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.0.w),
                child: Container(
                  width: 12.w,
                  height: 4.h,
                  color:index >= 2 ? AntColors.blue6 :AntColors.gray4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.0.w),
                child: Container(
                  width: 12.w,
                  height: 4.h,
                  color:index >= 3 ? AntColors.blue6 :AntColors.gray4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.0.w),
                child: Container(
                  width: 12.w,
                  height: 4.h,
                  color:index >= 4 ? AntColors.blue6 :AntColors.gray4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.0.w),
                child: Container(
                  width: 12.w,
                  height: 4.h,
                  color: index >= 5 ? AntColors.blue6 :AntColors.gray4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.0.w),
                child: Container(
                  width: 12.w,
                  height: 4.h,
                  color: index >= 6 ? AntColors.blue6 :AntColors.gray4,
                ),
              ),
              Container(
                width: 12.w,
                height: 4.h,
                decoration: BoxDecoration(
                    color: index >= 7 ? AntColors.blue6 :AntColors.gray4,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(1.0),
                        bottomRight: Radius.circular(1.0))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
