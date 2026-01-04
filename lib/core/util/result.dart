import 'package:equatable/equatable.dart';
import 'package:rep_roit/core/errors/failures.dart';

sealed class Result<T> extends Equatable {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);

  @override
  List<Object?> get props => [value];
}

class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);

  @override
  List<Object?> get props => [failure];
}
