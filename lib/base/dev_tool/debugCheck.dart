class DebugUtils{
  static bool isDebug() {
    bool result = false;
    assert(() {
      result = true;
      return true;
    }());
    return result;
  }
}