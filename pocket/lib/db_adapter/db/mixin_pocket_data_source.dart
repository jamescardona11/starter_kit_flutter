import 'package:pocket/db_adapter/adapter/adapter.dart';
import 'package:pocket/db_adapter/db/db.dart';

mixin PocketDataSource<A extends IPocketAdapter, T extends IPocketModel>
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
  Future<void> update(T data) => adapterDb.update(
        table: tableName,
        item: AdapterDto(
          data.id,
          data.toJson(),
        ),
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
