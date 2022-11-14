import 'package:pocket/pocket.dart';

/// adapter to convert inner class request to external request
/// Represents the `client interface` in Adapter Pattern diagram
/// https://refactoring.guru/es/design-patterns/adapter

typedef FromJson<T> = T Function(Map<String, dynamic> json);

abstract class IPocketSingleDataSource<T extends IPocketModel> {
  String get tableName;

  Future<void> create(T data);

  Future<void> createMany(Iterable<T> data);

  Stream<T?> read(String id);

  Stream<Iterable<T>> readWhere({
    Iterable<PocketQuery> pocketQueries = const [],
  });

  Future<void> update(T data);

  Future<void> updateMany(Iterable<T> data);

  Future<void> delete(String id);

  Future<void> dropTable();

  T fromJson(Map<String, dynamic> json);
}

abstract class IPocketMultiDataSource {
  Future<void> create<T extends IPocketModel>(T data, String tableName);

  Future<void> createMany<T extends IPocketModel>(
      Iterable<T> data, String tableName);

  Stream<T?> read<T>(
    String id,
    String tableName,
    FromJson fromJson,
  );

  Stream<Iterable<T>> readWhere<T>(
    tableName,
    FromJson fromJson, {
    Iterable<PocketQuery> pocketQueries = const [],
  });

  Future<void> update<T extends IPocketModel>(T data, String tableName);

  Future<void> updateMany<T extends IPocketModel>(
      Iterable<T> data, String tableName);

  Future<void> delete(String id, String tableName);

  Future<void> dropTable(String tableName);

  // T fromJson(Map<String, dynamic> json);
}

abstract class IPocketCache {
  String get tableName;

  Future<void> create<D>(PrimitiveModel<D> item);

  Future<String?> readString(String id);

  Future<int?> readInt(String id);

  Future<double?> readDouble(String id);

  Future<bool?> readBool(String id);

  Future<void> update<D>(PrimitiveModel<D> item);

  Future<void> delete(String id);

  Future<void> clean();
}
