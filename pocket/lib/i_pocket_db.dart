import 'package:pocket/i_pocket_adapter.dart';
import 'package:pocket/sembast_pocket.dart';

abstract class IPocketDatabase<T extends IPocketModel> {
  String get tableName;

  Future<void> create(T data);

  Stream<T> read();

  Future<void> update(T data);

  Future<void> delete(String id);
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
  Future<void> create(T data) async {}

  @override
  Future<void> update(T data) async {}

  @override
  Future<void> delete(String id) async {}

  @override
  Stream<T> read() async* {}
}

class TempDto extends IPocketModel {
  TempDto({required super.id});

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class ExampleDataSource with PocketDatabase<SembastPocket, TempDto> {
  ExampleDataSource(this.adapterDb);

  @override
  String get tableName => 'TableMan';

  @override
  final SembastPocket adapterDb;
}
