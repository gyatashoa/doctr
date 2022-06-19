import 'package:doctr/models/user_additional_data_model.dart';
import 'package:flutter/material.dart';

class UserAdditionalDataProvider extends ChangeNotifier {
  UserAdditionalDataModel? _userAdditionalDataModel;
  UserAdditionalDataProvider(this._userAdditionalDataModel);

  UserAdditionalDataModel? get getUserAddData => _userAdditionalDataModel;

  set setUserAddData(UserAdditionalDataModel? data) {
    _userAdditionalDataModel = data;
    notifyListeners();
  }
}
