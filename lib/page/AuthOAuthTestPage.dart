import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wenmq_first_flickr_flutter_app/api/auth.oauth.dart';

class AuthOAuthTestPage extends StatefulWidget {
  @override
  _AuthOAuthTestPageState createState() => _AuthOAuthTestPageState();
}

class _AuthOAuthTestPageState extends State<AuthOAuthTestPage> {
  FlickrOAuth _flickrOAuth = new FlickrOAuth();
  int currentStep = 0;
  static Map<String, String> pageContent = new Map<String, String>();
  static String authUrl = 'www.baidu.com';
  List<Step> steps = [
    Step(
      title: Text('簽署要求'),
      subtitle: Text('_generateSignature'),
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
            ],
          ),
        ),
      ),
    ),
    Step(
      title: Text('取得要求記錄'),
      subtitle: Text('request_token'),
      isActive: true,
      content: Card(
          color: Colors.blue,
          child: SizedBox(
            child: Center(
              child: Text(pageContent.containsKey('oauth_signature')
                  ? pageContent['oauth_signature']
                  : '生成 oauth_signature 失败'),
            ),
            width: 600.0,
            height: 100.0,
          )),
    ),
    Step(
      title: Text('取得使用者授權'),
      subtitle: Text('_authorize'),
      state: StepState.error,
      content: Card(
          color: Colors.yellow,
          child: SizedBox(
            child: Center(
              child: Text("设置state: StepState.editing，自动设置了编辑状态的铅笔标志"),
            ),
            width: 600.0,
            height: 50.0,
          )),
//      Container(
//        height: 400.0,
//        width: 600.0,
//        child: WebView(initialUrl: authUrl),
//      ),
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
            pageContent.addAll(
                Uri.splitQueryString(str.substring(str.indexOf('?') + 1)));
          },
        ),
      ),
//      Card(
//          color: Colors.yellow,
//          child: SizedBox(
//            child: Center(
//              child: Text("设置state: StepState.editing，自动设置了编辑状态的铅笔标志"),
//            ),
//            width: 600.0,
//            height: 50.0,
//          )),
    ),
    Step(
      title: Text('透過 OAuth 呼叫 Flickr API'),
      subtitle: Text('indexed状态'),
      state: StepState.indexed,
      content: Card(
          color: Colors.pink,
          child: SizedBox(
            child: Center(
              child: Text("设置state: StepState.indexed，此状态为默认状态，显示当前步骤的索引"),
            ),
            width: 600.0,
            height: 50.0,
          )),
    ),
    Step(
      title: Text('Finish'),
      state: StepState.indexed,
      content: Card(
          color: Colors.pink,
          child: SizedBox(
            child: Center(
              child: Text("完成"),
            ),
            width: 600.0,
            height: 50.0,
          )),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("透過 Flickr 使用 OAuth"),
          elevation: 0.0,
        ),
        body: _createStepper());
  }

  _generateSignature() {
    _flickrOAuth = new FlickrOAuth();
    setState(() {
      pageContent['oauth_signature'] = _flickrOAuth.generateSignature(
          pathOauth: 'request_token', requestMethod: 'GET');
      print(pageContent['oauth_signature']);
    });
  }

  _requestToken() {
    _flickrOAuth.requestToken()
      ..then((result) => pageContent['oauth_callback_confirmed'] = result)
      ..catchError((error) =>
          throw Exception('_flickrOAuth._requestToken onError $error'));
  }

  _authorize() {
    setState(() {
      authUrl =
          '${FlickrOAuth.oauthUrl}authorize?oauth_token=${_flickrOAuth.authParamsMap['oauth_token']}';
    });
    print(authUrl);
//    _flickrOAuth.authorize()
//      ..then((result) => pageContent['oauth_verifier'] = result)
//      ..catchError(
//          (error) => throw Exception('_flickrOAuth._authorize onError $error'));
  }

  _accessToken() {
    try {
      _flickrOAuth.authParamsMap['oauth_verifier'] =
          pageContent['oauth_verifier'];
    } catch (e) {
      print('_accessToken Add oauth_verifier Error');
    }
    _flickrOAuth.accessToken()
      ..then((result) => pageContent['oauth_token_secret'] = result)
      ..catchError((error) =>
          throw Exception('_flickrOAuth._accessToken onError $error'));
  }

  _loginTest() {
    _flickrOAuth.testLogin()
      ..then((result) => pageContent['user_info'] = result)
      ..catchError(
          (error) => throw Exception('_flickrOAuth._loginTest onError $error'));
  }

  Widget _createStepper() {
    return Stepper(
      steps: steps,
      onStepTapped: (step) {
        ///点击某step直接打开
        setState(() {
          currentStep = step;
        });
      },
      currentStep: this.currentStep,
      onStepCancel: () {
        //回到上一步
        setState(() {
          if (currentStep > 0) {
            currentStep = currentStep - 1;
          } else {
            currentStep = 0;
          }
        });
      },
      onStepContinue: () {
        //下一步
        print(_flickrOAuth.authParamsMap);
        setState(() {
          if (currentStep < steps.length - 1) {
            switch (currentStep) {
              case 0:
                _generateSignature();
                break;
              case 1:
                _requestToken();
                print('await _requestToken()' 'Finish');
                break;
              case 2:
                _authorize();
                print('await _authorize()' 'Finish');
                break;
              case 3:
                _accessToken();
                print('await _accessToken()' 'Finish');
                break;
              case 4:
                _loginTest();
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
        });
      },
    );
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
