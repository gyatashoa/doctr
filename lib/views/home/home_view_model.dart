import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/views/check_user_profile/check_user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  int _index = 0;
  final _authService = locator<AuthServices>();
  final _navigationService = locator<NavigationService>();

  int get index => _index;

  set index(int i) {
    _index = i;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.signOut();
    await _navigationService.clearStackAndShow(Routes.loginView);
  }

  Future<void> aboutThisApp(BuildContext context) async {
    showAboutDialog(
      context: context,
      applicationVersion: '1.0.0',
    );
  }

  void checkUserProfile() {
    _navigationService.navigateTo(Routes.checkUserProfileView);
  }

  void termsAndCondition() async {
    _navigationService.navigateTo(Routes.termsAndConditions);
  }
}
