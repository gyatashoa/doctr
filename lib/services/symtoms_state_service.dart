import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class SymptomsStateService with ReactiveServiceMixin {
  // ignore: prefer_final_fields
  RxValue<List<String>> _data = RxValue([]);

  SymptomsStateService() {
    listenToReactiveValues([_data]);
  }

  List<String> get data => _data.value;

  set setData(List<String> data) {
    _data.value = data;
  }

  set addToList(String data) {
    _data.value.add(data);
  }
}
