import 'dart:async';

import 'package:stacked/stacked.dart';

class LoginViewModel extends FormViewModel {
  bool _viewPassword = false;
  bool _loading = false;

  bool get viewPassword => _viewPassword;
  bool get isLoading => _loading;

  set setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void loginPressed() async {
    setLoading = true;
    Timer(Duration(seconds: 5), () {
      setLoading = false;
    });
  }

  void loginWithGooglePressed() async {
    setLoading = true;
    Timer(Duration(seconds: 5), () {
      setLoading = false;
    });
  }

  set viewPassword(bool view) {
    _viewPassword = view;
    notifyListeners();
  }

  @override
  void setFormStatus() {}
}
