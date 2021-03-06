import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/services/diagnosis_response_state_service.dart';
import 'package:doctr/services/symtoms_state_service.dart';
import 'package:doctr/utils/formatter.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:doctr/services/api_services.dart';

class MakeADiagnosisViewModel extends FormViewModel {
  bool loading = false;
  final _snackbarService = locator<SnackbarService>();
  final _apiService = locator<ApiServices>();
  final _cacheService = locator<CacheServices>();
  final _cloudFirestoreServices = locator<CloudFirestoreServices>();
  final _diagnosisResponseStateService =
      locator<DiagnosisResponseStateService>();
  final _symptomsStateService = locator<SymptomsStateService>();
  final _navigationService = locator<NavigationService>();

  final Set<String> _selectedSymtoms = <String>{};

  Future onload() async {
    if (_symptomsStateService.data.isEmpty) {
      var loaded = _cacheService.loadSymptoms();
      if (loaded != null) {
        _symptomsStateService.setData = loaded;
        return;
      }
      //show loading state to user
      //get symptoms from api
      var res = await _apiService.getSymptoms();
      //hide loading state to user
      if (res.data != null) {
        var data = formatSymptomsToList(res.data);
        //add symptoms to state store
        //populate symptoms to ui
        _symptomsStateService.setData = data;
        //cache symptoms to local storage
        _cacheService.saveSymtoms(data);
        return;
      }
    }
  }

  List<String> get symptoms => _symptomsStateService.data;

  Future onStartDiagnosis() async {
    if (formatSymptoms.isEmpty) {
      return _snackbarService.showCustomSnackBar(
          variant: SnackbarVariant.error,
          message: 'Please select at least one symptom');
    }
    loading = true;
    notifyListeners();
    var res = await _apiService.makePrediction(formatSymptoms);

    if (res.data == null) {
      loading = false;
      notifyListeners();
      return _snackbarService.showCustomSnackBar(
          variant: SnackbarVariant.error,
          message: res.exception?.message ?? 'Error while making diagnosis');
    }
    var model = DiagnosisResponseModel(
        diseaseName: res.data['disease'],
        prescriptions: res.data['prescriptions'].cast<String>(),
        probability: res.data['probability'],
        createdAt: DateTime.now(),
        symptoms: formatSymptoms);
    await _cloudFirestoreServices.saveDataToCloudDb(model);
    _diagnosisResponseStateService.addToList = model;
    loading = false;
    notifyListeners();
    _navigationService.navigateTo(Routes.diagnosisReportView,
        arguments: DiagnosisReportViewArguments(diagnosisResponseModel: model));
  }

  List<String> get formatSymptoms => _selectedSymtoms.toList();

  @override
  void setFormStatus() {}

  void updateChips(String? res) {
    if (res != null) {
      _selectedSymtoms.add(res);
      notifyListeners();
    }
  }

  void onDeleteChip(String e) {
    _selectedSymtoms.remove(e);
    notifyListeners();
  }
}
