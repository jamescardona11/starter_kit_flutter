import 'package:pocket/src/dto/primitive_model.dart';

import '../dto/i_pocket_model.dart';

/// adapter to convert inner class request to external request
/// Represents the `client interface` in Adapter Pattern diagram
/// https://refactoring.guru/es/design-patterns/adapter

abstract class IPocketMultiDataSource<T extends IPocketModel> {
  String get tableName;

  Future<void> create(T data);

  Future<void> createMany(Iterable<T> data);

  Stream<T?> read(String id);

  Future<void> update(T data);

  Future<void> updateMany(Iterable<T> data);

  Future<void> delete(String id);

  Future<void> dropTable();

  T fromJson(Map<String, dynamic> json);
}

abstract class IPocketSingleDataSource<T extends IPocketModel> {
  Future<void> create(T data, String tableName);

  Future<void> createMany(Iterable<T> data, String tableName);

  Stream<T?> read(String id, String tableName);

  Future<void> update(T data, String tableName);

  Future<void> updateMany(Iterable<T> data, String tableName);

  Future<void> delete(String id, String tableName);

  Future<void> dropTable(String tableName);

  T fromJson(Map<String, dynamic> json);
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
