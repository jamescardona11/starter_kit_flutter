import 'package:flutter/material.dart';

import 'i_navigator_service.dart';

/// {@template navigation_wrapper}
///
/// Widget to configure the inherited widget for the application.
/// You can use builder into `MaterialApp` Widget.
///
/// This widget configure the router for MaterialApp
/// additional uses `InheritedWidget` to access to the `IConfigNavigatorMixin`
///
/// The basic use:
/// ``` dart
/// MaterialApp.router(
///  ...
///  routeInformationParser: navigationService.routeInformationParser,
///  routerDelegate: navigationService.routerDelegate,
///  builder (_, child) => NavigationWrapper(
///                           navigationService: ...,
///                           child: child,
///                        )
/// )
/// ```
///
///
/// {@endtemplate}
class NavigationWrapper extends StatefulWidget {
  /// Default constructor for the NavigationWrapper.
  const NavigationWrapper({
    required this.navigationService,
    required this.child,
    required this.callback,
    Key? key,
  }) : super(key: key);

  /// `NavigatorService` instance to handle the nav into the app
  final INavigator navigationService;
  final Function callback;

  /// default `child` from builder method in Material.router
  final Widget child;

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  @override
  void initState() {
    widget.callback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => InheritedNavigator(
        navigationService: widget.navigationService,
        child: widget.child,
      );
}

/// `InheritedWidget`
/// Use the default widget provide from flutter to save instance for navigator
///
@immutable
class InheritedNavigator extends InheritedWidget {
  /// Default constructor for the inherited go router.
  const InheritedNavigator({
    required Widget child,
    required INavigator<dynamic, dynamic> navigationService,
    Key? key,
  })  : _navigationService = navigationService,
        super(child: child, key: key);

  /// The [IConfigNavigatorMixin] that is made available to the widget tree.
  final INavigator<dynamic, dynamic> _navigationService;

  /// This is method is called automatically when the navigator is called.
  INavigator<dynamic, dynamic> navigationService(BuildContext context) =>
      _navigationService..context = context;

  /// Used by the Router architecture as part of the InheritedWidget.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
