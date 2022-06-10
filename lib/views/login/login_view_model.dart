import 'dart:async';

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  final _authServices = locator<AuthServices>();
  final _dialogServices = locator<DialogService>();
  final _navigationServices = locator<NavigationService>();

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

  Future loginPressed({required String email, required String password}) async {
    setLoginLoading = true;
    var res = await _authServices.login(email: email, password: password);
    setLoginLoading = false;
    if (res is String) {
      return _dialogServices.showDialog(title: 'Error', description: res);
    }
    return _navigationServices.pushNamedAndRemoveUntil(Routes.homeView,
        predicate: ((route) => true));
  }

  Future loginWithGooglePressed() async {
    setLoginWithGoogleLoading = true;
    var res;
    try {
      res = await _authServices.loginWithGoogle();
    } catch (e) {}
    setLoginWithGoogleLoading = false;
    if (res == null) return;
    if (res is String) {
      return _dialogServices.showDialog(title: 'Error', description: res);
    }
    return _navigationServices.pushNamedAndRemoveUntil(Routes.homeView,
        predicate: ((route) => true));
  }

  set viewPassword(bool view) {
    _viewPassword = view;
    notifyListeners();
  }

  @override
  void setFormStatus() {}

  void navigateToSignUp() {
    _navigationServices.navigateTo(Routes.signUpView);
  }
}
