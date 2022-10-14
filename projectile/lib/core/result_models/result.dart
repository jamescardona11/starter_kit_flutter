import 'failure.dart';
import 'success.dart';

typedef Err<T> = void Function(T error);
typedef Completion<T> = void Function(T success);

/// A value that represents either a success or a failure, including an
/// associated value in each case.
///
/// Result<ResponseError, ResponseSuccess>
abstract class ProjectileResult {
  /// Returns true if [Result] is [Failure].
  bool get isFailure => this is FailureResult;

  /// Returns true if [Result] is [Success].
  bool get isSuccess => this is SuccessResult;

  /// Returns a new value of [Failure] result.
  ///
  FailureResult get failure {
    if (isFailure) {
      return (this as FailureResult);
    }

    throw Exception(
      'Make sure that result [isFailure] before accessing [failure]',
    );
  }

  /// Returns a new value of [Success] result.
  SuccessResult get success {
    if (isSuccess) {
      return (this as SuccessResult);
    }

    throw Exception(
      'Make sure that result [isSuccess] before accessing [success]',
    );
  }

  /// Returns a new value of [Result] from closure
  void fold(Err<FailureResult> failure, Completion<SuccessResult> success) {
    if (isSuccess) {
      final right = this as SuccessResult;
      success(right);
    }

    if (isFailure) {
      final left = this as FailureResult;
      failure(left);
    }
  }
}
