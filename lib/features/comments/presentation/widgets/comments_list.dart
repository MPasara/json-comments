import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_notifier.dart';
import 'package:comments/features/comments/presentation/widgets/comment_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsListWidget extends ConsumerWidget {
  const CommentsListWidget({
    super.key,
    required this.hasReachedMax,
    required this.isLoadingMore,
    required this.comments,
  });

  final bool hasReachedMax;
  final bool isLoadingMore;
  final List<Comment> comments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref
          .read(commentsNotifierProvider.notifier)
          .getComments(refresh: true),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent - 200) {
            if (!hasReachedMax && !isLoadingMore) {
              ref.read(commentsNotifierProvider.notifier).loadMore();
            }
          }
          return false;
        },
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          child: ListView.builder(
            primary: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: comments.length + (hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= comments.length) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(color: Colors.purple),
                );
              }

              final comment = comments[index];
              return CommentListTile(comment: comment);
            },
          ),
        ),
      ),
    );
  }
}
