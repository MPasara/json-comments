import 'package:comments/common/data/api_client.dart';
import 'package:comments/common/data/api_providers.dart';
import 'package:comments/common/domain/failure.dart';
import 'package:comments/common/utils/either.dart';
import 'package:comments/features/comments/data/mappers/comment_entity_mapper.dart';
import 'package:comments/features/comments/data/models/comment_response.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:comments/generated/l10n.dart';
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
        Failure(title: S.current.get_comments_failed, error: e, stackTrace: st),
      );
    }
  }
}
