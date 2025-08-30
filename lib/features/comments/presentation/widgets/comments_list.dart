// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_notifier.dart';
import 'package:comments/features/comments/presentation/widgets/comment_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsListWidget extends ConsumerStatefulWidget {
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
  ConsumerState<CommentsListWidget> createState() => _CommentsListWidgetState();
}

class _CommentsListWidgetState extends ConsumerState<CommentsListWidget> {
  AsyncMemoizer? _loadMoreMemoizer;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: context.appColors.commentTileColor,
      color: context.appColors.primary,
      onRefresh: () async {
        // Reset the memoizer when refreshing
        _loadMoreMemoizer = null;
        return ref
            .read(commentsNotifierProvider.notifier)
            .getComments(refresh: true);
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // Calculate 70% of scroll extent
          final threshold = scrollInfo.metrics.maxScrollExtent * 0.8;

          if (scrollInfo.metrics.pixels >= threshold) {
            if (!widget.hasReachedMax && !widget.isLoadingMore) {
              _triggerLoadMore();
            }
          }
          return false;
        },
        child: RawScrollbar(
          interactive: true,
          radius: Radius.circular(10),
          thumbColor: context.appColors.secondary!.withValues(alpha: 0.65),
          child: ListView.builder(
            primary: true,
            padding: const EdgeInsets.only(top: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: widget.comments.length + (widget.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= widget.comments.length) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: context.appColors.secondary,
                  ),
                );
              }
              final comment = widget.comments[index];
              return CommentListTile(comment: comment);
            },
          ),
        ),
      ),
    );
  }

  void _triggerLoadMore() {
    _loadMoreMemoizer ??= AsyncMemoizer();
    _loadMoreMemoizer!.runOnce(() async {
      await ref.read(commentsNotifierProvider.notifier).loadMore();
      // Reset memoizer after successful load to allow next pagination
      _loadMoreMemoizer = null;
    });
  }
}
