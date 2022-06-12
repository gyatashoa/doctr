import 'package:doctr/exceptions/api_exceptions.dart';

class UrlNotFoundException extends ApiException implements Exception {
  final String message;
  final String details;
  UrlNotFoundException({required this.details, required this.message})
      : super(message, details);
}
