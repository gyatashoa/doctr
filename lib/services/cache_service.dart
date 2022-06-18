import 'package:doctr/models/user_additional_data_model.dart';
import 'package:hive/hive.dart';

class CacheServices {
  String boxName = 'cache';

  String userAdditionalBox = 'userAdditionalData';
  Box? _box;

  Box<UserAdditionalDataModel>? _userAdditionalDataBox;

  CacheServices._() {
    init();
  }

  static final _inst = CacheServices._();

  static Future<CacheServices> presolve() async {
    return await Future(() => _inst);
  }

  Future<void> init() async {
    _box = await Hive.openBox(boxName);
    _userAdditionalDataBox = await Hive.openBox(userAdditionalBox);
  }

  Future<UserAdditionalDataModel?> getUserAddData() async {
    _userAdditionalDataBox ??= await Hive.openBox(boxName);
    return _userAdditionalDataBox?.getAt(0);
  }

  Future<void> setUserAddData(UserAdditionalDataModel data) async {
    _userAdditionalDataBox ??= await Hive.openBox(boxName);
    _userAdditionalDataBox?.putAt(0, data);
  }

  Future<void> deleteUserAddData() async {
    _userAdditionalDataBox ??= await Hive.openBox(boxName);
    await _userAdditionalDataBox?.delete(0);
    await _userAdditionalDataBox?.clear();
  }

  void saveSymtoms(List<String> symptoms) {
    _box?.put('symptoms', symptoms);
  }

  List<String>? loadSymptoms() {
    var data = _box?.get('symptoms');
    if (data == null) return null;
    return data as List<String>;
  }
}
