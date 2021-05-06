///Response Models from Rest API. Adjust to Backend
class CApiRes {
  late bool success;
  /// Not empty when `success:false`
  String? errorCode;
  late String message;
  /// response data. E.g User Data.
  dynamic? data;

  CApiRes({required this.success, this.errorCode,required this.message, this.data});

  CApiRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errorCode = (json['errorCode']).toString();
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }

  CApiResError get resError =>CApiResError(
    errorCode: errorCode!,
    message: message
  );
}

///Error Model with Error Code constant.
class CApiResError {
  late String errorCode;
  late String? message;

  CApiResError({required this.errorCode, this.message});

  CApiResError.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    return data;
  }
}
