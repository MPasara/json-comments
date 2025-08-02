import 'package:comments/common/domain/failure.dart';
import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_notifier.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsErrorWidget extends ConsumerWidget {
  const CommentsErrorWidget({super.key, required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            failure.title,
            style: context.appTextStyles.error,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox.square(dimension: 14),
        ElevatedButton(
          onPressed: () {
            ref
                .read(commentsNotifierProvider.notifier)
                .getComments(refresh: true);
          },
          child: Text(
            S.of(context).try_again,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
