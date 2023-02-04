class ResponseModel {
  final int statusCode;
  final dynamic data;
  final String? error;

  const ResponseModel({
    this.statusCode = -1,
    this.data,
    this.error,
  });

  bool get isSuccess => statusCode >= 200 && statusCode <= 299;
}
