class APIResponse<T> {
  ApiResponseStatus status = ApiResponseStatus.loading;
  T? data;
  String? message;

  APIResponse.loading() : status = ApiResponseStatus.loading;
  APIResponse.success(this.data) : status = ApiResponseStatus.success;
  APIResponse.error(this.message) : status = ApiResponseStatus.error;

  bool get isLoading => status == ApiResponseStatus.loading;
  bool get isSuccess => status == ApiResponseStatus.success;
  bool get isError => status == ApiResponseStatus.error;

  void forEach(Null Function(dynamic element) param0) {}
}

enum ApiResponseStatus { loading, success, error }