class ApiResponse<T, R extends Exception> {
  final T? data;
  final R? exception;
  ApiResponse.data({required this.data, this.exception = null});
  ApiResponse.error({this.data = null, required this.exception});
}
