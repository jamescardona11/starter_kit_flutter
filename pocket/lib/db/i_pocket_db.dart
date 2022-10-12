import 'i_pocket_model.dart';

abstract class IPocketDatabase<T extends IPocketModel> {
  String get tableName;

  Future<void> create(T item);

  Stream<T?> read(String id);

  Future<void> update(T item);

  Future<void> delete(String id);

  Future<void> dropTable();

  T fromJson(Map<String, dynamic> json);
}
