// ignore_for_file: constant_identifier_names

enum Method {
  GET('get'),
  POST('post'),
  PUT('put'),
  DELETE('delete'),
  PATH('path');

  const Method(this._value);

  final String _value;

  String get value => _value;
}
