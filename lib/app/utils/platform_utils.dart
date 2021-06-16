import 'package:universal_platform/universal_platform.dart';

class PlatformUtils {
  static String getPlatformType() {
    if (UniversalPlatform.isAndroid)
      return UniversalPlatformType.Android.toString().split(".").last;
    else if (UniversalPlatform.isFuchsia)
      return UniversalPlatformType.Fuchsia.toString().split(".").last;
    else if (UniversalPlatform.isIOS)
      return UniversalPlatformType.IOS.toString().split(".").last;
    else if (UniversalPlatform.isLinux)
      return UniversalPlatformType.Linux.toString().split(".").last;
    else if (UniversalPlatform.isMacOS)
      return UniversalPlatformType.MacOS.toString().split(".").last;
    else if (UniversalPlatform.isWeb)
      return UniversalPlatformType.Web.toString().split(".").last;
    else if (UniversalPlatform.isWindows)
      return UniversalPlatformType.Windows.toString().split(".").last;
    else
      return "other";
  }
}
