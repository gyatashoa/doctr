import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int _index = 0;

  int get index => _index;

  set index(int i) {
    _index = i;
    notifyListeners();
  }
}
