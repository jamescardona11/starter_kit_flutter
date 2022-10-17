import 'package:flutter/foundation.dart';

class AdapterDto {
  AdapterDto(this.id, this.data);

  final String id;
  final Map<String, dynamic> data;

  @override
  bool operator ==(covariant AdapterDto other) {
    if (identical(this, other)) return true;

    return other.id == id && mapEquals(other.data, data);
  }

  @override
  int get hashCode => Object.hashAll([id, data]);
}
