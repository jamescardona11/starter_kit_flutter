abstract class IProjectileConfig {
  final String baseUrl;
  final Duration timeout;
  final String logsTag;
  final bool showGlobalLogs;

  IProjectileConfig({
    this.baseUrl = '',
    this.timeout = const Duration(seconds: 5),
    this.logsTag = 'ProjectileRequest',
    this.showGlobalLogs = false,
  });
}

class BaseConfig extends IProjectileConfig {
  BaseConfig({
    super.baseUrl,
    super.timeout,
    super.logsTag,
    super.showGlobalLogs,
  });
}

class RequestConfig extends IProjectileConfig {
  RequestConfig({
    super.timeout,
    super.logsTag,
    super.showGlobalLogs,
  });
}
