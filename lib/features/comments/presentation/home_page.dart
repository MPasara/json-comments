import 'package:comments/common/presentation/build_context_extensions.dart';
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
      backgroundColor: context.appColors.background,
      drawer: AppDrawer(),

      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: context.appColors.primary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: context.appColors.background,
        title: Text(S.of(context).comments, style: context.appTextStyles.title),
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
