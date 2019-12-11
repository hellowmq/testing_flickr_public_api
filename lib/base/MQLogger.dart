import 'package:flutter/widgets.dart';

class MQLogger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, MQLogger> _cache = <String, MQLogger>{};

  factory MQLogger([String name = "ThisApp"]) {
    return _cache.putIfAbsent(name, () => MQLogger._internal(name));
  }

  MQLogger._internal(this.name);

  void log(String msg) {
    if (!mute) debugPrint('Logger_$name: $msg');
  }

  static void debug(dynamic msg, {String loggerName}) {
    if (loggerName == null || loggerName.isEmpty) loggerName = "ThisApp";
    MQLogger(loggerName).log(msg.toString());
  }
}
