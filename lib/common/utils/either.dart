import 'package:comments/common/domain/failure.dart';
import 'package:either_dart/either.dart';

typedef EitherFailureOr<T> = Future<Either<Failure, T>>;
typedef StreamFailureOr<T> = Stream<Either<Failure, T>>;
