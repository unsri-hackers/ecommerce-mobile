class BaseResponse<T> {
  String status;
  int statusCode;
  T result;

  BaseResponse({
    required this.status,
    required this.statusCode,
    required this.result,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) {
    return BaseResponse<T>(
      status: json['status'] as String,
      statusCode: json['status_code'] as int,
      result: fromJsonT(
        json['result'],
      ),
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'status': this.status,
      'status_code': this.statusCode,
      'result': toJsonT(this.result),
    };
  }
}
