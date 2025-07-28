import 'package:comments/features/comments/data/models/comment_response.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
