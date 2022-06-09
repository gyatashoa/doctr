import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:stacked/stacked.dart';

class CheckDiagnosisHistoryViewModel extends BaseViewModel {
  var response = <DiagnosisResponseModel>[
    DiagnosisResponseModel(
        diseaseName: 'Malaria',
        symptoms: [
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
        ],
        createdAt: DateTime.now()),
    DiagnosisResponseModel(
        diseaseName: 'Malaria',
        symptoms: [
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
        ],
        createdAt: DateTime.now()),
    DiagnosisResponseModel(
        diseaseName: 'Malaria',
        symptoms: [
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
        ],
        createdAt: DateTime.now()),
    DiagnosisResponseModel(
        diseaseName: 'Malaria',
        symptoms: [
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
          'Headache',
        ],
        createdAt: DateTime.now())
  ];
}
