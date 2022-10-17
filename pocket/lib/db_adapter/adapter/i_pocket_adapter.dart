// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'adapter_dto.dart';
import 'query_filter.dart';

abstract class IPocketAdapter {
  Future<void> create({
    required String table,
    required AdapterDto item,
  });

  Stream<AdapterDto?> read({
    required String table,
    required String id,
  });

  Stream<Iterable<AdapterDto>> readWhere({
    required String table,
    required Iterable<PocketQuery> pocketQueries,
    bool andFilters = true,
  });

  Future<void> update({
    required String table,
    required AdapterDto item,
  });

  Future<void> delete({
    required String table,
    required String id,
  });

  Future<void> dropTable(String table);
}
