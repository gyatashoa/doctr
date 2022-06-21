import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/models/condition.dart';
import 'package:doctr/models/gender.dart';
import 'package:doctr/models/user_additional_data_model.dart';
import 'package:doctr/models/user_type.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CompleteRegistrationViewModel extends FormViewModel {
  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _cloudService = locator<CloudFirestoreServices>();
  final _cacheService = locator<CacheServices>();
  final doctorController = TextEditingController(text: '');
  Gender currentGender = Gender.MALE;
  UserType userType = UserType.user;
  Condition currentCondition = Condition.FIT;
  List<Condition> conditions = [Condition.FIT, Condition.DIABETIC];
  List<UserType> userTypes = [UserType.user, UserType.doctor];
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
    if (userType == UserType.doctor && doctorController.text.isEmpty) {
      return 'Please enter your referal code as a medical doctor';
    }
    return null;
  }

  Future onSubmit(BuildContext context) async {
    var msg = _isFormValid();
    if (msg != null) {
      return _snackBarService.showCustomSnackBar(
          message: msg, variant: SnackbarVariant.error);
    }
    //Upload user data to cloud firestore
    setBusy(true);
    var res = await _cloudService.uploadUserAdditionalData(
        UserAdditionalDataModel(
            dob: dob!,
            docId: userType == UserType.doctor ? doctorController.text : null,
            condition: currentCondition,
            gender: currentGender,
            userType: userType));
    if (res.exception != null) {
      setBusy(false);
      return _dialogService.showDialog(
          title: 'Error', description: res.exception?.message);
    }
    await _cacheService.setUserAddData(res.data!);
    Provider.of<UserAdditionalDataProvider>(context, listen: false)
        .setUserAddData = res.data;
    setBusy(false);
    //navigate user to home
    _navigationService.pushNamedAndRemoveUntil(Routes.homeView,
        predicate: (_) => false);
  }

  void changeCondition(Condition? value) {
    currentCondition = value ?? currentCondition;
    notifyListeners();
  }

  void changeUserType(UserType? value) {
    userType = value ?? userType;
    doctorController.clear();
    notifyListeners();
  }
}
