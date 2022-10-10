import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';

import 'unexpected_value_error.dart';
import 'value_failure.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  abstract final Either<ValueFailure, T> value;

  bool get isValid => value.isRight();

  T getOrElse(T defaultValue) => value.fold((l) => defaultValue, (r) => r);

  T getValue() => value.fold(
        (l) => throw UnexpectedValueError(l.valueFailure),
        (r) => r,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ValueObject &&
            runtimeType == other.runtimeType &&
            value.fold(
                (l) => other.value.fold((lOther) => l == lOther, (_) => false),
                (r) => other.value.fold((_) => false, (rOther) => rOther == r));
  }

  @override
  int get hashCode => value.fold((l) => l.hashCode, (r) => r.hashCode);
}
