import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_notifier.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_state.dart';
import 'package:comments/features/comments/presentation/widgets/app_drawer.dart';
import 'package:comments/features/comments/presentation/widgets/comments_empty.dart';
import 'package:comments/features/comments/presentation/widgets/comments_error.dart';
import 'package:comments/features/comments/presentation/widgets/comments_list.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentsNotifierProvider);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 239, 239),
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).comments),
        centerTitle: true,
      ),
      body: switch (state) {
        CommentsInitial() => const SizedBox(),
        CommentsEmpty() => CommentsEmptyListWidget(),
        CommentsLoading() => const Center(
          child: CircularProgressIndicator(color: Colors.purple),
        ),
        CommentsError(:final failure) => CommentsErrorWidget(failure: failure),
        CommentsData(:final data, :final hasReachedMax, :final isLoadingMore) =>
          CommentsListWidget(
            hasReachedMax: hasReachedMax,
            isLoadingMore: isLoadingMore,
            comments: data,
          ),
      },
    );
  }
}
