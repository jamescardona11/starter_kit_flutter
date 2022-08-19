import 'headers.dart';

class BaseConfig {
  final String baseUrl;
  final Headers baseHeaders;
  final Duration timeout;
  final String logsTag;
  final bool showGlobalLogs;

  const BaseConfig({
    this.baseUrl = '',
    this.baseHeaders = const Headers.empty(),
    this.timeout = const Duration(seconds: 5),
    this.logsTag = 'ProjectileRequest',
    this.showGlobalLogs = false,
  });
}
