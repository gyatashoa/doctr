import 'package:doctr/exceptions/api_exceptions.dart';

class CloudFirestoreException extends ApiException implements Exception {
  final String message;
  final String details;
  CloudFirestoreException({required this.details, required this.message})
      : super(message, details);
}
