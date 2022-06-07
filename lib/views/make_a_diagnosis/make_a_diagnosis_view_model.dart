import 'package:doctr/app/app.locator.dart';
import 'package:doctr/utils/formatter.dart';
import 'package:doctr/utils/snackbar_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:doctr/services/api_services.dart';

class MakeADiagnosisViewModel extends FormViewModel {
  String? _symp_1;
  String? _symp_2;
  String? _symp_3;
  String? _symp_4;
  String? _symp_5;
  final _snackbarService = locator<SnackbarService>();
  final _apiService = locator<ApiServices>();

  String? get symp_1 => _symp_1;
  String? get symp_2 => _symp_2;
  String? get symp_3 => _symp_3;
  String? get symp_4 => _symp_4;
  String? get symp_5 => _symp_5;

  Future getSymptoms() async {
    //show loading state to user
    //get symptoms from api
    var res = await _apiService.getSymptoms();
    //hide loading state to user
    if (res.data != null) {
      //add symptoms to state store
      //populate symptoms to ui
      //cache symptoms to local storage
      return;
    }

    //if error show error dialog
    print(res.exception!.message);
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
    List<String> menuItems = const [
      "Fever",
      "Headache",
      "Vomiting",
      "Cold",
    ];
    return menuItems;
  }

  Future onStartDiagnosis() async {
    if (formatSymptoms.isEmpty) {
      return _snackbarService.showCustomSnackBar(
          variant: SnackbarVariant.error,
          message: 'Please select at least one symptom');
    }
    print(formatSymptoms);
  }

  List<String> get formatSymptoms =>
      formValueMap.values.cast<String>().toSet().toList();

  @override
  void setFormStatus() {}
}