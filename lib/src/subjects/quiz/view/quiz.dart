import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/single_item_skeleton.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/bloc/async_classroom_item_bloc.dart';
import 'package:akademi_al_mobile_app/src/subjects/quiz/bloc/quiz_bloc.dart';
import 'package:akademi_al_mobile_app/src/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tex/flutter_tex.dart';

class QuizModal extends StatefulWidget {
  final Lessons lesson;
  final String enrollmentId;
  final AsyncClassroomItemBloc parentBloc;
  final TeXViewRenderingEngine renderingEngine;
  final Function endLesson;

  const QuizModal(
      {Key key,
      this.lesson,
      this.enrollmentId,
      this.parentBloc,
      this.renderingEngine = const TeXViewRenderingEngine.katex(), this.endLesson})
      : super(key: key);

  @override
  _QuizModalState createState() => _QuizModalState();
}

class _QuizModalState extends State<QuizModal> {
  var numberOfLoaders = 0;
  var loaded = [];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
      if (state.lessons == null) {
        return SkeletonList();
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: BaseText(
              text: widget.lesson.name,
              weightType: FontWeight.w600,
              fontSize: 17.sp,
              textColor: Colors.black,
              letterSpacing: -0.4,
              lineHeight: 1.3,
            ),
            centerTitle: true,
            elevation: 2,
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
          ),
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              state.finishedQuiz != null && state.finishedQuiz
                  ? Padding(
                      padding:
                          EdgeInsets.only(top: 32.0.h, left: 20.w, right: 20.w),
                      child: Column(
                        children: [
                          Icon(
                            RemixIcons.trophy_line,
                            color: AntColors.blue6,
                            size: 40.sp,
                          ),
                          BaseText(
                            text: s.correct_answer_number(
                                _getCurrentNumberOfAnswers(state),
                                widget.lesson.lessonMetaInfo.length),
                            textColor: AntColors.gray8,
                            type: TextTypes.p1,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Divider(
                            height: 1,
                          )
                        ],
                      ),
                    )
                  : Container(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 108.h),
                  child: Container(
                    color: Colors.white,
                    child: state.lessons.lessonMetaInfo == null
                        ? SkeletonList()
                        : SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.lessons.lessonMetaInfo != null
                                  ? state.lessons.lessonMetaInfo.length
                                  : 0,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final question =
                                    state.lessons.lessonMetaInfo[index];
                                final error = state.errors?.firstWhere(
                                    (element) =>
                                        element.questionId == question.id,
                                    orElse: () => null);
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0.w, right: 20.w, top: 24.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      BaseText(
                                        text: s.question_number(index + 1),
                                        type: TextTypes.d2,
                                        textColor: AntColors.gray7,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 4.0.h),
                                          child: question.questionTitle
                                                  .contains("ql-formula")
                                              ? TeXView(
                                                  fonts: [interStyle],
                                                  renderingEngine:
                                                      widget.renderingEngine,
                                                  child: TeXViewDocument(
                                                      question.questionTitle,
                                                      style: TeXViewStyle(
                                                          fontStyle: TeXViewFontStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "inter",
                                                              fontWeight:
                                                                  TeXViewFontWeight
                                                                      .w400))))
                                              : Html(
                                                  data: question.questionTitle,
                                                  style: {
                                                      "html": Style(
                                                          fontFamily: "Inter",
                                                          fontSize:
                                                              FontSize(14.sp))
                                                    })),
                                      _getGridOrList(question, state),
                                      error != null
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10.0.h, bottom: 24.h),
                                              child: Card(
                                                color: AntColors.red1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0.sp),
                                                  side: BorderSide(
                                                    color: AntColors.red3,
                                                  ),
                                                ),
                                                child:
                                                    Column(children: <Widget>[
                                                  ListTile(
                                                    // dense: true,
                                                    visualDensity:
                                                        VisualDensity(
                                                            horizontal: 0.0,
                                                            vertical: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 16.0.w,
                                                            bottom: 12.0.h,
                                                            right: 16.0.w,
                                                            top: 12.0.h),
                                                    title: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  RemixIcons
                                                                      .close_circle_fill,
                                                                  color:
                                                                      AntColors
                                                                          .red6,
                                                                  size: 16.sp,
                                                                ),
                                                                SizedBox(
                                                                  width: 8.w,
                                                                ),
                                                                Flexible(
                                                                  child: Column(
                                                                    children: [
                                                                      BaseText(
                                                                        text: s
                                                                            .wrong_answer,
                                                                        type: TextTypes
                                                                            .d1,
                                                                        // overflow: TextOverflow.clip,
                                                                        textColor:
                                                                            AntColors.gray9,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            8.w,
                                                                      ),
                                                                      !error.errorMsg.contains(
                                                                              "ql-formula")
                                                                          ? Html(
                                                                              data: error.errorMsg,
                                                                              style: {
                                                                                  "html": Style(fontFamily: "Inter", fontSize: FontSize(14.sp))
                                                                                })
                                                                          : TeXView(
                                                                              renderingEngine: widget.renderingEngine,
                                                                              fonts: [
                                                                                interStyle
                                                                              ],
                                                                              child: TeXViewDocument(error.errorMsg, style: TeXViewStyle(contentColor: AntColors.gray8, backgroundColor: AntColors.red1, fontStyle: TeXViewFontStyle(fontSize: 14, fontFamily: "inter", fontWeight: TeXViewFontWeight.w400))),
                                                                            )
                                                                    ],
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            )
                                          : _getGroupValue(state, question.id)[
                                                          0] !=
                                                      null &&
                                                  state.finishedQuiz != null && state.finishedQuiz
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0.h,
                                                      bottom: 24.h),
                                                  child: Card(
                                                    color: AntColors.green1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0.sp),
                                                      side: BorderSide(
                                                        color: AntColors.green3,
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      visualDensity:
                                                          VisualDensity(
                                                              horizontal:
                                                                  0.0,
                                                              vertical:
                                                                  0),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left:
                                                                  16.0.w,
                                                              bottom:
                                                                  0.0.h,
                                                              right:
                                                                  16.0.w,
                                                              top: 0.0.h),
                                                      title: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  RemixIcons
                                                                      .checkbox_circle_fill,
                                                                  color: AntColors
                                                                      .green6,
                                                                  size: 16.sp,
                                                                ),
                                                                SizedBox(
                                                                  width: 8.w,
                                                                ),
                                                                BaseText(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  text: s
                                                                      .correct_answer,
                                                                  type:
                                                                      TextTypes
                                                                          .d1,
                                                                  textColor:
                                                                      AntColors
                                                                          .gray8,
                                                                )
                                                              ]),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              : Container()
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: _getFooter(s, state),
        );
      }
    });
  }

  _getGridOrList(Quiz question, QuizState state) {
    if (question.answers.any((element) => element.answerFile != null)) {
      return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24.h,
          crossAxisSpacing: 20.w,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: question.answers != null ? question.answers.length : 0,
        itemBuilder: (context, index) {
          final answer = question.answers[index];
          return GestureDetector(
            onTap: () {
              context
                  .read<QuizBloc>()
                  .add((ClickedAnswer(answer.id, question.id)));
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: _isSelected(state, question.id, answer.id)
                        ? AntColors.blue6
                        : AntColors.gray6),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: GridTile(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    answer.fileUrl != null
                        ? Container(
                            height: 89.h,
                            decoration: BoxDecoration(
                              image: answer.fileUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(answer.fileUrl),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: _isSelected(state, question.id, answer.id)
                                  ? AntColors.blue1
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: answer.fileUrl == null
                                ? Center(
                                    child: Icon(
                                      RemixIcons.image_line,
                                      size: 24.sp,
                                      color: AntColors.gray6,
                                    ),
                                  )
                                : null,
                          )
                        : Container(),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            question.questionType == "singleChoice"
                                ? Radio(
                                    value: answer.id,
                                    groupValue:
                                        _getGroupValue(state, question.id)[0],
                                    onChanged: (value) {
                                      context.read<QuizBloc>().add(
                                          (ClickedAnswer(
                                              answer.id, question.id)));
                                    },
                                  )
                                : Checkbox(
                                    value: _getGroupValue(state, question.id)
                                        .contains(answer.id),
                                    onChanged: (value) {
                                      context.read<QuizBloc>().add(
                                          (ClickedAnswer(
                                              answer.id, question.id)));
                                    },
                                  ),

                            Expanded(
                                child: answer.title.contains("ql-formula")
                                    ? TeXView(
                                        renderingEngine: widget.renderingEngine,
                                        fonts: [interStyle],
                                        onRenderFinished: (height) {
                                          setState(() {
                                            loaded = List.from(loaded)
                                              ..add(true);
                                          });
                                        },
                                        loadingWidgetBuilder: (context) {
                                          return Center(
                                              child: SingleItemSkeleton());
                                        },
                                        style: TeXViewStyle.fromCSS(
                                            "word-wrap: break-word; float: center;  padding: 10px; font-family:\"inter\""),
                                        child: TeXViewDocument(answer.title))
                                    : Html(data: answer.title, style: {
                                        "html": Style(
                                            fontFamily: "Inter",
                                            fontSize: FontSize(14.sp))
                                      })),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: question.answers != null ? question.answers.length : 0,
        itemBuilder: (context, index) {
          final answer = question.answers[index];
          return GestureDetector(
            onTap: () {
              context
                  .read<QuizBloc>()
                  .add((ClickedAnswer(answer.id, question.id)));
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  question.questionType == "singleChoice"
                      ? Radio(
                          value: answer.id,
                          groupValue: _getGroupValue(state, question.id)[0],
                          onChanged: (value) {
                            context
                                .read<QuizBloc>()
                                .add((ClickedAnswer(answer.id, question.id)));
                          },
                        )
                      : Checkbox(
                          value: _getGroupValue(state, question.id)
                              .contains(answer.id),
                          onChanged: (value) {
                            context
                                .read<QuizBloc>()
                                .add((ClickedAnswer(answer.id, question.id)));
                          }),
                  Expanded(
                      child: answer.title.contains("ql-formula")
                          ? TeXView(
                              fonts: [interStyle],
                              renderingEngine: widget.renderingEngine,
                              onRenderFinished: (height) {
                                setState(() {
                                  loaded = List.from(loaded)..add(true);
                                });
                              },
                              loadingWidgetBuilder: (context) {
                                return Center(child: SingleItemSkeleton());
                              },
                              child: TeXViewDocument(answer.title,
                                  style: TeXViewStyle(
                                      fontStyle: TeXViewFontStyle(
                                          fontSize: 14,
                                          fontFamily: "inter",
                                          fontWeight: TeXViewFontWeight.w400))))
                          : Html(data: answer.title, style: {
                              "html": Style(
                                  fontFamily: "Inter",
                                  fontSize: FontSize(14.sp))
                            })),
                ]),
          );
        },
      );
    }
  }

  _getGroupValue(QuizState state, String questionId) {
    final answerMetaInfo = state.answers?.answerMetaInfo?.firstWhere(
        (element) => element?.questionId == questionId,
        orElse: () => null);
    final list = answerMetaInfo != null
        ? answerMetaInfo.answers.map((e) => e.answerId).toList()
        : [null];
    return list.isNotEmpty ? list : [null];
  }

  _isSelected(QuizState state, String questionId, String answerId) {
    final answerMetaInfo = state.answers?.answerMetaInfo?.firstWhere(
        (element) => element?.questionId == questionId,
        orElse: () => null);
    return answerMetaInfo != null
        ? answerMetaInfo.answers.map((e) => e.answerId).contains(answerId)
        : false;
  }

  _getCurrentNumberOfAnswers(QuizState state) {
    if (state.answers != null && widget.lesson.lessonMetaInfo != null) {
      return widget.lesson.lessonMetaInfo.length -
          state.errors.length -
          (widget.lesson.lessonMetaInfo.length -
              state.answers.answerMetaInfo.length);
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    numberOfLoaders = widget.lesson.lessonMetaInfo
        .expand((element) => element.answers)
        .length;
    context
        .read<QuizBloc>()
        .add((LoadQuiz(widget.lesson, widget.enrollmentId)));
  }

  _getFooter(S s, QuizState state) {
    return Container(
      constraints: BoxConstraints(minHeight: 0, maxHeight: 108.h),
      decoration: BoxDecoration(color: AntColors.blue1, boxShadow: [
        BoxShadow(
          color: AntColors.boxShadow,
          spreadRadius: 0,
          blurRadius: 4,
          offset: Offset(0, -2),
        )
      ]),
      child: state.finishedQuiz != null && state.finishedQuiz
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MainButton(
                      text: s.close,
                      size: ButtonSize.Medium,
                      width: 158.w,
                      height: 52.h,
                      onPress: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    MainButton(
                      ghost: true,
                      text: s.redo_quiz,
                      size: ButtonSize.Medium,
                      width: 158.w,
                      height: 52.h,
                      onPress: () {
                        // _buttonAction(state);
                        context.read<QuizBloc>().add(RedoQuiz());
                      },
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: MainButton(
                  disabled: state.answers.answerMetaInfo == null ||
                      state.answers.answerMetaInfo.length == 0,
                  text: s.check_answers,
                  size: ButtonSize.Medium,
                  width: 335.w,
                  height: 52.h,
                  onPress: () {
                    context.read<QuizBloc>().add(CheckAnswers());
                    if(widget.endLesson == null) {
                      widget.parentBloc.add(EndLesson(state.lessons.id));
                    } else {
                      widget.endLesson();
                    }
                  },
                ),
              ),
            ),
    );
  }
}
