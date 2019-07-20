import 'package:flutter/material.dart';

class AuthOAuthTestPage extends StatefulWidget {
  @override
  _AuthOAuthTestPageState createState() => _AuthOAuthTestPageState();
}

class _AuthOAuthTestPageState extends State<AuthOAuthTestPage> {
  int currentStep = 0;
  List<Step> steps = [
    Step(
      title: Text('stepTitle A'),
      subtitle: Text('disabled状态'),
      state: StepState.disabled,
      content: Card(
          color: Colors.red,
          child: SizedBox(
            child: Center(
              child: Text(
                  "设置state: StepState.disabled，注意标题setTitle A字体颜色为灰色,此时该Step"
                  "不会响应onStepTapped 事件"),
            ),
            width: 600.0,
            height: 100.0,
          )),
    ),
    Step(
      title: Text('stepTitle B'),
      subtitle: Text('activie为true'),
      isActive: true,
      content: Card(
          color: Colors.blue,
          child: SizedBox(
            child: Center(
              child: Text("设置isActive: true,此时步骤2为蓝色"),
            ),
            width: 600.0,
            height: 100.0,
          )),
    ),
    Step(
      title: Text('stepTitle C'),
      subtitle: Text('error状态'),
      state: StepState.error,
      content: Card(
          color: Colors.red,
          child: SizedBox(
            child: Center(
              child: Text("设置state: StepState.error，表明此步骤错误，为进度条显示红色警告"),
            ),
            width: 600.0,
            height: 100.0,
          )),
    ),
    Step(
      title: Text('stepTitle D'),
      subtitle: Text('editing状态'),
      state: StepState.editing,
      content: Card(
          color: Colors.yellow,
          child: SizedBox(
            child: Center(
              child: Text("设置state: StepState.editing，自动设置了编辑状态的铅笔标志"),
            ),
            width: 600.0,
            height: 50.0,
          )),
    ),
    Step(
      title: Text('stepTitle E'),
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
      title: Text('stepTitle F'),
      subtitle: Text('complete状态'),
      state: StepState.complete,
      content: Card(
          color: Colors.pink,
          child: SizedBox(
            child: Center(
              child: Text("设置state: StepState.complete，此状态为默认状态，显示对号"),
            ),
            width: 600.0,
            height: 50.0,
          )),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Stepper简单使用")),
          elevation: 0.0,
        ),
        body: _createStepper());
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
        setState(() {
          if (currentStep < steps.length - 1) {
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
