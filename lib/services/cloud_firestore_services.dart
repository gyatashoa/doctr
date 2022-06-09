import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctr/app/app.locator.dart';
import 'package:doctr/exceptions/cloud_firestore_exception.dart';
import 'package:doctr/models/api_response.dart';
import 'package:doctr/models/diagnosis_response_model.dart';
import 'package:doctr/services/auth_services.dart';

class CloudFirestoreServices {
  late final FirebaseFirestore _instance;
  late final AuthServices _authService;

  String get collectionName => 'DiagnosisReport';

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
    } on Exception catch (e) {
      print(e);
      return ApiResponse.error(
        exception: CloudFirestoreException(
            message: 'Error while uploading data to firebase',
            details: 'Unable to upload data to firebase'),
      );
    }
  }
}
