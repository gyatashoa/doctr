import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctr/models/gender.dart';

class UserAdditionalDataModel {
  final DateTime dob;
  final Gender gender;

  UserAdditionalDataModel({required this.dob, required this.gender});

  UserAdditionalDataModel.fromJson(Map<String, dynamic> data)
      : dob = (data['dob'] as Timestamp).toDate(),
        gender = data['gender'] == 0 ? Gender.MALE : Gender.FEMALE;

  Map<String, dynamic> get toJson =>
      {'dob': Timestamp.fromDate(dob), 'gender': gender.index};
}
