class BaseResponse<T> {
 
  String? message;
  String? statusCode;
  T result;

  BaseResponse({
    required this.message,
    required this.statusCode,
    required this.result,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) {
    return BaseResponse<T>(
      message:json['message']!=null?json['message']as String:null,
      statusCode: json['statusCode']!=null? json['statusCode'] as String:null,
      result: fromJsonT(
        json['result'],
      ),
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'message':this.message,
      'statusCode': this.statusCode,
      'result': toJsonT(this.result),
    };
  }
}
