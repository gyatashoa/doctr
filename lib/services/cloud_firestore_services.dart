import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctr/app/app.locator.dart';
import 'package:doctr/exceptions/cloud_firestore_exception.dart';
import 'package:doctr/models/api_response.dart';
import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/models/user_additional_data_model.dart';
import 'package:doctr/services/auth_services.dart';

class CloudFirestoreServices {
  late final FirebaseFirestore _instance;
  late final AuthServices _authService;

  String get collectionName => 'DiagnosisReport';

  String get userCollection => 'Users';

  CloudFirestoreServices() {
    _instance = FirebaseFirestore.instance;
    _authService = locator<AuthServices>();
  }

  Future<ApiResponse<DiagnosisResponseModel, CloudFirestoreException>>
      saveDataToCloudDb(DiagnosisResponseModel model) async {
    var uid = _authService.currentUser?.uid;

    var ref = _instance.collection(collectionName);
    try {
      var res = await ref
          .doc(uid)
          .collection('reports')
          .add({...model.toJson(), 'createdAt': FieldValue.serverTimestamp()});
      var data = await res
          .withConverter<DiagnosisResponseModel>(
              fromFirestore: (val, _) =>
                  DiagnosisResponseModel.fromJson(val.data() ?? {}),
              toFirestore: (m, _) => m.toJson())
          .get();
      return ApiResponse.data(data: data.data());
    } on Exception {
      return ApiResponse.error(
        exception: CloudFirestoreException(
            message: 'Error while uploading data to firebase',
            details: 'Unable to upload data to firebase'),
      );
    }
  }

  Future<ApiResponse<UserAdditionalDataModel, CloudFirestoreException>>
      uploadUserAdditionalData(UserAdditionalDataModel data) async {
    var uid = _authService.currentUser?.uid;

    var ref = _instance.collection(userCollection);
    try {
      await ref.doc(uid).set(data.toJson);
      return ApiResponse.data(data: data);
    } on Exception {
      return ApiResponse.error(
        exception: CloudFirestoreException(
            message: 'Error while uploading data to firebase',
            details: 'Unable to upload data to firebase'),
      );
    }
  }

  Future<ApiResponse?> reportAProblem(String message) async {
    var ref = _instance.collection('reports');
    var uid = _authService.currentUser?.uid;

    try {
      await ref.doc().set({
        'id': uid,
        'report': message,
        'createdAt': FieldValue.serverTimestamp()
      });
    } on Exception {
      return ApiResponse.error(
        exception: CloudFirestoreException(
            message: 'Error while uploading data to firebase',
            details: 'Unable to upload data to firebase'),
      );
    }
    return null;
  }

  Future<ApiResponse<UserAdditionalDataModel, CloudFirestoreException>>
      getUserAdditionalData() async {
    var uid = _authService.currentUser?.uid;

    var ref = _instance.collection(userCollection);
    try {
      var data = await ref
          .doc(uid)
          .withConverter<UserAdditionalDataModel>(
              fromFirestore: (snapshot, options) =>
                  UserAdditionalDataModel.fromJson(snapshot.data() ?? {}),
              toFirestore: (model, _) => model.toJson)
          .get();
      return ApiResponse<UserAdditionalDataModel, CloudFirestoreException>.data(
          data: data.data());
    } on Exception {
      return ApiResponse<UserAdditionalDataModel,
          CloudFirestoreException>.error(
        exception: CloudFirestoreException(
            message: 'Error while uploading data to firebase',
            details: 'Unable to upload data to firebase'),
      );
    }
  }

  Future addContributionToCloud(
      List<String> symptoms, List<String> prescriptions, String disease) async {
    var user = _authService.currentUser;
    var ref = _instance.collection('Contributions');
    try {
      var data = <String, dynamic>{
        'doctorName': user?.displayName,
        'doctorEmail': user?.email,
        'symptoms': symptoms,
        'prescriptions': prescriptions,
        'disease': disease,
        'createdAt': FieldValue.serverTimestamp()
      };
      await ref.add(data);
    } catch (e) {
      return 'Error uploading data!!';
    }
  }

  Future<ApiResponse<List<DiagnosisResponseModel>, CloudFirestoreException>>
      loadDataToCloudDb() async {
    var uid = _authService.currentUser?.uid;

    var ref = _instance.collection(collectionName);
    try {
      var res = await ref
          .doc(uid)
          .collection('reports')
          .withConverter<DiagnosisResponseModel>(
              fromFirestore: (val, _) =>
                  DiagnosisResponseModel.fromJson(val.data() ?? {}),
              toFirestore: (m, _) => m.toJson())
          .get();
      return ApiResponse.data(data: res.docs.map((e) => e.data()).toList());
    } on Exception {
      return ApiResponse.error(
        exception: CloudFirestoreException(
            message: 'Error while uploading data to firebase',
            details: 'Unable to upload data to firebase'),
      );
    }
  }
}
