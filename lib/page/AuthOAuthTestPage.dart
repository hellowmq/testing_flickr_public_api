import 'package:flutter/material.dart';

class AuthOAuthTestPage extends StatefulWidget {
  @override
  _AuthOAuthTestPageState createState() => _AuthOAuthTestPageState();
}

class _AuthOAuthTestPageState extends State<AuthOAuthTestPage> {
  var stepper = Stepper(
    controlsBuilder: (BuildContext context,
        {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
      return Row(
        children: <Widget>[
          FlatButton(
            onPressed: onStepContinue,
            child: const Text('CONTINUE'),
          ),
          FlatButton(
            onPressed: onStepCancel,
            child: const Text('CANCEL'),
          ),
        ],
      );
    },
    steps: const <Step>[
      Step(
        title: Text('A'),
        content: SizedBox(
          width: 100.0,
          height: 100.0,
        ),
      ),
      Step(
        title: Text('B'),
        content: SizedBox(
          width: 100.0,
          height: 100.0,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Auth OAuth test'),
      ),
      body: stepper,
    );
  }
}
