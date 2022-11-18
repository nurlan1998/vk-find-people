import 'dart:convert';

import 'package:dio/dio.dart';

import '../modules/app/logging/log.dart';

class CustomDioInterceptor extends Interceptor {
  CustomDioInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logPrint = print,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(logPrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object) logPrint;

  @override
  Future onRequest(options, handler) async {
    final output = <String>[];
    output.add('*** Request ***');
    output.add('URI: ${options.uri}');

    if (request) {
      output.add('Method: ${options.method}');
      /*printKV('responseType', options.responseType?.toString());
      printKV('followRedirects', options.followRedirects);
      printKV('connectTimeout', options.connectTimeout);
      printKV('receiveTimeout', options.receiveTimeout);
      printKV('extra', options.extra);*/
    }
    if (requestHeader) {
      final stringBuffer = StringBuffer();
      options.headers.forEach((key, v) => stringBuffer.write('\n  $key:$v'));
      output.add('Headers ->');
      output.add(stringBuffer.toString());
      stringBuffer.clear();
    }
    if (requestBody && options.data != null) {
      output.add('data:');
      output.add(options.data is Map || options.data is List
          ? jsonEncode(options.data)
          : options.data);
    }

    Log.i(output.join('\n'));

    return handler.next(options);
  }

  @override
  Future onError(err, handler) async {
    final output = <String>[];
    if (error) {
      output.add('*** DioError ***:');
      output.add('URI: ${err.requestOptions.uri}');
      output.add('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }

      Log.e(output.join('\n'));
    }

    return handler.next(err);
  }

  @override
  Future onResponse(response, handler) async {
    _printResponse(response);

    return handler.next(response);
  }

  void _printResponse(
      Response response, [
        success = true,
      ]) {
    final output = <String>[];
    if (success) {
      output.add('*** Response ***');
    }
    output.add('URI: ${response.requestOptions.uri}');
    if (responseHeader) {
      output.add('Status Code: ${response.statusCode}');
      /*if (response.isRedirect == true) {
        printKV('redirect', response.realUri);
      }
      if (response.headers != null) {
        logPrint("headers:");
        var headers = response.headers.toString()?.replaceAll("\n", "\n ");
        if (headers != null) {
          logPrint(" $headers");
        }
      }*/
    }
    if (responseBody) {
      output.add('Response Text:');
      output.add(response.toString());
    }

    Log.i(output.join('\n'));
  }

  String printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    return pattern
        .allMatches(text)
        .map((match) => match.group(0))
        .toList()
        .join('\n');
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }
}