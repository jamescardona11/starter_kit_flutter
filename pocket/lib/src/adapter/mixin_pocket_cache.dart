import 'package:pocket/src/dto/adapter_dto.dart';
import 'package:pocket/src/dto/primitive_model.dart';

import 'i_pocket_adapter.dart';
import 'i_pocket_database.dart';

mixin PocketCache<A extends IPocketAdapter> implements IPocketCache {
  A get adapterDb;

  @override
  Future<void> create<D>(PrimitiveModel<D> item) => adapterDb.create(
        table: tableName,
        item: AdapterDto(
          item.id,
          item.toJson(),
        ),
      );

  @override
  Future<void> update<D>(PrimitiveModel<D> item) => adapterDb.update(
        table: tableName,
        item: AdapterDto(
          item.id,
          item.toJson(),
        ),
      );

  @override
  Future<void> delete(String id) => adapterDb.delete(
        table: tableName,
        id: id,
      );

  @override
  Future<bool?> readBool(String id) async {
    final mapResult = await _read(id);
    if (mapResult == null) return null;
    if (mapResult[id] is! bool) {
      throw Exception('The value with $id is not a bool');
    }

    return mapResult[id] as bool;
  }

  @override
  Future<int?> readInt(String id) async {
    final mapResult = await _read(id);
    if (mapResult == null) return null;
    if (mapResult[id] is! int) {
      throw Exception('The value with $id is not a int');
    }

    return mapResult[id] as int;
  }

  @override
  Future<double?> readDouble(String id) async {
    final mapResult = await _read(id);
    if (mapResult == null) return null;
    if (mapResult[id] is! double) {
      throw Exception('The value with $id is not a double');
    }

    return mapResult[id] as double;
  }

  @override
  Future<String?> readString(String id) async {
    final mapResult = await _read(id);
    if (mapResult == null) return null;
    if (mapResult[id] is! String) {
      throw Exception('The value with $id is not a String');
    }

    return mapResult[id] as String;
  }

  Future<Map<String, dynamic>?> _read<T>(String id) async {
    final stream = adapterDb.read(table: tableName, id: id).map((dto) {
      if (dto != null) {
        try {
          return dto.data;
        } catch (e) {
          return null;
        }
      }
      return null;
    });

    return await stream.first;
  }

  @override
  Future<void> clean() => adapterDb.dropTable(tableName);

  @override
  String get tableName => 'pocket_cache_db_preferences';
}
