import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SixthOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    context.bloc<OnboardingBloc>().add(LoadGradeSubjects());

    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (buildContext, state) {
      if (state.subjects == null) {
        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ));
      } else {
        return SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: AntColors.gray2,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.0.w, right: 20.0.w, top: 32.h, bottom: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0.h),
                          child: BaseText(
                            text: s.fifth_onboarding_page_title,
                            type: TextTypes.h3,
                            lineHeight: 1.3,
                            textColor: AntColors.gray9,
                          ),
                        ),
                        BaseText(
                          text: s.subjects_description,
                          textColor: AntColors.gray8,
                          lineHeight: 1.5,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.h),
                child: GestureDetector(
                  onTap: () {
                    context.read<OnboardingBloc>().add(CheckAllSubjects());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24.0.sp,
                        height: 24.0.sp,
                        decoration: new BoxDecoration(
                          color: state.allSubjects != null && state.allSubjects
                              ? AntColors.blue6
                              : Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                          border: Border.all(
                            color:
                                state.allSubjects != null && state.allSubjects
                                    ? AntColors.blue6
                                    : AntColors.gray5,
                          ),
                        ),
                        child: state.allSubjects != null && state.allSubjects
                            ? Icon(
                                RemixIcons.check_line,
                                color: Colors.white,
                                size: 16.sp,
                              )
                            : null,
                      ),
                      BaseText(
                        padding: EdgeInsets.only(left: 8.0.w),
                        text: s.all_subjects,
                        type: TextTypes.p1,
                        textColor: AntColors.gray8,
                      ),
                    ],
                  ),
                )),
            Divider(),
            Padding(
                padding:
                    EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.h),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 20.w,
                  childAspectRatio: 1.6,
                  children: state.subjects.map((element) {
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0.sp),
                          side: BorderSide(
                            color: state.classrooms != null &&
                                    state.classrooms
                                        .contains(element.classRoomId)
                                ? AntColors.blue6
                                : AntColors.gray3,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            context
                                .read<OnboardingBloc>()
                                .add(CheckSubjects(element.classRoomId));
                          },
                          tileColor: state.classrooms != null &&
                                  state.classrooms.contains(element.classRoomId)
                              ? AntColors.blue1
                              : Colors.white,
                          title: Stack(children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BaseText(
                                      text: element.subjectName,
                                      textColor: AntColors.gray8,
                                      fontSize: 16.sp,
                                      lineHeight: 1.5,
                                      overflow: TextOverflow.ellipsis)
                                ]),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0.h),
                                child: Container(
                                  width: 16.0.sp,
                                  height: 16.0.sp,
                                  decoration: new BoxDecoration(
                                    color: state.classrooms != null &&
                                            state.classrooms
                                                .contains(element.classRoomId)
                                        ? AntColors.blue6
                                        : Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.sp)),
                                    border: Border.all(
                                      color: state.classrooms != null &&
                                              state.classrooms
                                                  .contains(element.classRoomId)
                                          ? AntColors.blue6
                                          : AntColors.gray5,
                                    ),
                                  ),
                                  child: state.classrooms != null &&
                                          state.classrooms
                                              .contains(element.classRoomId)
                                      ? Icon(
                                          RemixIcons.check_line,
                                          color: Colors.white,
                                          size: 14.sp,
                                        )
                                      : null,
                                ),
                              ),
                            )
                          ]),
                        ));
                  }).toList(),
                )),
          ],
        ));
      }
      ;
    });
    ;
  }
}
