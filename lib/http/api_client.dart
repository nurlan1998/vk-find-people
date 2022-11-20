import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vk_find_people/http/api_exception.dart';
import 'package:vk_find_people/http/custom_dio_interceptor.dart';

import '../modules/app/bloc/router/app_router_bloc.dart';
import '../modules/app/bloc/router/app_router_event.dart';
import '../modules/app/models/access_token_data.dart';
import '../modules/app/service_locator.dart';

class ApiClient {
  final Dio client;

  ApiClient._({
    required this.client,
  });

  factory ApiClient.instance() {
    final baseOption = BaseOptions(
        baseUrl: 'https://api.vk.com',
        connectTimeout: 10000,
        receiveTimeout: 40000,
        headers: {HttpHeaders.acceptHeader: 'application/json'});
    final dio = Dio(baseOption)
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        final accessTokenData = AccessTokenData.fromCache();

        options.queryParameters = {
          'access_token': accessTokenData?.accessToken,
          'v': '5.131', // VK.com api version
          'lang': 'en',
          ...options.queryParameters,
        };
        return handler.next(options);
      }, onResponse: (response, handler) {
        final data = response.data;
        if (data != null && data is Map && data.containsKey('error')) {
          final apiException = ApiException.fromJson(data['error']);
          if (apiException.error != null &&
              [5, 28].contains(apiException.error)) {
            ServiceLocator.get<AppRouterBloc>().add(
              RoutingEvent(
                callback: (router) async {
                  //await AuthHelper.logout(router.navigatorKey.currentContext!);
                },
              ),
            );
            return;
          }
          return handler.reject(DioError(
            requestOptions: response.requestOptions,
            error: apiException,
            type: DioErrorType.other,
          ));
        }
        return handler.next(response);
      }));

    if (kDebugMode) {
      dio.interceptors.add(CustomDioInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ));
    }

    return ApiClient._(client: dio);
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await client.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response.data['response'];
    } catch (e) {
      rethrow;
    }
  }
}
