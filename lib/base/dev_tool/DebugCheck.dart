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
}
