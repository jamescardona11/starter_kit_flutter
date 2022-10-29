import 'package:pocket/dto/adapter_dto.dart';

import '../dto/i_pocket_model.dart';
import 'i_pocket_adapter.dart';
import 'i_pocket_database.dart';

mixin PocketDatabase<A extends IPocketAdapter, T extends IPocketModel>
    implements IPocketDatabase<T> {
  A get adapterDb;

  @override
  Future<void> create(T data) => adapterDb.create(
        table: tableName,
        item: AdapterDto(
          data.id,
          data.toJson(),
        ),
      );

  @override
  Future<void> createMany(Iterable<T> data) => adapterDb.createMany(
        table: tableName,
        items: data.map((item) => AdapterDto(
              item.id,
              item.toJson(),
            )),
      );

  @override
  Future<void> update(T data) => adapterDb.update(
        table: tableName,
        item: AdapterDto(
          data.id,
          data.toJson(),
        ),
      );

  @override
  Future<void> updateMany(Iterable<T> data) => adapterDb.updateMany(
        table: tableName,
        items: data.map((item) => AdapterDto(
              item.id,
              item.toJson(),
            )),
      );

  @override
  Future<void> delete(String id) => adapterDb.delete(
        table: tableName,
        id: id,
      );

  @override
  Stream<T?> read(String id) =>
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
  Future<void> dropTable() => adapterDb.dropTable(tableName);
}
