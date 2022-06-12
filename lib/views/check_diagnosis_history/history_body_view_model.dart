import 'package:doctr/app/app.locator.dart';
import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/services/diagnosis_response_state_service.dart';
import 'package:stacked/stacked.dart';

class HistoryBodyViewModel extends ReactiveViewModel {
  final _diagnosisResponseStateService =
      locator<DiagnosisResponseStateService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_diagnosisResponseStateService];

  List<DiagnosisResponseModel> get data =>
      (reactiveServices.first as DiagnosisResponseStateService).data;
}
