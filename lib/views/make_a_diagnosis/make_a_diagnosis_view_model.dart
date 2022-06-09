import 'package:doctr/app/app.locator.dart';
import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/providers/symptoms_provider.dart';
import 'package:doctr/services/cache_service.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/services/diagnosis_response_state_service.dart';
import 'package:doctr/utils/formatter.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:doctr/services/api_services.dart';

class MakeADiagnosisViewModel extends FormViewModel {
  String? _symp_1;
  String? _symp_2;
  String? _symp_3;
  String? _symp_4;
  String? _symp_5;
  List<String>? symps;
  bool loading = false;
  final _snackbarService = locator<SnackbarService>();
  final _apiService = locator<ApiServices>();
  final _dialogService = locator<DialogService>();
  final _cacheService = locator<CacheServices>();
  final _cloudFirestoreServices = locator<CloudFirestoreServices>();
  final _diagnosisResponseStateService =
      locator<DiagnosisResponseStateService>();

  String? get symp_1 => _symp_1;
  String? get symp_2 => _symp_2;
  String? get symp_3 => _symp_3;
  String? get symp_4 => _symp_4;
  String? get symp_5 => _symp_5;
  Future onload(BuildContext context) async {
    var provider = Provider.of<SymptomsProvider>(context, listen: false);

    if (provider.getSymptoms.isEmpty) {
      var loaded = _cacheService.loadSymptoms();
      if (loaded != null) {
        provider.setSymptoms = loaded;
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
        provider.setSymptoms = data;
        //cache symptoms to local storage
        _cacheService.saveSymtoms(data);
        return;
      }

      //if error show error dialog
      print(res.exception!.message);
    }
  }

  void setSelectedValue(String key, String? value) {
    setData({...formValueMap, key: value});
    switch (key) {
      case 'symp_1':
        _symp_1 = value;
        break;
      case 'symp_2':
        _symp_2 = value;
        break;
      case 'symp_3':
        _symp_3 = value;
        break;
      case 'symp_4':
        _symp_4 = value;
        break;
      case 'symp_5':
        _symp_5 = value;
        break;
      default:
        throw Exception('Invalid key');
    }
    notifyListeners();
  }

  List<String> get symptoms {
    List<String> menuItems = [...symps ?? []];
    return menuItems;
  }

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
        createdAt: DateTime.now(),
        symptoms: formatSymptoms);
    var response = await _cloudFirestoreServices.saveDataToCloudDb(model);
    _diagnosisResponseStateService.addToList = model;
    loading = false;

    notifyListeners();
    _dialogService.showDialog(
        title: 'Diagnosis Report', description: res.data['disease']);
  }

  List<String> get formatSymptoms =>
      formValueMap.values.cast<String>().toSet().toList();

  @override
  void setFormStatus() {}
}
