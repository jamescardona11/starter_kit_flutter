// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

abstract class IPocketAdapter {
  Future<void> create({
    required String table,
    required AdapterDto item,
  });

  Stream<AdapterDto?> read({
    required String table,
    required String id,
  });

  Stream<Iterable<AdapterDto>> readWhere({
    required String table,
    required Iterable<PocketQuery> pocketQueries,
    bool andFilters = true,
  });

  Future<void> update({
    required String table,
    required AdapterDto item,
  });

  Future<void> delete({
    required String table,
    required String id,
  });

  Future<void> dropTable(String table);
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
  int get hashCode => Object.hashAll([id, data]);
}

class PocketQuery {}

class LimitPocketQuery extends PocketQuery {
  final int limit;

  LimitPocketQuery([this.limit = -1]); // -1 = infinite
}

class SortPocketQuery extends PocketQuery {
  final bool ascending;
  final String field;

  SortPocketQuery({
    this.ascending = true,
    required this.field,
  });
}

class WherePocketQuery extends PocketQuery {
  final WhereType comparator;
  final Object value;
  final String field;

  WherePocketQuery({
    required this.comparator,
    required this.value,
    required this.field,
  });
}

/// Enum that represent `sort` clause.
enum SortType {
  asc,
  desc,
}

/// Enum that represent diferentes `where` clauses.
enum WhereType {
  equals,
  notEquals,
  greaterThan,
  greaterThanOrEquals,
  lessThan,
  lessThanOrEquals,
  contains,
}
