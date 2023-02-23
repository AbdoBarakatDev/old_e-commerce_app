import 'package:flutter/cupertino.dart';

class CheckIsAdmin extends ChangeNotifier {
  bool isAdmin = false;

  checkIsAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
