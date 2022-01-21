import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/user/authorization_token.dart';
import 'package:akademi_al_mobile_app/packages/models/user/jwt_token_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/models.dart';
import 'package:akademi_al_mobile_app/packages/models/user/new_user_dto.dart';
import 'package:akademi_al_mobile_app/packages/models/user/roles.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

const box_name = "token";
const authorization_token = "authorizationToken";

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  Box _box;

  final Dio dio;

  AuthenticationRepository()
      : dio = new Dio(new BaseOptions(
          baseUrl: Urls.baseUrl,
          receiveTimeout: 10000,
        ));

  Stream<AuthenticationStatus> get status async* {
    await _openBox();
    var token = await _box.get("token");
    if (token != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> test() {
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<dynamic> signUp(NewUserDto newUserDto) async {
    await loginClient();
    Response response;
    try {
      final String token = await getToken();
      response = await dio.post("${Urls.apiVersion}/oauth2/signup",
          data: newUserDto.toMap(),
          options: Options(contentType: Headers.jsonContentType, headers: {
            "Authorization": "Bearer $token",
            "BrowserBaseURL": Urls.browserBaseUrl,
            "ClientId": Urls.clientId
          }));
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
      } else if (statusCode >= 400 && statusCode < 500) {
        if(statusCode == 409) {
          return response;
        }
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      if(error )
      print("${error}");
      throw ConnectionException();
    }
  }

  Future<JwtTokenEntity> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    Response response;
    try {
      String credentials = "${Urls.clientId}:${Urls.clientSecret}";
      String encoded = base64.encode(utf8.encode(credentials));

      print("ktu 1");
      response = await dio.post("${Urls.apiVersion}/oauth2/token",
          data: {
            "grant_type": "passwordDomain",
            "username": "$username",
            "password": "$password",
            "client_id": Urls.clientId,
            "client_secret": Urls.clientSecret
          },
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Basic $encoded",
                "BrowserBaseURL": Urls.browserBaseUrl
              }));
      print("ktu");
      final statusCode = response.statusCode;
      print("status code ${statusCode}");
      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return JwtTokenEntity();
        } else {
          var jwtAuthorizationToken = JwtTokenEntity.fromJson(response.data);
          print("jwtAuthorizationToken ${jwtAuthorizationToken}");

          await _openBox();
          await _box.put('token', jwtAuthorizationToken.signedJWTToken);
          print("token saved ${jwtAuthorizationToken}");

          var tokenMap =
              JwtDecoder.decode(jwtAuthorizationToken.signedJWTToken);
          var authorizationToken = AuthorizationToken.fromJson(tokenMap);
          await _box.put(authorization_token, authorizationToken);
          print("token saved  entity${jwtAuthorizationToken}");

          _controller.add(AuthenticationStatus.authenticated);
          print("token saved changed status");

          return jwtAuthorizationToken;
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        _controller.add(AuthenticationStatus.unauthenticated);
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        _controller.add(AuthenticationStatus.unauthenticated);
        throw ServerErrorException();
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
        throw UnknownException();
      }
    } catch (error) {
      print("error here $error");
      _controller.add(AuthenticationStatus.unauthenticated);
      throw ConnectionException();
    }
  }

  void logOut() async {
    await _openBox();

    Response response;
    try {
      final AuthorizationToken authenticationToken =
          _box.get(authorization_token);
      final String token = await getToken();
      response = await dio.post("${Urls.apiVersion}/oauth2/signout",
          data: {"refreshToken": authenticationToken.refreshToken},
          options: Options(contentType: Headers.jsonContentType, headers: {
            "Authorization": "Bearer $token",
            "BrowserBaseURL": Urls.browserBaseUrl,
            "ClientId": Urls.clientId
          }));
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        await _box.clear();
        _controller.add(AuthenticationStatus.unauthenticated);
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      throw ConnectionException();
    }
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(box_name)) {
      _box = await Hive.openBox(box_name);
    }
  }

  Future<String> getToken() async {
    await _openBox();
    String accessToken = await _box.get('token');

    return Future.value(accessToken);
  }

  Future<AuthorizationToken> getTokenObject() async {
    await _openBox();
    final accessToken = await _box.get(authorization_token);

    return accessToken;
  }

  Future<User> getCurrentUser() async {
    await _openBox();
    final authorizationToken = await _box.get(authorization_token);

    return authorizationToken?.user;
  }

  Future<String> getCurrentUserId() async {
    await _openBox();
    final authorizationToken = await _box.get(authorization_token);
    return authorizationToken?.userId;
  }

  Future<List<Roles>> getCurrentUserRole() async {
    await _openBox();
    final authorizationToken = await _box.get(authorization_token);
    return authorizationToken?.roles;
  }

  Future<AuthorizationToken> refreshToken(String selectedOrganizationId) async {
    Response response;
    try {
      await _openBox();
      var authorizationToken = _box.get(authorization_token);
      response = await dio.post("${Urls.apiVersion}/oauth2/token",
          data: {
            "grant_type": "refresh_token",
            "refresh_token": "${authorizationToken.refreshToken}",
            "client_id": Urls.clientId,
            "client_secret": Urls.clientSecret,
            "selectedOrganizationId" : selectedOrganizationId
          },
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            "BrowserBaseURL": Urls.browserBaseUrl,
          }));
      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return AuthorizationToken();
        } else {
          var jwtAuthorizationToken = JwtTokenEntity.fromJson(response.data);
          log("response data ktu ${response.data}");
          await _box.put('token', jwtAuthorizationToken.signedJWTToken);
          var tokenMap =
              JwtDecoder.decode(jwtAuthorizationToken.signedJWTToken);
          var authorizationToken = AuthorizationToken.fromJson(tokenMap);
          await _box.put(authorization_token, authorizationToken);
          // _controller.add(AuthenticationStatus.authenticated);
          return authorizationToken;
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> loginClient() async {
    Response response;
    try {
      response = await dio.post("${Urls.apiVersion}/oauth2/token",
          data: {
            "grant_type": "client_credentials",
            "client_id": Urls.clientId,
            "client_secret": Urls.clientSecret
          },
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"BrowserBaseURL": Urls.browserBaseUrl}));
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.data.isEmpty) {
          return JwtTokenEntity();
        } else {
          var jwtAuthorizationToken = JwtTokenEntity.fromJson(response.data);
          await _openBox();
          await _box.put('token', jwtAuthorizationToken.signedJWTToken);
          return jwtAuthorizationToken;
        }
      } else if (statusCode >= 400 && statusCode < 500) {
        throw ClientErrorException();
      } else if (statusCode >= 500 && statusCode < 600) {
        throw ServerErrorException();
      } else {
        throw UnknownException();
      }
    } catch (error) {
      throw ConnectionException();
    }
  }

  void dispose() async {
    await _box.close();
    _controller.close();
  }
}
