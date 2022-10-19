import 'package:flutter/material.dart';
import 'package:pocket/pocket.dart';
import 'package:pocket_notes/data/cache_data_source.dart';

class CachePage extends StatefulWidget {
  /// default constructor
  const CachePage({
    super.key,
  });

  @override
  State<CachePage> createState() => _CachePageState();
}

class _CachePageState extends State<CachePage> {
  CacheDataSource cacheDataSource = CacheDataSource();

  final tableName = 'cache_table';
  bool saveStringEnable = false;
  bool saveDoubleEnable = false;
  bool saveIntEnable = false;
  bool saveBoolEnable = false;

  String? stringValue;
  double? doubleValue;
  int? intValue;
  bool? boolValue;

  @override
  void initState() {
    super.initState();
    initFlags();
  }

  Future<void> initFlags() async {
    await getDataFromCache();
    await isEnable();
    setState(() {});
  }

  Future<void> getDataFromCache() async {
    stringValue = await cacheDataSource.readString('str_key');
    print(stringValue);
    doubleValue = await cacheDataSource.readDouble('double_key');
    intValue = await cacheDataSource.readInt('int_key');
    boolValue = await cacheDataSource.readBool('bool_key');
  }

  Future<void> isEnable() async {
    saveStringEnable = stringValue != null;
    saveDoubleEnable = doubleValue != null;
    saveIntEnable = intValue != null;
    saveBoolEnable = boolValue != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Save String:'),
                Switch(
                  value: saveStringEnable,
                  onChanged: (value) async {
                    saveStringEnable = await changeSwitchValue(
                        value, 'str_key', 'String in cache');
                    print('-> $saveStringEnable');
                    getDataFromCache();

                    setState(() {});
                  },
                ),
                Text('value: $stringValue'),
              ],
            ),
            Row(
              children: [
                Text('Save double:'),
                Switch(
                  value: saveDoubleEnable,
                  onChanged: (value) async {
                    saveDoubleEnable =
                        await changeSwitchValue(value, 'double_key', 25.4333);
                    getDataFromCache();

                    setState(() {});
                  },
                ),
                Text('value: $doubleValue'),
              ],
            ),
            Row(
              children: [
                Text('Save int:'),
                Switch(
                  value: saveIntEnable,
                  onChanged: (value) async {
                    saveIntEnable =
                        await changeSwitchValue(value, 'int_key', 12333121);
                    getDataFromCache();

                    setState(() {});
                  },
                ),
                Text('value: $intValue'),
              ],
            ),
            Row(
              children: [
                Text('Save bool:'),
                Switch(
                  value: saveBoolEnable,
                  onChanged: (value) async {
                    saveBoolEnable =
                        await changeSwitchValue(value, 'bool_key', true);
                    getDataFromCache();
                    setState(() {});
                  },
                ),
                Text('value: $boolValue'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> changeSwitchValue(bool value, String id, dynamic data) async {
    if (value) {
      await createCacheData(id, data);
      return true;
    } else {
      await deleteCacheData(id);
      return false;
    }
  }

  void dropTable() {
    cacheDataSource.clean();
  }

  Future<void> createCacheData(String id, dynamic cacheData) async {
    await cacheDataSource.create(PrimitiveModel(id, cacheData));
  }

  Future<void> deleteCacheData(String id) async {
    await cacheDataSource.delete(id);
  }
}
