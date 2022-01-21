import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloader extends StatefulWidget {
  final Widget child;
  final File file;
  final bool openFile;
  final Function onFinish;
  final String userId;

  const Downloader(
      {Key key, this.child, this.file, this.openFile = true, this.onFinish, this.userId})
      : super(key: key);

  @override
  _DownloaderState createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader> {
  String result = "";
  int progress = 0;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
        onTap: () {
          _showDownloadAlertDialog(context, s);
        },
        child: widget.child);
  }

  _showDownloadAlertDialog(BuildContext context, S s) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _DownloaderDialog(
            file: widget.file,
            openFile: widget.openFile,
            userId: widget.userId,
            onFinish: (id) {
              Navigator.of(context).pop();
              widget.onFinish(id);
            },
          );
        });
  }
}

class _DownloaderDialog extends StatefulWidget {
  final File file;
  final bool openFile;
  final Function onFinish;
  final String userId;

  const _DownloaderDialog({Key key, this.file, this.openFile, this.onFinish, this.userId})
      : super(key: key);

  @override
  __DownloaderDialogState createState() =>
      __DownloaderDialogState(file, openFile);
}

class __DownloaderDialogState extends State<_DownloaderDialog> {
  int progress = 0;
  ReceivePort _port = ReceivePort();
  final File file;
  final bool openFile;
  String downloadUrl;
  dynamic cancelToken;

  __DownloaderDialogState(this.file, this.openFile);

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress1 = data[2];
      setState(() {
        progress = progress1;
      });
      if (status.toString() == "DownloadTaskStatus(3)" && progress1 == 100 &&id!=null) {
        if (widget.openFile) {
          if(Platform.isAndroid) {
            FlutterDownloader.open(taskId: id);
          } else {
            _openIosFile(id);
          }
        }
        if (widget.onFinish != null) {
          widget.onFinish(downloadUrl);
        }
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
    _startDownload();
  }

  _openIosFile(id) async {
    String query = "SELECT * FROM task WHERE taskId=$id";
    final tasks = await FlutterDownloader.loadTasks();
    final task = tasks.firstWhere((task) => task.taskId == id);
    final path = task.savedDir.replaceAll("/(null)", "");
    final filePath = path + '/' + task.filename;
    OpenFile.open(filePath);
    print("tasks $task");
    // FlutterDownloader.open(taskId: tasks[1].taskId);
  }
  _startDownload() async {
    UploaderRepository uploaderRepository = UploaderRepository(
        RepositoryProvider.of<AuthenticationRepository>(context));
    Permission permission1 = Permission.storage;

    String dirloc = "";
    if (Platform.isAndroid) {
      dirloc = await ExtStorage.getExternalStoragePublicDirectory('${ExtStorage.DIRECTORY_DOWNLOADS}/${widget.userId}');
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path + '/${widget.userId}';
    }
    FileUtils.mkdir([dirloc]);
    final Uri _emailLaunchUri = Uri(
      scheme: 'file',
      path: '$dirloc/${file.name}',
    );

    setState(() {
      downloadUrl = '$dirloc/${file.name}';
    });
    if (await permission1.request().isGranted) {
      uploaderRepository.downloadFile(widget.userId, file, (progressPercent) async {
        setState(() {
          progress = progressPercent;
        });
        if (progressPercent == 100) {
          if (widget.onFinish != null) {
            widget.onFinish(downloadUrl);
            Navigator.of(context).pop();
          }
          try {
            if (widget.openFile) {
              OpenFile.open(_emailLaunchUri.path);
            }
          } catch (e) {
            print("e $e");
          }
          Navigator.of(context).pop();
        }
      }, _emailLaunchUri.path).listen((event) {
        setState(() {
          cancelToken = event;
        });
      });
    } else {}
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return CupertinoAlertDialog(
      title: BaseText(
        text: s.it_is_downloading,
        weightType: FontWeight.w600,
      ),
      actions: [
        MainTextButton(
          text: s.cancel,
          onPress: () {
            if (cancelToken is String) {
              FlutterDownloader.cancel(taskId: cancelToken);
            } else if (cancelToken is CancelToken) {
              cancelToken.cancel();
            }
            Navigator.of(context).pop();
          },
        )
      ],
      content: progress != 100
          ? Column(
              children: [
                SizedBox(
                  height: 24.h,
                ),
                LinearProgressIndicator(),
              ],
            )
          : Container(),
    );
  }
}
