import 'package:doctr/exceptions/api_exceptions.dart';

class ApiResponse<T, R extends ApiException> {
  final T? data;
  final R? exception;
  ApiResponse.data({required this.data, this.exception});
  ApiResponse.error({this.data, required this.exception});
}
