import 'dart:ui';

import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/downloader/downloader.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/single_item_skeleton.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonDetails extends StatefulWidget {
  final Lessons lesson;

  const LessonDetails({Key key, this.lesson}) : super(key: key);

  @override
  _LessonDetailsState createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  TeXViewRenderingEngine renderingEngine;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.lesson?.description == null &&
              widget.lesson.lessonSections.length <= 0 ?
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h,),
              child: Center(
                child: BaseText(
                  text: s.no_details,
                  type: TextTypes.d1,
                  textColor: AntColors.gray7,
                ),
              ),
            ),
          ) :
          widget.lesson?.description != null
              ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: BaseText(
              text: s.description,
              type: TextTypes.d1,
              textColor: AntColors.gray7,
            ),
          )
              : Container(),
          widget.lesson?.description != null
              ? Flexible(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: widget.lesson.description.contains("ql-formula")
                  ? TeXView(
                fonts: [interStyle],
                loadingWidgetBuilder: (context) {
                  return SingleItemSkeleton();
                },
                renderingEngine: renderingEngine,
                child: TeXViewDocument(widget.lesson.description,
                    style: TeXViewStyle(
                        fontStyle: TeXViewFontStyle(
                            fontSize: 14,
                            fontFamily: "inter",
                            fontWeight: TeXViewFontWeight.w400))),
              )
                  : Html(
                  data: widget.lesson.description,
                  shrinkWrap: true,
                  style: {
                    "html": Style(
                        fontFamily: "inter",
                        fontSize: FontSize(14.sp),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.zero)
                  }),
            ),
          )
              : Container(),
          widget.lesson?.lessonSections != null &&
              widget.lesson.lessonSections.length > 0
              ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: BaseText(
              text: s.materials,
              type: TextTypes.d1,
              textColor: AntColors.gray7,
            ),
          )
              : Container(),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: widget.lesson?.lessonSections != null
                ? widget.lesson.lessonSections.length
                : 0,
            itemBuilder: (context, index) {
              final lessonSection = widget.lesson?.lessonSections[index];
              return lessonSection.file == null
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0.w),
                    child: lessonSection.file == null
                        ? Icon(
                      RemixIcons.link_m,
                      size: 16.sp,
                      color: AntColors.gray6,
                    )
                        : Icon(
                      RemixIcons.file_text_line,
                      size: 16.sp,
                      color: AntColors.gray6,
                    ),
                  ),
                  MainTextButton(
                    customText: Align(
                      child: BaseText(
                        align: TextAlign.left,
                        padding: EdgeInsets.zero,
                        text: lessonSection.name,
                        textColor: AntColors.blue6,
                        type: TextTypes.d1,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    onPress: () async {
                      if (await canLaunch(lessonSection.url)) {
                        await launch(lessonSection.url);
                      } else {
                        throw "Couldn't launch URL";
                      }
                    },
                  ),
                ],
              )
                  : Downloader(
                file: lessonSection.file,
                openFile: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0.w),
                      child: lessonSection.file == null
                          ? Icon(
                        RemixIcons.link_m,
                        size: 16.sp,
                        color: AntColors.gray6,
                      )
                          : Icon(
                        RemixIcons.file_text_line,
                        size: 16.sp,
                        color: AntColors.gray6,
                      ),
                    ),
                    MainTextButton(
                      customText: Align(
                        child: BaseText(
                          align: TextAlign.left,
                          padding: EdgeInsets.zero,
                          text: lessonSection.name,
                          textColor: AntColors.blue6,
                          type: TextTypes.d1,
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      // onPress: () async {
                      //   if (lessonSection.file != null) {
                      //
                      //   } else {
                      //     if (await canLaunch(lessonSection.url)) {
                      //       await launch(lessonSection.url);
                      //     } else {
                      //       throw "Couldn't launch URL";
                      //     }
                      //   }
                      // },
                    ),
                  ],
                ),
                onFinish: () {},
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.renderingEngine = const TeXViewRenderingEngine.katex();
  }
}
