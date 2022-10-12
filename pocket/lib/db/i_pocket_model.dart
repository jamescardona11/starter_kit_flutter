abstract class IPocketModel {
  /// default constructor
  IPocketModel({required this.id});

  /// id to used in database
  String id;

  /// this method is used to convert data to json, then save json in db
  Map<String, dynamic> toJson();
}
