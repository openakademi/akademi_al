import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationItem extends StatelessWidget {
  final String text;
  final IconData remixIcon;
  final NavigationItemKey navigationKey;
  final String classroomId;
  final double height;
  final EnrollmentEntity enrollment;
  final Function onTap;

  const NavigationItem(
      {Key key,
      this.text,
      this.remixIcon,
      this.navigationKey,
      this.classroomId = "",
      this.height = 52,
      this.enrollment,
        this.onTap
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
        child: GestureDetector(
          onTap: () async {
            var connectivityResult = await (Connectivity().checkConnectivity());
            var enrollments;
            if (connectivityResult == ConnectivityResult.none) {
            } else {
              if(onTap != null) {
                onTap();
              } else {
                context
                    .read<HomeBloc>()
                    .add(NavigationItemChanged(
                    navigationKey, classroomId, enrollment));
              }
            }
          },
          child:
              BlocBuilder<HomeBloc, HomeState>(builder: (buildContext, state) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: _isSelected(state) ? AntColors.blue1 : Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: this.classroomId.isNotEmpty
                            ? Container(
                                width: 32.sp,
                                height: 32.sp,
                                decoration: new BoxDecoration(
                                  color: AntColors.gray2,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  remixIcon,
                                  size: 18.sp,
                                  color: AntColors.blue6,
                                  textDirection: TextDirection.ltr,
                                ),
                              )
                            : Icon(
                                remixIcon,
                                size: 18.sp,
                                color: _isSelected(state)
                                    ? AntColors.blue6
                                    : AntColors.gray8,
                                textDirection: TextDirection.ltr,
                              ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: BaseText(
                            padding: EdgeInsets.only(left: 16.w),
                            text: text,
                            type: TextTypes.p2,
                            textColor: _isSelected(state)
                                ? AntColors.blue6
                                : AntColors.gray8,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _isSelected(HomeState state) {
    return state.currentNavigationItem.index ==
            NavigationItemKey.VIRTUAL_CLASSROOM.index
        ? this.classroomId != null && state.selectedVirtualClassroomId == this.classroomId
        : state.currentNavigationItem.index == navigationKey.index;
  }
}
