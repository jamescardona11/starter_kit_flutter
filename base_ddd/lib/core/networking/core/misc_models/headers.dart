class Headers {
  const Headers.empty();

  Headers.fromMap(Map<String, dynamic> headers) {
    _headers.addAll(headers);
  }

  final Map<String, dynamic> _headers = const {};

  void addAll(Map<String, dynamic> headers) {
    _headers.addAll(headers);
  }

  Map<String, String> get asMap {
    final Map<String, String> newMap = {};
    if (_headers.isEmpty) return newMap;

    _headers.forEach((key, value) {
      if (value is String) {
        newMap[key] = value;
      } else if (value is List<String>) {
        newMap[key] = value.join(',');
      }
    });

    return newMap;
  }

  Map<String, List<String>> get asListMap {
    final Map<String, List<String>> newMap = {};
    if (_headers.isEmpty) return newMap;

    _headers.forEach((key, value) {
      if (value is List<String>) {
        newMap[key] = value;
      } else if (value is String) {
        newMap[key] = value.split(',');
      }
    });

    return newMap;
  }
}
