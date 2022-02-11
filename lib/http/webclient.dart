import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: const Duration(seconds: 30),
);
