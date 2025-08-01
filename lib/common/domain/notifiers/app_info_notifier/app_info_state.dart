import 'package:comments/common/domain/entities/app_info.dart';
import 'package:comments/common/domain/failure.dart';
import 'package:equatable/equatable.dart';

sealed class AppInfoState extends Equatable {
  const AppInfoState();

  const factory AppInfoState.initial() = AppInfoInitial;

  const factory AppInfoState.loading() = AppInfoLoading;

  const factory AppInfoState.data(AppInfo appInfo) = AppInfoData;

  const factory AppInfoState.error(Failure failure) = AppInfoError;
}

final class AppInfoInitial extends AppInfoState {
  const AppInfoInitial();

  @override
  List<Object?> get props => [];
}

final class AppInfoLoading extends AppInfoState {
  const AppInfoLoading();

  @override
  List<Object?> get props => [];
}

final class AppInfoData extends AppInfoState {
  const AppInfoData(this.appInfo);

  final AppInfo appInfo;

  @override
  List<Object?> get props => [appInfo];
}

final class AppInfoError extends AppInfoState {
  const AppInfoError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
