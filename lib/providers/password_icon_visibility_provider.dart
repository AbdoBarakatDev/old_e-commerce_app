import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconVisibilityProvider extends ChangeNotifier {
  IconData iconData = Icons.visibility_off;
  bool textVisible = false;

  onIconVisibilityClicked() {

    if (iconData == Icons.visibility) {
      iconData = Icons.visibility_off;
      textVisible = false;
    } else {
      iconData = Icons.visibility;
      textVisible = true;
    }
    notifyListeners();
  }
}
