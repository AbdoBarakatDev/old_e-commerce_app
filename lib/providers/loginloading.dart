import 'package:flutter/cupertino.dart';

class MyModelHud extends ChangeNotifier {
  bool isLoading=false;

  checkIsLoaing(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
