import 'package:doctr/app/app.locator.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends FormViewModel {
  final _snackBarService = locator<SnackbarService>();

  @override
  void setFormStatus() {}

  String? _isFormValid(String email, String pass, String pass1) {
    //TODO: will use a package to check for email valid
    if (!(email.contains('@') || email.contains('.')))
      return 'Enter a valid email';
    if (pass.length < 6) return 'Password length can\'t be lesser than 6';
    if (pass != pass1) return 'Password do not match';
    return null;
  }

  Future signUp(String email, String pass, String pass1) async {
    var msg = _isFormValid(email, pass, pass1);
    if (msg != null) {
      return _snackBarService.showCustomSnackBar(
          variant: SnackbarVariant.error, message: msg);
    }
  }
}
