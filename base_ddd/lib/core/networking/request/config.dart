class BaseConfig {
  final String baseUrl;
  final Duration timeout;
  final String logsTag;
  final bool showGlobalLogs;

  const BaseConfig({
    this.baseUrl = '',
    this.timeout = const Duration(seconds: 5),
    this.logsTag = 'ProjectileRequest',
    this.showGlobalLogs = false,
  });
}
