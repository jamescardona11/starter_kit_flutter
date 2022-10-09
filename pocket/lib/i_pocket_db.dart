import 'package:pocket/i_pocket_adapter.dart';
import 'package:pocket/sembast_pocket.dart';

abstract class IPocketDatabase<T extends IPocketModel> {
  String get tableName;

  Future<void> create(T item);

  Stream<T?> read(String id);

  Future<void> update(T item);

  Future<void> delete(String id);

  Future<void> dropTable();

  T fromJson(Map<String, dynamic> json);
}

abstract class IPocketModel {
  /// default constructor
  IPocketModel({required this.id});

  /// id to used in database
  String id;

  /// this method is used to convert data to json, then save json in db
  Map<String, dynamic> toJson();
}

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

class TempDto extends IPocketModel {
  TempDto({required super.id});

  @override
  Map<String, dynamic> toJson() {
    return {'id': 1};
  }
}

class ExampleDataSource with PocketDatabase<SembastPocket, TempDto> {
  ExampleDataSource(this.adapterDb);

  @override
  String get tableName => 'TableMan';

  @override
  final SembastPocket adapterDb;

  @override
  TempDto fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
