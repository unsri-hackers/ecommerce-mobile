
/// List of available Error Codes. This should be discussed with the Backend Engineer to get a List of Errors from the Rest API. Any errors available from this app can be determined here
class ErrorCode {

  /// For Example
  static const USER_NOT_EXIST = "E1";
    static const USER_SUSPEND = "E2";
  ///======
  /// Unknow error, Unexpected
  static const UNKNOWN = "E999999";

  static const API_CONNECTION_TIMEOUT = "TIMEOUT";
  static const API_UNAUTHORIZED = "UNAUTHORIZED";
  static const API_ERROR_DATA = "ERROR_PARSED_DATA";
  static const API_NOT_SUCCESS = "NOT_SUCCESS";
  static const API_UNKNOWN_ERROR = "UNKNOWN_ERROR";
  static const FAILED_CREATE_SESSION = "FAILED_CREATE_SESSION";
}
