import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/services/diagnosis_response_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HistoryBodyViewModel extends ReactiveViewModel {
  final _diagnosisResponseStateService =
      locator<DiagnosisResponseStateService>();

  final _navigationService = locator<NavigationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_diagnosisResponseStateService];

  List<DiagnosisResponseModel> get data =>
      (reactiveServices.first as DiagnosisResponseStateService).data;

  void navigateToDiagnosisReport(DiagnosisResponseModel data) {
    _navigationService.navigateTo(Routes.diagnosisReportView,
        arguments: DiagnosisReportViewArguments(diagnosisResponseModel: data));
  }
}
