
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:dio/dio.dart';

import 'config/config.dart';
import 'exceptions/exceptions.dart';

class ApiServiceData {
  ApiServiceData(this.authenticationRepository)
      : dio = new Dio(new BaseOptions(
          baseUrl: Urls.baseUrl,
          receiveTimeout: 10000,
        ));

  final Dio dio;
  final AuthenticationRepository authenticationRepository;

  Future<dynamic> getRequest(String path) async {
    Response response;
    final token = await authenticationRepository.getToken();
    try {
      response = await dio.get("${Urls.apiVersion}$path",
          options: Options(
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
              headers: {
                "Authorization": "Bearer $token",
                "BrowserBaseURL": Urls.browserBaseUrl,
                "ClientId": Urls.clientId
              }));
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return List<dynamic>();
        } else {
          return response.data;
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        if(statusCode == 409) {
          return response;
        }
        // throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      if(error is DioError) {
        print("${error.message}");
        print("${error.response}");
      }
      print(error.toString());
      throw ConnectionException();
    }
  }

  Future<dynamic> deleteRequest(String path) async {
    Response response;
    final token = await authenticationRepository.getToken();
    try {
      response = await dio.delete("${Urls.apiVersion}$path",
          options: Options(
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
              headers: {
                "Authorization": "Bearer $token",
                "BrowserBaseURL": Urls.browserBaseUrl,
                "ClientId": Urls.clientId
              }));
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return List<dynamic>();
        } else {
          return response.data;
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        if(statusCode == 409) {
          return response;
        }
        // throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      if(error is DioError) {
        print("${error.message}");
        print("${error.response}");
      }
      print(error.toString());
      throw ConnectionException();
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> data) async {
    Response response;
    try {
      final token = await authenticationRepository.getToken();

      response = await dio.post("${Urls.apiVersion}$path",
          data: data,
          options: Options(contentType: Headers.jsonContentType, headers: {
            "Authorization": "Bearer $token",
            "BrowserBaseURL": Urls.browserBaseUrl,
            "ClientId": Urls.clientId
          }));
      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return [];
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
      if(error is DioError) {
        print(error.response);
        print(error);
        print(error.type);
        print(error.message);
      }
      throw error;
    }
  }

  Future<dynamic> update(String path, Map<String, dynamic> data) async {
    Response response;
    try {
      final token = await authenticationRepository.getToken();

      response = await dio.put("${Urls.apiVersion}$path",
          data: data,
          options: Options(contentType: Headers.jsonContentType, headers: {
            "Authorization": "Bearer $token",
            "BrowserBaseURL": Urls.browserBaseUrl,
            "ClientId": Urls.clientId
          }));
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
      if(error is DioError) {
        print(error.response);
      }
      throw ConnectionException();
    }
  }
}
