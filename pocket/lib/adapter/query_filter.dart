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
