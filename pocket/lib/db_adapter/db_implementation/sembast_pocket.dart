import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:pocket/db_adapter/adapter/adapter.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastPocket implements IPocketAdapter {
  SembastPocket._(this._db);

  final Database _db;

  static Completer<SembastPocket>? _completer;
  static SembastPocket? _sembastPocket;

  /// only call this if you called `initAdapter` first
  static SembastPocket instance() {
    if (_completer == null) {
      throw Exception('Call initAdapter before instance');
    }

    return _sembastPocket!;
  }

  static bool get wasInitCalled => _sembastPocket != null;

  static Future<SembastPocket> initAdapter(
    String path, [
    int version = 1,
  ]) async {
    if (_completer == null) {
      final Completer<SembastPocket> completer = Completer<SembastPocket>();
      try {
        final pathName = await _getDBPath(path);

        DatabaseFactory dbFactory = databaseFactoryIo;
        Database db = await dbFactory.openDatabase(pathName, version: 1);
        _sembastPocket = SembastPocket._(db);
        completer.complete(_sembastPocket!);
      } on Exception catch (e) {
        // If there's an error, explicitly return the future with an error.
        // then set the completer to null so we can retry.
        completer.completeError(e);

        final Future<SembastPocket> sembastFuture = completer.future;
        _completer == null;

        return sembastFuture;
      }

      _completer = completer;
    }

    return _completer!.future;
  }

  static Future<String> _getDBPath(String path) async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    return dir.path + path;
  }

  Future<void> closeDatabase() => _db.close();

  @override
  Future<void> create({
    required String table,
    required AdapterDto item,
  }) async {
    final store = _sembastStore(table);
    await store.record(item.id).add(_db, item.data);
  }

  @override
  Future<void> update({
    required String table,
    required AdapterDto item,
  }) async {
    final store = _sembastStore(table);
    await store.record(item.id).update(_db, item.data);
  }

  @override
  Future<void> delete({
    required String table,
    required String id,
  }) async {
    final store = _sembastStore(table);
    await store.record(id).delete(_db);
  }

  @override
  Stream<AdapterDto?> read({
    required String table,
    required String id,
  }) async* {
    final store = _sembastStore(table);
    yield* store.record(id).onSnapshot(_db).map(
          (snapshot) => snapshot == null
              ? null
              : AdapterDto(
                  id,
                  snapshot.value,
                ),
        );
  }

  @override
  Stream<Iterable<AdapterDto>> readWhere({
    required String table,
    Iterable<PocketQuery> pocketQueries = const [],
    bool andFilters = true,
  }) {
    final store = _sembastStore(table);
    Finder finder = _getFinder(pocketQueries, andFilters);

    return store
        .query(finder: finder)
        .onSnapshots(_db)
        .map((snapshots) => snapshots.map((e) => AdapterDto(
              e.key,
              e.value,
            )));
  }

  @override
  Future<void> dropTable(String table) => _sembastStore(table).drop(_db);

  StoreRef<String, Map<String, Object?>> _sembastStore(String table) =>
      (table.isEmpty)
          ? StoreRef<String, Map<String, Object>>.main()
          : stringMapStoreFactory.store(table);

  Finder _getFinder(Iterable<PocketQuery> pocketsQueries, bool andFilters) {
    final finder = Finder();
    List<Filter> filters = [];

    for (PocketQuery query in pocketsQueries) {
      if (query is LimitPocketQuery) {
        finder.limit = query.limit;
      } else if (query is SortPocketQuery) {
        finder.sortOrder = SortOrder(
          query.field,
          query.ascending,
        );
      } else if (query is WherePocketQuery) {
        filters.add(_getFilterFromClause(query));
      }
    }

    if (andFilters) {
      finder.filter = Filter.and(filters);
    } else {
      finder.filter = Filter.or(filters);
    }

    return finder;
  }

  Filter _getFilterFromClause(WherePocketQuery wherePocketQuery) {
    switch (wherePocketQuery.comparator) {
      case WhereType.equals:
        return Filter.equals(
          wherePocketQuery.field,
          wherePocketQuery.value,
        );

      case WhereType.notEquals:
        return Filter.notEquals(
          wherePocketQuery.field,
          wherePocketQuery.value,
        );

      case WhereType.greaterThan:
        return Filter.greaterThan(
          wherePocketQuery.field,
          wherePocketQuery.value,
        );

      case WhereType.lessThan:
        return Filter.lessThan(
          wherePocketQuery.field,
          wherePocketQuery.value,
        );

      case WhereType.contains:
        return Filter.matches(
          wherePocketQuery.field,
          wherePocketQuery.value as String,
        );

      case WhereType.greaterThanOrEquals:
        return Filter.greaterThanOrEquals(
          wherePocketQuery.field,
          wherePocketQuery.value,
        );

      case WhereType.lessThanOrEquals:
        return Filter.lessThanOrEquals(
          wherePocketQuery.field,
          wherePocketQuery.value,
        );
    }
  }
}
