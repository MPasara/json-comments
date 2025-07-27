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
  @override
  CommentsState build() {
    _commentsRepository = ref.watch(commentRepositoryProvider);
    getComments(20);
    return const CommentsState.loading();
  }

  Future<void> getComments(int offset) async {
    final eitherFailureOrComments = await _commentsRepository.getComments();

    eitherFailureOrComments.fold(
      (failure) => state = CommentsState.error(failure),
      (data) {
        if (data.isEmpty) {
          state = CommentsState.empty();
        }
        state = CommentsState.data(data);
      },
    );
  }
}
