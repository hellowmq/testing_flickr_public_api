import 'package:http/http.dart' as http;
import 'photo.dart';

typedef MQSuccessCallback<T> = T Function(http.Response);
typedef MQErrorCallback = Function(Exception, http.Response);
typedef PhotoListCallback = void Function(List<Photo>);
typedef MapContentCallback = void Function(Map<String, String>);
typedef ErrorCallback = void Function(Exception, http.Response);
