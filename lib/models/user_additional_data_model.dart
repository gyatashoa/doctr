import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctr/models/condition.dart';
import 'package:doctr/models/gender.dart';

class UserAdditionalDataModel {
  final DateTime dob;
  final Gender gender;
  final Condition condition;

  UserAdditionalDataModel(
      {required this.condition, required this.dob, required this.gender});

  static Condition getCondition(int number) {
    if (number == 0) return Condition.FIT;
    if (number == 1) return Condition.DIABETIC;
    throw Exception('Unknown condition');
  }

  UserAdditionalDataModel.fromJson(Map<String, dynamic> data)
      : dob = (data['dob'] as Timestamp).toDate(),
        condition = getCondition(data['condition']),
        gender = data['gender'] == 0 ? Gender.MALE : Gender.FEMALE;

  Map<String, dynamic> get toJson => {
        'dob': Timestamp.fromDate(dob),
        'gender': gender.index,
        'condition': condition.index
      };
}
