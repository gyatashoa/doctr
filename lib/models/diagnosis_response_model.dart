import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosisResponseModel {
  final String diseaseName;
  final List<String> symptoms;
  final DateTime createdAt;

  DiagnosisResponseModel(
      {required this.diseaseName,
      required this.createdAt,
      required this.symptoms});

// _(){
//   <>.
// }

  DiagnosisResponseModel.fromJson(Map<String, dynamic> data)
      : diseaseName = data['diseaseName'],
        createdAt = (data['createdAt'] as Timestamp).toDate(),
        symptoms = data['symptoms'].cast<String>();

  Map<String, dynamic> toJson() => {
        'diseaseName': diseaseName,
        'createdAt': Timestamp.fromDate(createdAt),
        'symptoms': symptoms
      };
}
