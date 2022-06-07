import 'package:dio/dio.dart';
import 'package:doctr/exceptions/url_not_found_exception.dart';
import 'package:doctr/models/api_response.dart';
import 'dart:convert';

class ApiServices {
  late final Dio _dio;
  final String baseUrl = 'https:///api/v1/predictions';

  ApiServices() {
    _dio = Dio();
  }

  Future<ApiResponse> getSymptoms() async {
    try {
      var response = await _dio.get(baseUrl + '/symptoms');
      if (response.statusCode == 404) {
        throw UrlNotFoundException(message: 'Url not found!!');
      } else if (response.statusCode! > 400) {
        throw Exception('Error while fetching data!!');
      }
      return ApiResponse.data(data: jsonDecode(response.data));
    } on UrlNotFoundException catch (e) {
      return ApiResponse.error(exception: e);
    } on Exception catch (e) {
      return ApiResponse.error(exception: e);
    }
  }

  Future<ApiResponse> makePrediction(List<String> symptoms) async {
    try {
      var temp = {'symptoms': symptoms};
      var data = jsonEncode(temp);
      var response = await _dio.post(baseUrl + '/predict', data: data);
      if (response.statusCode == 404) {
        throw UrlNotFoundException(message: 'Url not found!!');
      } else if (response.statusCode! > 400) {
        throw Exception('Error while fetching data!!');
      }
      return ApiResponse.data(data: jsonDecode(response.data));
    } on UrlNotFoundException catch (e) {
      return ApiResponse.error(exception: e);
    } on Exception catch (e) {
      return ApiResponse.error(exception: e);
    }
  }
}
