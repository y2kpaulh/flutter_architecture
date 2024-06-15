import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'post/post.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/posts/{id}")
  Future<Post> getPost(@Path("id") int id);
}