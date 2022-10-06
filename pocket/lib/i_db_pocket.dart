abstract class PocketAdapter {
  Future<void> create(AdapterDto item);

  Stream<AdapterDto> read();

  Future<void> update(AdapterDto item);

  Future<void> delete(AdapterDto item);
}

class AdapterDto {}

abstract class IPocketModel {
  /// default constructor
  IPocketModel({required this.id});

  /// id to used in database
  String id;

  /// this method is used to convert data to json, then save json in db
  Map<String, dynamic> toJson();

  Map<String, dynamic> fromJson();
}

abstract class IPocketResult {}

abstract class IPocketDatabase<T extends IPocketModel> {
  Future<void> create();

  Stream<T> read();

  Future<void> update();

  Future<void> delete();
}
