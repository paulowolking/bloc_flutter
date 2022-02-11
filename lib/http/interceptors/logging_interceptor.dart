import 'package:flutter/material.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('Request\n'
        'url: ${data.url}\n'
        'headers: ${data.headers}\n'
        'body: ${data.body}\n');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('Response\n'
        'status coode: ${data.statusCode}\n'
        'headers: ${data.headers}\n'
        'body: ${data.body}\n');
    return data;
  }
}
