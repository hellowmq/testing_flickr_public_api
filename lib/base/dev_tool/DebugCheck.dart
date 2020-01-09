import 'dart:io';

class DebugUtils {
  static bool get isDebug => isDebugModel();

  static bool isDebugModel() {
    bool result = false;
    assert(() {
      result = true;
      return true;
    }());
    return result;
  }


  static String getPlatformName()=> Platform.operatingSystem ?? "Unknown Operating System";

  static String getPlatformVersion()
  =>   Platform.operatingSystemVersion?? "Unknown Operating System Version";

}
