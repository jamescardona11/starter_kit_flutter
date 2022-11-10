/// Data from the client to transform into service data using [IAdapterDto]

abstract class IPocketModel {
  /// default constructor
  /// id to used in database
  String get id;

  /// this method is used to convert data to json, then save json in db
  Map<String, dynamic> toJson();
}
