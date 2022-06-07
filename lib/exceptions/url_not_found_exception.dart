class UrlNotFoundException implements Exception {
  final String message;
  UrlNotFoundException({required this.message}) : super();
}
