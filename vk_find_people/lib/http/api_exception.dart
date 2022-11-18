import 'dart:convert';

class ApiException implements Exception {
  final bool apiError;
  final bool statusError;

  final int? error;
  final String? errMessage;
  final int? responseStatus;

  ApiException({
    this.apiError = false,
    this.statusError = false,
    this.error,
    this.errMessage,
    this.responseStatus,
  });

  factory ApiException.fromJson(dynamic json) {
    if (json is String) json = jsonDecode(json);
    return ApiException(
      error: json['error_code'],
      errMessage: json['error_msg'],
      apiError: true,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    data['errMessage'] = errMessage;
    data['apiError'] = apiError;
    data['statusError'] = statusError;
    data['responseStatus'] = responseStatus;
    return data;
  }

  @override
  String toString() => errMessage ?? 'NULL Error';

  String get message => errMessage ?? 'NULL Message';
}