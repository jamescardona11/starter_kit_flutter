import 'value_failure.dart';

class UnexpectedValueError extends ValueFailure {
  UnexpectedValueError(super.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation \nFailure was:\n $valueFailure');
  }
}
