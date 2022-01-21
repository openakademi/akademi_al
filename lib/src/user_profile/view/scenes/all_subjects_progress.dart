import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_courses_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_charts/multi_charts.dart';

class AllSubjectsProgress extends StatelessWidget {
  static Route route(List<AsyncCoursesProgress> asyncCoursesProgress) {
    return MaterialPageRoute<void>(
        builder: (_) => AllSubjectsProgress(
              asyncCoursesProgress: asyncCoursesProgress,
            ));
  }

  final List<AsyncCoursesProgress> asyncCoursesProgress;

  const AllSubjectsProgress({Key key, this.asyncCoursesProgress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    final asyncList = asyncCoursesProgress;
    var list = asyncList;
    if (asyncList.length > 8) {
      list = asyncList.sublist(0, 8);
    }
    var parser = EmojiParser();

    var firstMaxScore = -1.0;
    var secondMaxScore = -1.0;
    var thirdMaxScore = -1.0;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              RemixIcons.arrow_left_line,
              color: AntColors.blue6,
              size: 24.sp,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        title: BaseText(
          text: s.subjects_performance_title,
          type: TextTypes.p1,
          weightType: FontWeight.w600,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: RadarChart(
                values: list.map((e) => e.calculatedScore).toList(),
                labels: list
                    .map((e) =>
                        "${e.name} ${e.calculatedScore.toStringAsFixed(1)}")
                    .toList(),
                maxValue: 5,
                fillColor: AntColors.blue6,
                strokeColor: Color.fromRGBO(32, 99, 227, 0.3),
                labelColor: AntColors.gray7,
                chartRadiusFactor: 0.7,
                maxLinesForLabels: 3),
          ),
          SizedBox(
            height: 24.h,
          ),
          Divider(
            height: 1,
            indent: 20.w,
            endIndent: 20.w,
          ),
          SizedBox(
            height: 32.h,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: asyncCoursesProgress.length,
                itemBuilder: (context, index) {
                  Emoji icon;
                  final item = asyncCoursesProgress[index];
                  if(item.calculatedScore >= firstMaxScore) {
                    firstMaxScore = item.calculatedScore;
                    icon =parser.get("rocket");
                  } else if (item.calculatedScore >= secondMaxScore) {
                    secondMaxScore = item.calculatedScore;
                    icon =parser.get("fire");

                  } else if (item.calculatedScore >= thirdMaxScore) {
                    thirdMaxScore = item.calculatedScore;
                    icon =parser.get("+1");
                  }

                  return Container(
                    height: 70.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Icon(
                          RemixIcons.MapForm[item.icon.replaceAll("-", "_")],
                          size: 32.sp,
                          color: AntColors.blue6,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseText(
                                text: item.name,
                                type: TextTypes.d1,
                                weightType: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        RemixIcons.play_fill,
                                        color: AntColors.gray6,
                                        size: 14.sp,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      BaseText(
                                        text: "${item.videos}",
                                        type: TextTypes.d1,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        RemixIcons.question_fill,
                                        color: AntColors.gray6,
                                        size: 14.sp,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      BaseText(
                                        text: "${item.quizes}",
                                        type: TextTypes.d1,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        RemixIcons.slideshow_2_fill,
                                        color: AntColors.gray6,
                                        size: 14.sp,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      BaseText(
                                        text: "${item.materials}",
                                        type: TextTypes.d1,
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            icon != null ? BaseText(
                              text: icon.code,
                            ): Container(),
                            SizedBox(
                              width: 4.w,
                            ),
                            BaseText(
                              text: "${item.calculatedScore.toStringAsFixed(1)}",
                              weightType: FontWeight.w600,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            BaseText(
                              text: "(${item.lessons + item.quizes})",
                              textColor: AntColors.gray7,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
