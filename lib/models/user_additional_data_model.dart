import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctr/models/condition.dart';
import 'package:doctr/models/gender.dart';
import 'package:doctr/models/user_type.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_additional_data_model.g.dart';

@HiveType(typeId: 1)
class UserAdditionalDataModel {
  @HiveField(0)
  final DateTime dob;
  @HiveField(1)
  final Gender gender;
  @HiveField(2)
  final Condition condition;
  @HiveField(3)
  final UserType userType;
  @HiveField(4)
  final String? docId;

  UserAdditionalDataModel(
      {required this.condition,
      required this.dob,
      this.docId,
      required this.userType,
      required this.gender});

  static Condition getCondition(int number) {
    if (number == 0) return Condition.FIT;
    if (number == 1) return Condition.DIABETIC;
    throw Exception('Unknown condition');
  }

  UserAdditionalDataModel.fromJson(Map<String, dynamic> data)
      : dob = (data['dob'] as Timestamp).toDate(),
        docId = data['docId'],
        userType = data['userType'] == 0 ? UserType.user : UserType.doctor,
        condition = getCondition(data['condition']),
        gender = data['gender'] == 0 ? Gender.MALE : Gender.FEMALE;

  Map<String, dynamic> get toJson => {
        'dob': Timestamp.fromDate(dob),
        'gender': gender.index,
        'condition': condition.index,
        'userType': userType,
        'docId': docId
      };
}
