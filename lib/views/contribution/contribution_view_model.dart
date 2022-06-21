import 'package:doctr/app/app.locator.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/utils/bottom_sheet_config.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ContributionViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _snackBarService = locator<SnackbarService>();
  final _cloudFirestore = locator<CloudFirestoreServices>();

  Set<String> _symptoms = {};

  String? disease;

  List<String> get addedSymptoms => _symptoms.toList();

  Set<String> _prescriptions = {};

  List<String> get addedprescriptions => _prescriptions.toList();

  String? validate() {
    if (_symptoms.isEmpty) return 'Please add a symptom';
    if (_prescriptions.isEmpty) return 'Please add a prescription';
    if (disease == null) return 'Please add a disease';
    if (disease != null && disease!.isEmpty) return 'Please add a disease';
  }

  Future<void> onContribute() async {
    var msg = validate();
    if (msg != null) {
      return _snackBarService.showCustomSnackBar(
          variant: SnackbarVariant.error, message: msg);
    }
    setBusy(true);
    var res = await _cloudFirestore.addContributionToCloud(
        addedSymptoms, addedSymptoms, disease!);
    setBusy(false);
    if (res is String) {
      return _snackBarService.showCustomSnackBar(
          variant: SnackbarVariant.error, message: res);
    }
    _symptoms = {};
    _prescriptions = {};
    disease = null;
    notifyListeners();
    return _snackBarService.showCustomSnackBar(
        variant: SnackbarVariant.success,
        message: 'Contribution added successfully');
  }

  void onDeleteChip(String e, int type) {
    if (type == 0) {
      _symptoms.remove(e);
    } else {
      _prescriptions.remove(e);
    }
    notifyListeners();
  }

  void onAddToSpecific(String type) async {
    SheetResponse? res = await _bottomSheetService.showCustomSheet(
        data: type, variant: BottomSheetType.floatingWithTextFieldSync);
    if (res != null) {
      onUpdate(res.data, type);
    }
  }

  void onUpdate(String? data, String type) {
    if (data != null && data.isNotEmpty) {
      switch (type) {
        case 'Symptoms':
          _symptoms.add(data);
          break;
        case 'Prescriptions':
          _prescriptions.add(data);
          break;
        case 'Disease':
          disease = data;
          break;
        default:
      }
      notifyListeners();
    }
  }

  void onAdd() async {
    SheetResponse? data = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.choice, title: 'Select an option');
    if (data != null) {
      SheetResponse? res = await _bottomSheetService.showCustomSheet(
          data: data.data, variant: BottomSheetType.floatingWithTextFieldSync);
      if (res != null) {
        onUpdate(res.data, data.data);
      }
    }
  }
}
