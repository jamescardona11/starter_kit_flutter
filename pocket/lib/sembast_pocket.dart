import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'i_pocket_adapter.dart';

class SembastPocket implements IPocketAdapter {
  SembastPocket._(this.db);

  final Database db;

  static Completer<SembastPocket>? _completer;

  static Future<SembastPocket> initAdapter(String path,
      [int version = 1]) async {
    if (_completer == null) {
      final Completer<SembastPocket> completer = Completer<SembastPocket>();
      try {
        DatabaseFactory dbFactory = databaseFactoryIo;
        Database db = await dbFactory.openDatabase(path, version: 1);
        completer.complete(SembastPocket._(db));
      } on Exception catch (e) {
        // If there's an error, explicitly return the future with an error.
        // then set the completer to null so we can retry.
        completer.completeError(e);

        final Future<SembastPocket> sembastFuture = completer.future;
        _completer == null;

        return sembastFuture;
      }

      _completer = completer;
    }

    return _completer!.future;
  }

  @override
  Future<void> create(AdapterDto item) async {}

  @override
  Future<void> update(AdapterDto item) async {}

  @override
  Future<void> delete(String id) async {}

  @override
  Stream<AdapterDto> read() async* {}
}
