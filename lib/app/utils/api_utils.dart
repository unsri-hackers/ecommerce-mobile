import 'package:deuvox/app/config/app_config.dart';

/// List of API Endpoint
class ApiUtils {
static String login = AppConfig.baseUrl + "/login";
  static String listProductsPaging =
      AppConfig.baseUrl + "/storefront/products/paging";
  static String addProduct = AppConfig.baseUrl + "/storefront/products";
  static String userProfile = AppConfig.baseUrl + "/users";
  //secret delete link:https://designer.mocky.io/manage/delete/2b89f6de-d30c-4b9c-ae89-ec36597483c4/deuvox
  static String homeData = "https://run.mocky.io/v3/2b89f6de-d30c-4b9c-ae89-ec36597483c4";
}
