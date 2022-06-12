import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/models/gender.dart';
import 'package:doctr/models/user_additional_data_model.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CompleteRegistrationViewModel extends FormViewModel {
  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _cloudService = locator<CloudFirestoreServices>();
  Gender currentGender = Gender.MALE;
  DateTime? dob;

  void onGenderChanged(Gender? gender) {
    currentGender = gender ?? currentGender;
    notifyListeners();
  }

  set onDobUpdate(DateTime data) {
    dob = data;
    notifyListeners();
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  String? _isFormValid() {
    if (dob == null) return 'Please date of birth is required';
    return null;
  }

  Future onSubmit() async {
    var msg = _isFormValid();
    if (msg != null) {
      return _snackBarService.showCustomSnackBar(
          message: msg, variant: SnackbarVariant.error);
    }
    //Upload user data to cloud firestore
    setBusy(true);
    var res = await _cloudService.uploadUserAdditionalData(
        UserAdditionalDataModel(dob: dob!, gender: currentGender));
    setBusy(false);
    if (res.exception != null) {
      return _dialogService.showDialog(
          title: 'Error', description: res.exception?.message);
    }
    //navigate user to home
    _navigationService.pushNamedAndRemoveUntil(Routes.homeView,
        predicate: (_) => false);
  }
}
