// ignore_for_file: public_member_api_docs, sort_constructors_first
/// {@template config}
/// {@endtemplate}
import 'headers.dart';

class BaseConfig {
  final String baseUrl;
  final Headers? baseHeaders;
  final Duration timeout;
  final String logsTag;
  final bool enableLog;
  final bool isHttp;

  const BaseConfig({
    this.baseUrl = '',
    this.baseHeaders,
    this.timeout = const Duration(seconds: 10),
    this.logsTag = 'BasicProjectileLogs',
    this.enableLog = false,
    this.isHttp = false,
  });

  @override
  String toString() {
    return 'BaseConfig(baseUrl: $baseUrl, baseHeaders: $baseHeaders, timeout: $timeout, logsTag: $logsTag, enableLog: $enableLog)';
  }

  BaseConfig copyWith({
    String? baseUrl,
    Headers? baseHeaders,
    Duration? timeout,
    String? logsTag,
    bool? enableLog,
    bool? isHttp,
  }) {
    return BaseConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      baseHeaders: baseHeaders ?? this.baseHeaders,
      timeout: timeout ?? this.timeout,
      logsTag: logsTag ?? this.logsTag,
      enableLog: enableLog ?? this.enableLog,
      isHttp: isHttp ?? this.isHttp,
    );
  }
}
