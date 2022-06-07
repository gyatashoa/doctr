import 'package:hive/hive.dart';

class CacheServices {
  String boxName = 'cache';

  late Box _box;

  CacheServices() {
    init();
  }

  Future<void> init() async {
    _box = await Hive.openBox(boxName);
  }

  void saveSymtoms(List<String> symptoms) {
    _box.put('symptoms', symptoms);
  }

  List<String>? loadSymptoms() {
    var data = _box.get('symptoms');
    if (data == null) return null;
    return data as List<String>;
  }
}
