import 'package:doctr/app/app.locator.dart';
import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/services/diagnosis_response_state_service.dart';
import 'package:stacked/stacked.dart';

class CheckDiagnosisHistoryViewModel
    extends FutureViewModel<List<DiagnosisResponseModel>> {
  final _cloudService = locator<CloudFirestoreServices>();
  Future<List<DiagnosisResponseModel>> onInit() async {
    //Check if data is on local disk
    //pull diagnosis history from cloud

    var res = await _cloudService.loadDataToCloudDb();
    if (res.data != null) {
      return res.data!;
    }
    throw res.exception!;
  }

  final _diagnosisResponseStateService =
      locator<DiagnosisResponseStateService>();

  List<DiagnosisResponseModel> get dataFromStateManager =>
      _diagnosisResponseStateService.data;
  @override
  Future<List<DiagnosisResponseModel>> futureToRun() async {
    return onInit();
  }

  @override
  void onData(List<DiagnosisResponseModel>? data) {
    if (data != null) {
      if (_diagnosisResponseStateService.data.length < data.length) {
        _diagnosisResponseStateService.setData = data;
        notifyListeners();
      }
    }
  }
}
