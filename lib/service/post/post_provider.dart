import 'package:flutter_architecture/service/service_dio.dart';
import '../api_client.dart';
import '../../common.dart';
import 'post.dart';

const baseUrl = "https://jsonplaceholder.typicode.com";

final dioProvider = Provider<Dio>((ref) {
  return serviceDio(baseUrl);
});

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
