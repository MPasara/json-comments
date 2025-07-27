import 'package:comments/common/data/api_client.dart';
import 'package:comments/common/data/api_providers.dart';
import 'package:comments/common/domain/failure.dart';
import 'package:comments/features/comments/data/models/comment_response.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';

final commentRepositoryProvider = Provider<CommentsRepository>(
  (ref) => CommentsRepositoryImpl(
    ref.watch(apiClientProvider),
    ref.watch(commentEntityMapperProvider),
  ),
  name: 'Comments Repository Provider',
);

abstract interface class CommentsRepository {
  EitherFailureOr<List<Comment>> getComments({int limit = 20, int start = 0});
}

class CommentsRepositoryImpl implements CommentsRepository {
  CommentsRepositoryImpl(this._apiClient, this._commentMapper);

  final ApiClient _apiClient;
  final EntityMapper<Comment, CommentResponse> _commentMapper;

  @override
  EitherFailureOr<List<Comment>> getComments({
    int limit = 20,
    int start = 0,
  }) async {
    try {
      final comments = <Comment>[];

      final commentResponseList = await _apiClient.getComments(
        limit,
        start: start,
      );

      for (var commentResponse in commentResponseList) {
        final comment = _commentMapper(commentResponse);
        comments.add(comment);
      }

      return Right(comments);
    } catch (e, st) {
      logDebug(e.toString());
      logDebug(st.toString());
      return Left(
        Failure(title: 'Get comments failed...', error: e, stackTrace: st),
      );
    }
  }
}

typedef EitherFailureOr<T> = Future<Either<Failure, T>>;
typedef EntityMapper<Entity, Response> = Entity Function(Response);

final commentEntityMapperProvider =
    Provider<EntityMapper<Comment, CommentResponse>>(
      (ref) => (response) {
        return Comment(
          postId: response.postId,
          id: response.id,
          name: response.name,
          email: response.email,
          body: response.body,
        );
      },
    );
