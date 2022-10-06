// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

abstract class IPocketAdapter {
  Future<void> create(AdapterDto item);

  Stream<AdapterDto> read();

  Future<void> update(AdapterDto item);

  Future<void> delete(String id);
}

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
  int get hashCode => id.hashCode ^ data.hashCode;
}
