import 'package:comments/common/utils/constants/api_path_constants.dart';
import 'package:comments/features/comments/data/models/comment_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(ApiPathConstants.comments)
  Future<List<CommentResponse>> getComments(
    @Query('_limit') int limit, {
    @Query('_start') int start = 0,
  });
}
