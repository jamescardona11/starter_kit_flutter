import 'package:flutter/material.dart';

class AuthUIProvider extends ChangeNotifier {
  AuthUIProvider() {
    _loginDeltaSize = _loginDeltaBegin;
  }

  // DELTA variables for Login Card
  final _loginDeltaBegin = const Size(1, 1);
  final _loginDeltaEnd = const Size(0.88, 1.05);
  late Size _loginDeltaSize;
  double _loginOpacity = 1.0;
  bool _isRegisterCardOpen = false;

  Size get loginSize => _loginDeltaSize;
  double get opacity => _loginOpacity;
  bool get isRegisterCardOpen => _isRegisterCardOpen;

  void onOpenRegisterCard() {
    _loginDeltaSize = _loginDeltaEnd;
    _isRegisterCardOpen = true;
    _loginOpacity = 0.7;

    notifyListeners();
  }

  void onCloseRegisterCard() {
    _loginDeltaSize = _loginDeltaBegin;
    _isRegisterCardOpen = false;
    _loginOpacity = 1;

    notifyListeners();
  }
}
