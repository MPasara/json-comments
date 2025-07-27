import 'package:comments/common/domain/failure.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:equatable/equatable.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  const factory CommentsState.initial() = CommentsInitial;

  const factory CommentsState.loading() = CommentsLoading;

  const factory CommentsState.empty() = CommentsEmpty;

  const factory CommentsState.data(
    List<Comment> data, {
    bool hasReachedMax,
    bool isLoadingMore,
  }) = CommentsData;

  const factory CommentsState.error(Failure failure) = CommentsError;
}

final class CommentsInitial extends CommentsState {
  const CommentsInitial();

  @override
  List<Object?> get props => [];
}

final class CommentsLoading extends CommentsState {
  const CommentsLoading();

  @override
  List<Object?> get props => [];
}

final class CommentsEmpty extends CommentsState {
  const CommentsEmpty();

  @override
  List<Object?> get props => [];
}

final class CommentsData extends CommentsState {
  const CommentsData(
    this.data, {
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<Comment> data;
  final bool hasReachedMax;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [data, hasReachedMax, isLoadingMore];

  CommentsData copyWith({
    List<Comment>? data,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return CommentsData(
      data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class CommentsError extends CommentsState {
  const CommentsError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
