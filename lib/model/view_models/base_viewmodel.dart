


import 'package:flutter/foundation.dart';

import '../../res/enum.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}