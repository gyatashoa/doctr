class DiagnosisResponseModel {
  final String diseaseName;
  final List<String> symptoms;
  final DateTime createdAt;

  DiagnosisResponseModel(
      {required this.diseaseName,
      required this.createdAt,
      required this.symptoms});

  DiagnosisResponseModel.fromJson(Map<String, dynamic> data)
      : diseaseName = data['diseaseName'],
        //TODO: Will convert incoming data from timestamp to DateTime
        createdAt = data['createdAt'],
        symptoms = data['symptoms'];

  Map<String, dynamic> toJson() =>
      {'diseaseName': diseaseName, 'symptoms': symptoms};
}
