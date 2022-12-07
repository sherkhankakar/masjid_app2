import 'package:flutter/cupertino.dart';

class MainController extends ChangeNotifier {
  double loadingValue = 0.0;

  startLoading() {
    notifyListeners();
  }
}
