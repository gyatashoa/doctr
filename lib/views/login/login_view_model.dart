import 'dart:async';

import 'package:stacked/stacked.dart';

class LoginViewModel extends FormViewModel {
  bool _viewPassword = false;
  bool _loginloading = false;
  bool _loginwithGoogleloading = false;

  bool get viewPassword => _viewPassword;
  bool get isLoginLoading => _loginloading;
  bool get isLoginwithGoogleLoading => _loginwithGoogleloading;

  set setLoginLoading(bool val) {
    _loginloading = val;
    notifyListeners();
  }

  set setLoginWithGoogleLoading(bool val) {
    _loginwithGoogleloading = val;
    notifyListeners();
  }

  void loginPressed() async {
    setLoginLoading = true;
    Timer(Duration(seconds: 5), () {
      setLoginLoading = false;
    });
  }

  void loginWithGooglePressed() async {
    setLoginWithGoogleLoading = true;
    Timer(Duration(seconds: 5), () {
      setLoginWithGoogleLoading = false;
    });
  }

  set viewPassword(bool view) {
    _viewPassword = view;
    notifyListeners();
  }

  @override
  void setFormStatus() {}
}
