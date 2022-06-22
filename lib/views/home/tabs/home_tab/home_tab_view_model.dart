import 'package:stacked/stacked.dart';

class HomeTabViewModel extends BaseViewModel {
  bool anim = false;
  void onFeelingFine() {
    anim = true;
    notifyListeners();
  }

  void onClose() {
    anim = false;
    notifyListeners();
  }
}
