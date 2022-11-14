import 'package:pocket/src/dto/adapter_dto.dart';

import '../dto/i_pocket_model.dart';
import 'i_pocket_adapter.dart';
import 'i_pocket_database.dart';
import 'query_filter.dart';

mixin PocketMultiDataSourceMixin<A extends IPocketAdapter>
    implements IPocketMultiDataSource {
  A get adapterDb;

  @override
  Future<void> create<T extends IPocketModel>(T data, String tableName) =>
      adapterDb.create(
        table: tableName,
        item: AdapterDto(
          data.id,
          data.toJson(),
        ),
      );

  @override
  Future<void> createMany<T extends IPocketModel>(
          Iterable<T> data, String tableName) =>
      adapterDb.createMany(
        table: tableName,
        items: data.map((item) => AdapterDto(
              item.id,
              item.toJson(),
            )),
      );

  @override
  Future<void> update<T extends IPocketModel>(T data, String tableName) =>
      adapterDb.update(
        table: tableName,
        item: AdapterDto(
          data.id,
          data.toJson(),
        ),
      );

  @override
  Future<void> updateMany<T extends IPocketModel>(
          Iterable<T> data, String tableName) =>
      adapterDb.updateMany(
        table: tableName,
        items: data.map((item) => AdapterDto(
              item.id,
              item.toJson(),
            )),
      );

  @override
  Future<void> delete(String id, String tableName) => adapterDb.delete(
        table: tableName,
        id: id,
      );

  @override
  Stream<T?> read<T>(
    String id,
    String tableName,
    FromJson fromJson,
  ) =>
      adapterDb.read(table: tableName, id: id).map((dto) {
        if (dto != null) {
          try {
            return fromJson(dto.data);
          } catch (e) {
            return null;
          }
        }
        return null;
      });

  @override
  Future<void> dropTable(String tableName) => adapterDb.dropTable(tableName);

  @override
  Stream<Iterable<T>> readWhere<T>(
    tableName,
    FromJson fromJson, {
    Iterable<PocketQuery> pocketQueries = const [],
  }) {
    return adapterDb
        .readWhere(table: tableName, pocketQueries: pocketQueries)
        .map((event) => event.map((dto) => fromJson(dto.data)));
  }
}
