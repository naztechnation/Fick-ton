import 'package:flutter/foundation.dart';

class PageIndexProvider with ChangeNotifier {
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void changePageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}
