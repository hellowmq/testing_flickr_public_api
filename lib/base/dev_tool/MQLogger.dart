import 'dart:developer' as developer;

class MQLogger {
  /// Actually a Logger with key-value structure and factory function class is needed.
  static List<String> logger = new List();

  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, MQLogger> _cache = <String, MQLogger>{};

  factory MQLogger([String name = "ThisApp"]) {
    return _cache.putIfAbsent(name, () => MQLogger._internal(name));
  }

  MQLogger._internal(this.name);

  void log(String msg, {dynamic error}) {
    if (!mute) {
      logger.add(msg);
      developer.log(msg, name: 'Logger_$name', error: error);
    }
  }

  static void debugPrint(dynamic msg, {dynamic logger, dynamic error}) {
    String loggerName = logger.toString();
    if (loggerName == null || loggerName.isEmpty) loggerName = "ThisApp";
    if (error == null) {
      MQLogger(loggerName).log(msg.toString());
    } else {
      MQLogger(loggerName).log(msg.toString(), error: error);
    }
  }
}
