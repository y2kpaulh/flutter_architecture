import '../common.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio serviceDio(String baseUrl) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  final logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  );

  dio.interceptors.add(logger);
  return dio;
}