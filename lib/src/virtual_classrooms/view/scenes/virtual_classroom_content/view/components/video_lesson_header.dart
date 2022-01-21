import 'dart:io';

import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:chewie/chewie.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:path/path.dart' as p;

class VideoLessonHeader extends StatefulWidget {
  final Lessons lesson;
  final bool playOffline;

  const VideoLessonHeader({Key key, this.lesson, this.playOffline}) : super(key: key);

  @override
  _VideoLessonHeaderState createState() => _VideoLessonHeaderState();
}

class _VideoLessonHeaderState extends State<VideoLessonHeader> {
  YoutubePlayerController _youTubeController;
  VideoPlayerController _controller;
  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    if (widget.lesson.videoUrl != null && widget.lesson.videoUrl.isNotEmpty) {
      // We need to dispose controller because we have conflict when we change from
      // youtube video to uploaded video
      if(_controller != null) {
        _controller.dispose();
      }
      if (_youTubeController == null) {
        _createYouTubeController();
      } else {
        final id = YoutubePlayerController.convertUrlToId(
          widget.lesson.videoUrl,
        );
        _youTubeController.load(id);
      }
      return SafeArea(
          child: YoutubePlayerIFrame(
        controller: _youTubeController,
      ));
    } else {
      return FutureBuilder<bool>(
        future: _loadVideoFromS3(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _controller.value.initialized
                ? SafeArea(
                  child: Container(
                      height: 209.h,
                      width: double.infinity,
                      child: Chewie(
                        controller: chewieController,
                      ),
                    ),
                )
                : Container();
          } else {
            return Container(
              height: 209.h,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.lesson.videoUrl != null && widget.lesson.videoUrl.isNotEmpty) {
      _createYouTubeController();
    }
  }


  @override
  void dispose() {
    if(_controller != null) {
      _controller.dispose();
    }
    if(chewieController != null) {
      chewieController.dispose();
    }
    super.dispose();
  }

  Future<bool> _loadVideoFromS3() async {
    if(widget.lesson.localVideoUrl != null && widget.playOffline) {

      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc =  await ExtStorage.getExternalStoragePublicDirectory('${ExtStorage.DIRECTORY_DOWNLOADS}/${widget.lesson.userId}');
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path + '/${widget.lesson.userId}';
      }
      final fileName = widget.lesson.file.id + p.extension(widget.lesson.file.name);

      final Uri _emailLaunchUri = Uri(
        scheme: 'file',
        path: Platform.isAndroid ? "$dirloc/$fileName" : "$dirloc/$fileName",
      );
      File file = File(_emailLaunchUri.path);
      _controller = VideoPlayerController.file(
        file,
      );
      await _controller.initialize();
      chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
      );

      return true;
    }
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    UploaderRepository uploaderRepository =
        new UploaderRepository(authenticationRepository);
    var s3FilePath = await uploaderRepository.getS3UrlForAction(
        "${widget.lesson.file.filePath}/${widget.lesson.file.name}",
        S3ActionType.DOWNLOAD);
    _controller = VideoPlayerController.network(
      s3FilePath,
    );
    await _controller.initialize();
    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
    );

    return true;
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
          showVideoAnnotations: false),
    );
    _youTubeController
      ..listen((value) {
        if (value.isReady && !value.hasPlayed) {
          _youTubeController
            ..hidePauseOverlay()
            ..hideTopMenu();
        }
      });
    _youTubeController.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    };
    _youTubeController.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    };
  }
}
