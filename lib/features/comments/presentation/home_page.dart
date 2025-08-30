import 'package:comments/common/domain/failure.dart';
import 'package:comments/common/presentation/build_context_extensions.dart';
import 'package:comments/common/presentation/toast_providers.dart';
import 'package:comments/common/presentation/toast_service.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_notifier.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_state.dart';
import 'package:comments/features/comments/presentation/widgets/app_drawer.dart';
import 'package:comments/features/comments/presentation/widgets/comments_empty.dart';
import 'package:comments/features/comments/presentation/widgets/comments_error.dart';
import 'package:comments/features/comments/presentation/widgets/comments_list.dart';
import 'package:comments/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentsNotifierProvider);

    ref.listen<Failure?>(failureProvider, (_, next) {
      if (next != null && mounted) {
        ToastService.showError(context, next.title);

        // Clear the failure after showing toast
        Future.microtask(() {
          if (mounted) {
            ref.read(failureProvider.notifier).state = null;
          }
        });
      }
    });

    ref.listen<String?>(successMessageProvider, (previous, next) {
      if (next != null && mounted) {
        ToastService.showSuccess(context, next);

        Future.microtask(() {
          if (mounted) {
            ref.read(successMessageProvider.notifier).state = null;
          }
        });
      }
    });

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
        backgroundColor: context.appColors.commentTileColor,
        title: Text(S.of(context).comments, style: context.appTextStyles.title),
        centerTitle: true,
      ),
      body: switch (state) {
        CommentsInitial() => const SizedBox(),
        CommentsEmpty() => CommentsEmptyListWidget(),
        CommentsLoading() => Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: context.appColors.secondary!,
            size: 50,
          ),
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
