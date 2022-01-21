

import 'dart:developer';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:dio/dio.dart';

const relative_url = "/subjects";

class AsyncSubjectApiProvider extends ApiServiceData {
  AsyncSubjectApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  Future<List<AsyncSubject>> getWithAsync() async {
    Response response;
    try {
      response = await dio.get("${Urls.apiVersion}$relative_url/with-async",
          options: Options(
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,));
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return List<dynamic>();
        } else {
          return response.data.map<AsyncSubject>((element) => AsyncSubject.fromJson(element)).toList();
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      // print(error.toString());
      throw error;
    }
  }

  Future<List<AsyncSubject>> getSyncAsyncSubjects(DateTime lastUpdateDate) async {
    final String url ="$relative_url/sync/${lastUpdateDate.toString()}";
    List<dynamic> response = await getRequest(url);
    final enrollments = response.map((e) => AsyncSubject.fromJson(e)).toList();
    return enrollments;
  }

}