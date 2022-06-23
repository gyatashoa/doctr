import 'package:doctr/exceptions/api_exceptions.dart';

class CloudFirestoreException extends ApiException implements Exception {
  // ignore: annotate_overrides, overridden_fields
  final String message;
  @override
  // ignore: overridden_fields
  final String details;
  CloudFirestoreException({required this.details, required this.message})
      : super(message, details);
}
