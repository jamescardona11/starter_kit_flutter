import 'package:flutter/material.dart';

/// [IConfigNavigator] implementation as Mixin to handle context set and get
abstract class IConfigNavigator<T> {
  ///default constructor

  /// Here is where the default routes and configuration is setup
  /// You could override the `value` for:
  /// `_routeInformationParser` and `_routerDelegate`
  void initConfiguration();

  /// Get T router to init the navigator
  T get router;

  /// routes mapping
  Map<String, String> get routesMap;

  /// Is used for navigator 2.0 to create the route strategy
  RouteInformationParser<Object>? get routeInformationParser;

  /// Is used for navigator 2.0 to create the route strategy
  RouterDelegate<Object>? get routerDelegate;
}
