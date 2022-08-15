import 'failure.dart';
import 'success.dart';

typedef Completion<T> = void Function(T value);

/// A value that represents either a success or a failure, including an
/// associated value in each case.
abstract class Result<F, S> {
  /// Returns true if [Result] is [Failure].
  bool get isFailure => this is Failure<F, S>;

  /// Returns true if [Result] is [Success].
  bool get isSuccess => this is Success<F, S>;

  /// Returns a new value of [Failure] result.
  ///
  F get failure {
    if (isFailure) {
      return (this as Failure<F, S>).value;
    }

    throw Exception(
      'Make sure that result [isFailure] before accessing [failure]',
    );
  }

  /// Returns a new value of [Success] result.
  S get success {
    if (isSuccess) {
      return (this as Success<F, S>).value;
    }

    throw Exception(
      'Make sure that result [isSuccess] before accessing [success]',
    );
  }

  /// Returns a new value of [Result] from closure
  void result(Completion<S> success, Completion<F> failure) {
    if (isSuccess) {
      final right = this as Success<F, S>;
      success(right.value);
    }

    if (isFailure) {
      final left = this as Failure<F, S>;
      failure(left.value);
    }
  }

  /// Maps a [Result<F, S>] to [Result<U, S>] by applying a function
  /// to a contained [Success] value, leaving an [Failure] value untouched.
  /// This function can be used to compose the results of two functions.
  Result<F, U> map<F, U>(U Function(S) transform) {
    if (isSuccess) {
      final right = this as Success<F, S>;
      return Success(transform(right.value));
    } else {
      final left = this as Failure<F, S>;
      return Failure(left.value);
    }
  }

  /// Maps a [Result<F, S>] to [Result<E, S>] by applying a function
  /// to a contained [Failure] value, leaving an [Success] value untouched.
  ///
  /// This function can be used to pass through a successful result
  /// while applying transformation to [Failure].
  ///
  Result<E, S> mapError<E, S>(E Function(F) transform) {
    if (isSuccess) {
      final right = this as Success<F, S>;
      return Success(right.value);
    } else {
      final left = this as Failure<F, S>;
      return Failure(transform(left.value));
    }
  }

  /// Maps a [Result<F, S>] to [Result<F, U>] by applying a function
  /// to a contained [Success] value and unwrapping the produced result,
  /// leaving an [Failure] value untouched.
  ///
  /// Use this method to avoid a nested result when your transformation
  /// produces another [Result] type.
  ///
  /// In this example, note the difference in the result of using `map` and
  /// `flatMap` with a transformation that returns an result type.
  ///
  ///  ```
  Result<F, U> flatMap<F, U>(Result<F, U> Function(S) transform) {
    if (isSuccess) {
      final right = this as Success<F, S>;
      return transform(right.value);
    } else {
      final left = this as Failure<F, S>;
      return Failure(left.value);
    }
  }

  /// Maps a [Result<F, S>] to [Result<E, S>] by applying a function
  /// to a contained [Failure] value, leaving an [Success] value untouched.
  ///
  /// This function can be used to pass through a successful result
  /// while unboxing [Failure] and applying transformation to it.
  ///
  Result<E, S> flatMapError<E, S>(Result<E, S> Function(F) transform) {
    if (isSuccess) {
      final right = this as Success<F, S>;
      return Success(right.value);
    } else {
      final left = this as Failure<F, S>;
      return transform(left.value);
    }
  }
}
