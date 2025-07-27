import 'package:comments/features/comments/data/repositories/comments_repository.dart';
import 'package:comments/features/comments/domain/notifiers/comments_notifier/comments_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentsNotifierProvider =
    NotifierProvider<CommentsNotifier, CommentsState>(
      CommentsNotifier.new,
      name: 'Comments Notifier Provider',
    );

class CommentsNotifier extends Notifier<CommentsState> {
  late CommentsRepository _commentsRepository;
  static const int _limit = 20;
  int _currentStart = 0;

  @override
  CommentsState build() {
    _commentsRepository = ref.watch(commentRepositoryProvider);
    getComments();
    return const CommentsState.loading();
  }

  Future<void> getComments({bool refresh = false}) async {
    if (refresh) {
      _currentStart = 0;
      state = const CommentsState.loading();
    }

    final eitherFailureOrComments = await _commentsRepository.getComments(
      limit: _limit,
      start: _currentStart,
    );

    eitherFailureOrComments.fold(
      (failure) => state = CommentsState.error(failure),
      (newComments) {
        if (refresh || _currentStart == 0) {
          // First load or refresh
          if (newComments.isEmpty) {
            state = const CommentsState.empty();
          } else {
            state = CommentsState.data(
              newComments,
              hasReachedMax: newComments.length < _limit,
            );
            _currentStart += newComments.length;
          }
        } else {
          // Loading more
          final currentState = state;
          if (currentState is CommentsData) {
            final allComments = [...currentState.data, ...newComments];
            state = CommentsState.data(
              allComments,
              hasReachedMax: newComments.length < _limit,
            );
            _currentStart += newComments.length;
          }
        }
      },
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is CommentsData &&
        !currentState.hasReachedMax &&
        !currentState.isLoadingMore) {
      // Set loading more state
      state = currentState.copyWith(isLoadingMore: true);

      final eitherFailureOrComments = await _commentsRepository.getComments(
        limit: _limit,
        start: _currentStart,
      );

      eitherFailureOrComments.fold(
        (failure) {
          // Reset loading state on error
          state = currentState.copyWith(isLoadingMore: false);
          // You might want to show a snackbar or toast here
        },
        (newComments) {
          final allComments = [...currentState.data, ...newComments];
          state = CommentsState.data(
            allComments,
            hasReachedMax: newComments.length < _limit,
            isLoadingMore: false,
          );
          _currentStart += newComments.length;
        },
      );
    }
  }
}
