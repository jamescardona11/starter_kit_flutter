// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'headers.dart';

class BaseConfig {
  final String baseUrl;
  final Headers? baseHeaders;
  final Duration timeout;
  final String logsTag;
  final bool enableLog;

  const BaseConfig({
    this.baseUrl = '',
    this.baseHeaders,
    this.timeout = const Duration(seconds: 5),
    this.logsTag = 'BasicProjectileLogs',
    this.enableLog = false,
  });

  @override
  String toString() {
    return 'BaseConfig(baseUrl: $baseUrl, baseHeaders: $baseHeaders, timeout: $timeout, logsTag: $logsTag, enableLog: $enableLog)';
  }
}
