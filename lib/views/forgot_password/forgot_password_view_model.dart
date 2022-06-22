import 'package:doctr/app/app.locator.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _authService = locator<AuthServices>();
  final _snackbarService = locator<SnackbarService>();

  String? _isFormValid(String email) {
    if (!(email.contains('@') || email.contains('.'))) {
      return 'Enter a valid email';
    }
    return null;
  }

  Future? onForgotPassword(String email) async {
    var res = _isFormValid(email);
    if (res != null) {
      return _snackbarService.showCustomSnackBar(
          variant: SnackbarVariant.error, message: res);
    }
    setBusy(true);
    var result = await _authService.forgotPassword(email: email);
    setBusy(false);
    if (result is String) {
      return _dialogService.showDialog(title: 'Error', description: result);
    }
    return _dialogService.showDialog(
        title: 'Success',
        description:
            'An email link has been sent to $email.Please check the link and reset your password');
  }
}
