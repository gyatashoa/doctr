import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/utils/bottom_sheet_config.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  int _index = 0;
  final _authService = locator<AuthServices>();
  final _navigationService = locator<NavigationService>();
  final _cacheService = locator<CacheServices>();
  final _bottomSheet = locator<BottomSheetService>();
  final _snackbarService = locator<SnackbarService>();

  int get index => _index;

  set index(int i) {
    _index = i;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    Provider.of<UserAdditionalDataProvider>(context, listen: false)
        .setUserAddData = null;
    await _cacheService.deleteUserAddData();
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

  Future? onReportAProblem() async {
    var res = await _bottomSheet.showCustomSheet(
      variant: BottomSheetType.floatingWithTextField,
    );
    if (res == null) return;
    if (res.data != null) {
      return _snackbarService.showCustomSnackBar(
        variant: SnackbarVariant.error,
        message: 'Error sending report',
      );
    }
    _snackbarService.showCustomSnackBar(
        variant: SnackbarVariant.success,
        message: 'Report sent successfully!!');
  }
}
