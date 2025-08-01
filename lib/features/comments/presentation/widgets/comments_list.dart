import 'package:comments/common/presentation/build_context_extensions.dart';
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
      backgroundColor: context.appColors.background,
      color: context.appColors.primary,
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
          trackVisibility: true,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: comments.length + (hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= comments.length) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: context.appColors.secondary,
                  ),
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
