import 'package:doctr/exceptions/api_exceptions.dart';

class UrlNotFoundException extends ApiException implements Exception {
  @override
  // ignore: overridden_fields
  final String message;
  @override
  // ignore: overridden_fields
  final String details;
  UrlNotFoundException({required this.details, required this.message})
      : super(message, details);
}
