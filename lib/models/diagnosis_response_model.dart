import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosisResponseModel extends Comparable<DiagnosisResponseModel> {
  final String diseaseName;
  final List<String> symptoms;
  final double probability;
  final List<String> prescriptions;
  final DateTime createdAt;

  DiagnosisResponseModel(
      {required this.diseaseName,
      required this.prescriptions,
      required this.probability,
      required this.createdAt,
      required this.symptoms});

// _(){
//   <>.
// }

  DiagnosisResponseModel.fromJson(Map<String, dynamic> data)
      : diseaseName = data['diseaseName'],
        prescriptions = data['prescriptions'].cast<String>(),
        probability = data['probability'],
        createdAt = (data['createdAt'] as Timestamp).toDate(),
        symptoms = data['symptoms'].cast<String>();

  Map<String, dynamic> toJson() => {
        'diseaseName': diseaseName,
        'prescriptions': prescriptions,
        'probability': probability,
        'createdAt': Timestamp.fromDate(createdAt),
        'symptoms': symptoms
      };

  @override
  int compareTo(DiagnosisResponseModel other) {
    return other.createdAt.compareTo(createdAt);
  }
}
