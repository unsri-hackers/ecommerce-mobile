import 'package:deuvox/app/config/app_config.dart';

/// List of API Endpoint
class ApiUtils {
  static String login = AppConfig.baseUrl + "/login";
  static String listProductsPaging =
      AppConfig.baseUrl + "/storefront/products/paging";
  static String addProduct = AppConfig.baseUrl + "/storefront/products";
  static String userProfile = "https://run.mocky.io/v3/2beab3e1-b04c-4809-81bc-48d6f088ff19";
  //secret delete link:https://designer.mocky.io/manage/delete/2b89f6de-d30c-4b9c-ae89-ec36597483c4/deuvox
  static String onGoingOrders =
      "https://run.mocky.io/v3/22d13d9a-66b1-47d4-9f6c-3e21ed499189";
  static String productCategories =
      "https://run.mocky.io/v3/a0ea061d-b557-4f10-88aa-16232b4e7633";
  static String yourProducts =
      "https://run.mocky.io/v3/812e482c-0e66-441a-b597-6ed73642dc29";
}
