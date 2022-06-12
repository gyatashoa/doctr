import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends FormViewModel {
  final _snackBarService = locator<SnackbarService>();
  final _authService = locator<AuthServices>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  @override
  void setFormStatus() {}

  String? _isFormValid(String name, String email, String pass, String pass1) {
    if (name.trim().length < 2) return 'Please name is required';
    //TODO: will use a package to check for email valid
    if (!(email.contains('@') || email.contains('.')))
      return 'Enter a valid email';
    if (pass.length < 6) return 'Password length can\'t be lesser than 6';
    if (pass != pass1) return 'Password do not match';
    return null;
  }

  Future signUp(String name, String email, String pass, String pass1) async {
    var msg = _isFormValid(name, email, pass, pass1);
    if (msg != null) {
      return _snackBarService.showCustomSnackBar(
          variant: SnackbarVariant.error, message: msg);
    }
    setBusy(true);
    var res =
        await _authService.signUp(email: email, name: name, password: pass);
    setBusy(false);
    if (res is String) {
      return _dialogService.showDialog(title: 'Error', description: res);
    }
    //user created
    //navigate to complete registration view
    _navigationService.pushNamedAndRemoveUntil(Routes.completeRegistrationView,
        predicate: (_) => false);
  }
}
