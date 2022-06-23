import 'package:dio/dio.dart';
import 'package:doctr/config/constants.dart';
import 'package:doctr/exceptions/api_exceptions.dart';
import 'package:doctr/exceptions/url_not_found_exception.dart';
import 'package:doctr/models/api_response.dart';
import 'dart:convert';

class ApiServices {
  late final Dio _dio;
  final String predictionBaseUrl =
      'https://prediction-disease-test.herokuapp.com/api/v1/predictions';

  ApiServices() {
    _dio = Dio();
  }

  Future<ApiResponse> getNews() async {
    try {
      var response = await _dio.get(NEWS_API_URL + NEWS_API_KEY);
      return ApiResponse.data(data: response.data);
    } on Exception {
      return ApiResponse.error(
          exception: ApiException(
              'Error while fectching ', 'Error while fetching data!!'));
    }
  }

  Future<ApiResponse> getSymptoms() async {
    try {
      var response = await _dio.get(predictionBaseUrl + '/symptoms');
      if (response.statusCode == 404) {
        throw UrlNotFoundException(
            message: 'Url not found!!',
            details:
                response.statusMessage ?? 'Could not locate the url endpoint');
      } else if (response.statusCode! > 400) {
        throw Exception('Error while fetching data!!');
      }
      return ApiResponse.data(data: response.data);
    } on UrlNotFoundException catch (e) {
      return ApiResponse.error(exception: e);
    } on Exception {
      return ApiResponse.error(
          exception: ApiException(
              'Error while fectching ', 'Error while fetching data!!'));
    }
  }

  Future<ApiResponse> makePrediction(List<String> symptoms) async {
    try {
      var temp = {'symptoms': symptoms};
      var data = jsonEncode(temp);
      var response =
          await _dio.post(predictionBaseUrl + '/predict', data: data);
      if (response.statusCode == 404) {
        throw UrlNotFoundException(
            message: 'Url not found!!',
            details:
                response.statusMessage ?? 'Could not locate the url endpoint');
      } else if (response.statusCode! > 400) {
        throw Exception('Error while fetching data!!');
      }
      return ApiResponse.data(data: response.data);
    } on UrlNotFoundException catch (e) {
      return ApiResponse.error(exception: e);
    } on Exception {
      return ApiResponse.error(
          exception: ApiException(
              'Error while fetching data', 'Error while fetching data!!'));
    }
  }
}
