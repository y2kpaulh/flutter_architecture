import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_client.dart';
import 'post.dart';

final dioProvider = Provider<Dio>((ref) {
  return initDio();
});

Dio initDio() {
  final dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

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

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.read(dioProvider);
  return ApiClient(dio);
});

final counterProvider = StateProvider<int>((ref) => 1);

// final postProvider = FutureProvider.autoDispose<Post>((ref) async {
//   final apiClient = ref.read(apiClientProvider);
//   return apiClient.getPost(1);
// });

final postProvider = FutureProvider.autoDispose<Post>((ref) async {
  final counter = ref.watch(counterProvider);
  final apiClient = ref.read(apiClientProvider);
  return apiClient.getPost(counter);
});
