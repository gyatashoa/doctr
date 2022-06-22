import 'dart:async';

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  final _authServices = locator<AuthServices>();
  final _dialogServices = locator<DialogService>();
  final _navigationServices = locator<NavigationService>();
  final _cloudService = locator<CloudFirestoreServices>();
  final _cacheService = locator<CacheServices>();

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

  Future loginPressed(
      {required String email,
      required String password,
      required BuildContext context}) async {
    setLoginLoading = true;
    var res = await _authServices.login(email: email, password: password);
    if (res is String) {
      setLoginLoading = false;
      return _dialogServices.showDialog(title: 'Error', description: res);
    }
    //get data from cloud
    var result = (await _cloudService.getUserAdditionalData()).data;
    if (result == null) {
      //show error dialog
      return;
    }
    //cache user details
    await _cacheService.setUserAddData(result);
    Provider.of<UserAdditionalDataProvider>(context, listen: false)
        .setUserAddData = result;
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
        predicate: ((route) => false));
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

  void navigateToForgotPassword() {
    _navigationServices.navigateTo(Routes.forgotPasswordView);
  }
}
