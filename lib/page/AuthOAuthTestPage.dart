import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wenmq_first_flickr_flutter_app/api/auth.oauth.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class AuthOAuthTestPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return AuthOAuthTestPage();
  }

  @override
  _AuthOAuthTestPageState createState() => _AuthOAuthTestPageState();
}

class _AuthOAuthTestPageState extends State<AuthOAuthTestPage> {
  int currentStep = 0;
  static Map<String, String> pageContent = new Map<String, String>();
  String authUrl = 'www.wenmq.cn';
  String realTimeMapData = '';
  WebViewController controller;

  void onStepCancel() {
    //回到上一步
    setState(() {
      if (currentStep > 0) {
        currentStep = currentStep - 1;
      } else {
        currentStep = 0;
      }
    });
  }

  void onStepContinue() async {
    //下一步
    if (currentStep < 5) {
      switch (currentStep) {
        case 0:
          _updateFlickrOAuthInstance();
          print('update FlickrOauth instance Finish');
          break;
        case 1:
          await _requestToken();
          print('await _requestToken()' 'Finish');
          break;
        case 2:
          _generateAuthorizeUrl();
          print('await _authorize()' 'Finish');
          break;
        case 3:
          await _accessToken();
          print('await _accessToken()' 'Finish');
          break;
        case 4:
          await _loginTest();
          print('await _loginTest()' 'Finish');
          break;
        default:
          throw Exception("CurrentStep Error");
          break;
      }
      currentStep = currentStep + 1;
    } else {
      currentStep = 0;
    }

    String mapString = FlickrOAuth.getInstance()
        .authParamsMap
        .keys
        .map((key) => '$key:${FlickrOAuth.getInstance().authParamsMap[key]}')
        .join('\n');
    print('$mapString');

    setState(() {
      realTimeMapData = mapString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("透過 Flickr 使用 OAuth"),
//        elevation: 0.0,
//      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          print(authUrl);
          setState(() {
            controller.loadUrl(authUrl);
          });
        },
        child: Icon(Icons.send),
      ),
      body: new Stepper(
        steps: <Step>[
          Step(
            title: Text('Reset'),
            subtitle: Text('recreate instance'),
            state: StepState.indexed,
            content: Card(
              color: Colors.red,
              child: SizedBox(
                width: 600.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('建立基本字串'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(realTimeMapData),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: Text('request_token'),
            subtitle: Text('request_token'),
            isActive: true,
            content: Card(
              color: Colors.red,
              child: SizedBox(
                width: 600.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('建立基本字串'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(realTimeMapData),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: Text('取得使用者授權'),
            subtitle: Text('_authorize'),
            state: StepState.error,
            content: Card(
              color: Colors.red,
              child: SizedBox(
                width: 600.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('建立基本字串'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(realTimeMapData),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: Text('交換要求記錄，以取得存取記錄的權限'),
            subtitle: Text('_accessToken'),
            state: StepState.editing,
            content: Container(
              height: 1000.0,
              width: 600.0,
              child: WebView(
                initialUrl: authUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (str) {
                  print('onPageFinished');
                  pageContent.addAll(Uri.splitQueryString(
                      str.substring(str.indexOf('?') + 1)));
                },
                onWebViewCreated: (WebViewController webViewController) {
                  controller = webViewController;
                },
              ),
            ),
          ),
          Step(
            title: Text('透過 OAuth 呼叫 Flickr API'),
            subtitle: Text('indexed状态'),
            state: StepState.indexed,
            content: Card(
              color: Colors.red,
              child: SizedBox(
                width: 600.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('建立基本字串'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(realTimeMapData),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Step(
            title: Text('Finish'),
            state: StepState.indexed,
            content: Card(
              color: Colors.red,
              child: SizedBox(
                width: 600.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('完成'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(realTimeMapData),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
        currentStep: this.currentStep,
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },
        onStepCancel: onStepCancel,
        onStepContinue: onStepContinue,
      ),
    );
  }

  _updateFlickrOAuthInstance() {
    FlickrOAuth.getInstance().updateInstance();
  }

  _requestToken() {
    FlickrOAuth.getInstance().requestToken()
      ..then((result) {
        pageContent['oauth_callback_confirmed'] = result;
      })
      ..catchError((error) =>
          throw Exception('FlickrOAuth Instance.requestToken onError $error'));
  }

  _generateAuthorizeUrl() {
    setState(() {
      authUrl =
          '${FlickrConstant.FLICKR_OAUTH_URL}authorize?oauth_token=${FlickrOAuth.getInstance().generateAuthorizeUrl()}';
    });
    print('authUrl = $authUrl');
    setState(() {
      controller.loadUrl(authUrl);
    });
  }

  _accessToken() {
    try {
      FlickrOAuth.getInstance().authParamsMap['oauth_verifier'] =
          pageContent['oauth_verifier'];
      print('Update FlickrOAuth instance authParamsMap["oauth_verifier"]');
    } catch (e) {
      print('_accessToken Add oauth_verifier Error');
    }
    FlickrOAuth.getInstance().accessToken()
      ..then((result) => pageContent['oauth_token_secret'] = result)
      ..catchError((error) => throw Exception(
          'FlickrOAuth Instance()._accessToken onError $error'));
  }

  _loginTest() {
    FlickrOAuth.getInstance().testLogin()
      ..then((result) => pageContent['user_info'] = result)
      ..catchError((error) =>
          throw Exception('FlickrOAuth Instance()._loginTest onError $error'));
  }

  Widget test() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: const Color(0xFF00FF00),
      width: 48.0,
      height: 48.0,
    );
  }
}
