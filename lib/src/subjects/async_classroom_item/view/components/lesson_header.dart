import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/quiz_answers_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/subjects/quiz/models/models.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/view/components/video_lesson_header.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/view/component/presentation_lesson_header.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../lesson_item.dart';

class LessonHeader extends StatefulWidget {
  final Lessons lesson;
  final String imageUrl;
  final QuizAnswers quizAnswers;

  const LessonHeader({Key key, this.lesson, this.imageUrl, this.quizAnswers})
      : super(key: key);

  @override
  _LessonHeaderState createState() => _LessonHeaderState();
}

class _LessonHeaderState extends State<LessonHeader> {
  YoutubePlayerController _youTubeController;
  bool showYouTubeFullScreenButton = false;
  var correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    if (widget.lesson.videoUrl != null && widget.lesson.videoUrl.isNotEmpty) {
      _createYouTubeController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    if (widget.quizAnswers != null && widget.lesson.lessonMetaInfo != null) {
      Function eq = const DeepCollectionEquality.unordered().equals;
      List<QuizErrors> errors = [];

      widget.quizAnswers.answerMetaInfo?.forEach((element) {
        var answers = element.answers.map((e) => e.answerId).toList();
        var question = widget.lesson.lessonMetaInfo.firstWhere(
            (element1) => element1.id == element.questionId,
            orElse: () => null);
        if(question != null) {
          final correctAnswer =
          question?.answers?.where((element) => element.correct)?.toList();
          if (question?.questionType == "singleChoice") {
            final correctAnswerValue =
            correctAnswer.length == 1 ? correctAnswer[0] : null;
            final answerValue = answers.length == 1 ? answers[0] : null;
            if (correctAnswerValue.id != answerValue) {
              final quizError = QuizErrors(
                  questionId: element.questionId,
                  errorMsg: correctAnswerValue.title);
              errors.add(quizError);
            }
          } else {
            if (!eq(correctAnswer?.map((e) => e.id).toList(), answers)) {
              final quizError = QuizErrors(
                  questionId: element.questionId,
                  errorMsg: correctAnswer.map((e) => e.title).join(" "));
              errors.add(quizError);
            }
          }
        }
      });
      correctAnswers = widget.lesson.lessonMetaInfo.length -
          errors.length -
          (widget.lesson.lessonMetaInfo.length -
              widget.quizAnswers.answerMetaInfo.length);
    }
    if (widget.lesson.videoUrl != null && widget.lesson.videoUrl.isNotEmpty) {
      if( _youTubeController == null) {
        _createYouTubeController();
      } else {
        final id = YoutubePlayerController.convertUrlToId(
          widget.lesson.videoUrl,
        );
        _youTubeController.load(id);
      }
    }
    if (widget.lesson.lessonType == "VIDEO") {
      return VideoLessonHeader(
        lesson: widget.lesson,
        playOffline: false,
      );
    } else if (widget.lesson.lessonType == "QUIZ") {
      return Container(
        height: 209.h,
        decoration: BoxDecoration(
          image: widget.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                )
              : null,
          gradient: LinearGradient(
              colors: [AntColors.blue8, AntColors.blue6],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.quizAnswers == null
              ? [
                  TypeItem(
                    itemType: "QUIZ",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
                    child: BaseText(
                      text: widget.lesson.name,
                      textColor: Colors.white,
                      type: TextTypes.h6,
                    ),
                  )
                ]
              : [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(RemixIcons.trophy_line,
                          size: 24.sp, color: Colors.white),
                      SizedBox(
                        width: 8.w,
                      ),
                      BaseText(
                        text: s.results,
                        textColor: Colors.white,
                        type: TextTypes.p1,
                      )
                    ],
                  ),
                  BaseText(
                    text: s.correct_answer_number(
                        correctAnswers, widget.lesson.lessonMetaInfo.length),
                    textColor: Colors.white,
                    type: TextTypes.p1,
                  )
                ],
        ),
      );
    } else if (widget.lesson.lessonType == "PDF") {
      return PresentationLessonHeader(
        lesson: widget.lesson,
      );
    }else {
      return Center(
        child: BaseText(
          text: widget.lesson.name,
        ),
      );
    }
  }

  _createYouTubeController() {
    final id = YoutubePlayerController.convertUrlToId(
      widget.lesson.videoUrl,
    );
    _youTubeController = YoutubePlayerController(
      initialVideoId: id,
      params: YoutubePlayerParams(
          showFullscreenButton: true,
          playsInline: true,
          showVideoAnnotations: false
      ),
    );
    _youTubeController
      ..listen((value) {
        if (value.isReady && !value.hasPlayed) {
          _youTubeController
            ..hidePauseOverlay()
            ..hideTopMenu();
        }
      });
    // _youTubeController.hideTopMenu();
    _youTubeController.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ]);
    };
    _youTubeController.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    };
  }
  @override
  void dispose() {
    super.dispose();
  }
}
