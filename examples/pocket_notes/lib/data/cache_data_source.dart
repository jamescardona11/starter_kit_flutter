import 'package:pocket/pocket.dart';

class CacheDataSource with PocketCache {
  /// default constructor
  const CacheDataSource();

  @override
  IPocketAdapter get adapterDb => SembastPocket.instance();

  void saveStingInCache(String value) {
    // I'm going to use timestamps to id
    create(PrimitiveModel<String>(
        DateTime.now().millisecondsSinceEpoch.toString(), value));
  }
}
