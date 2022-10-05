import 'package:flutter/foundation.dart';

import 'result.dart';

/// A success, storing a [Success] value.
@immutable
class Success<F, S> extends Result<F, S> {
  final S value;

  Success(this.value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Success<F, S> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success: $value';
}
