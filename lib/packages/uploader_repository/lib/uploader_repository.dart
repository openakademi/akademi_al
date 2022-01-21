import 'dart:io';

import 'package:akademi_al_mobile_app/extentions/file_extensions.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart' as FileEntity;
import 'package:path/path.dart' as p;

const path = "/s3/long-expiration";

enum S3ActionType {
  DOWNLOAD,
  UPLOAD,
  // DELETE
}

class UploaderRepository extends ApiServiceData {
  UploaderRepository(AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  getS3UrlForAction(String fileName, S3ActionType s3actionType) async {
    var type;
    if (s3actionType.index == S3ActionType.UPLOAD.index) {
      type = "putObject";
    } else if (s3actionType.index == S3ActionType.DOWNLOAD.index) {
      type = "getObject";
    }

    return this.getRequest("$path/${Uri.encodeComponent(fileName)}/$type");
  }

  uploadFile(File file, String path) async {
    Response response;
    try {
      response = await this.dio.put(path,
          data: file.openRead(),
          options: Options( contentType: lookupMimeType(file.path),
            headers: {
              "Content-Length": file.lengthSync(),
            },));
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return List<dynamic>();
        } else {
          return response.data;
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      print(error.toString());
      throw ConnectionException();
    }
  }


  Stream<dynamic> downloadFile(String userId, FileEntity.File file, Function onProgress, String pathToSave) async* {

      var s3FilePath = await getS3UrlForAction(
          "${file.filePath}/${file.name}",
          S3ActionType.DOWNLOAD);
      // if(Platform.isAndroid) {
      //   try {
      //     CancelToken cancelToken = CancelToken();
      //     await dio.download(s3FilePath,
      //         pathToSave,
      //         onReceiveProgress: (receivedBytes, totalBytes) {
      //           onProgress(
      //               ((receivedBytes / totalBytes) * 100).toInt()
      //           );
      //         },
      //         cancelToken: cancelToken
      //     );
      //     yield cancelToken;
      //   } catch (e) {
      //     print(e);
      //   }
      // } else {
        var path;
        if(Platform.isAndroid) {
          path = await ExtStorage.getExternalStoragePublicDirectory('${ExtStorage.DIRECTORY_DOWNLOADS}/$userId');
        } else {
          path = (await getApplicationDocumentsDirectory()).uri.path+ '/$userId';
        }
        // final pathIos = (await getApplicationDocumentsDirectory()).path;
      if(Platform.isAndroid) {
        final fileName = file.id + p.extension(file.name);
        final taskId = await FlutterDownloader.enqueue(
            url: s3FilePath,
            savedDir: "$path",
            fileName: fileName,
            showNotification: false,
            openFileFromNotification: false
        );
        yield taskId;
      } else {
        final fileName = file.id + p.extension(file.name);
        print("path $path");
        final taskId = await FlutterDownloader.enqueue(
            url: s3FilePath,
            fileName: fileName,
            savedDir: path,
            showNotification: true,
            openFileFromNotification: true
        );
        yield taskId;
      }
      // }
  }
}
