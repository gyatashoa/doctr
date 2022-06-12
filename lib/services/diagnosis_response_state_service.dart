import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class DiagnosisResponseStateService with ReactiveServiceMixin {
  RxValue<List<DiagnosisResponseModel>> _data = RxValue([]);

  DiagnosisResponseStateService() {
    listenToReactiveValues([_data]);
  }

  List<DiagnosisResponseModel> get data => _data.value;

  set setData(List<DiagnosisResponseModel> data) {
    _data.value = data;
    _data.value.sort();
  }

  set addToList(DiagnosisResponseModel data) {
    _data.value.add(data);
    _data.value.sort();
  }
}
