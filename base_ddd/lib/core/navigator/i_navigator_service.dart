import 'package:flutter/material.dart';

/// [INavigator] implementation as Mixin to handle context set and get
mixin INavigatorMixin<R, E> implements INavigator<R, E> {
  BuildContext? _context;

  @override
  set context(BuildContext? context) => _context = context;

  @override
  BuildContext? get context => _context;
}

/// Navigation abstraction to be used all around the application.
///
/// Whenever navigation is required it should be handled by depending on
/// [INavigator] interface, not on any of the possible implementations
abstract class INavigator<R, E> {
  set context(BuildContext? context);

  /// Is used for navigatorInstance to avoid recall context multiple times
  BuildContext? get context;

  /// This method is used to navigate to the given route.
  /// The parametrization is because some libraries use String others use Page.
  /// The `goal` of this method is `keep` the stack of routes
  Future<R?> navigateToRoute<T extends Object?>(R route, {E? extra});

  /// This method is used to navigate to the given name/paths. (name/paths strategy).
  /// Some libraries was called name strategy and other is called paths strategy
  Future<R?> navigateTo<T extends Object?>(String name, {E? extra});

  /// This method is used to navigate to the given route.
  /// The parametrization is because some libraries use String others use Page.
  /// The `goal` of this method is `remove` the stack of routes and start new it
  Future<void> pushRoute(R route, {E? extra});

  /// This method is used to navigate to the given name/paths. (name/paths strategy)
  /// The parametrization is because some libraries use String others use Page
  /// The `goal` of this method is `remove` the stack of routes and start new it
  Future<void> push<T extends Object?>(String name, {E? extra});

  /// This method is used to replace all route and reset the current stack
  Future<void> pushAndReset(List<R> route);

  /// This method is used to pop to the previous route
  void pop(dynamic result);

  /// This method is used to pop to the first route in the stack
  /// If the stack has changed the `route.isFirst` is changed automatically too
  void popUntilFirst();

  /// This method is used to pop to the route name in the stack
  void popUntil(String name);

  /// This method is used to pop to the route name in the stack
  bool removeWhere(String name);
}
