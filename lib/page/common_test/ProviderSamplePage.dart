import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultiScreensPage extends StatelessWidget {
  static final counter = CounterModel();
  static final textSize = 48;

  static Widget startPage(BuildContext context) {
    return MultiScreensPage();
  }

  @override
  Widget build(BuildContext context) {
    return buildProvider();
  }

  static Provider<int> buildProvider() {
    return Provider<int>.value(
      value: textSize,
      child: ChangeNotifierProvider.value(
        value: counter,
        child: Scaffold(
          body: ListView.builder(
            itemBuilder: (context, index) =>
                (index % 2 == 0) ? FirstScreen() : SecondPage(),
            itemCount: 30,
          ),
        ),
      ),
    );
  }
}

class CounterModel with ChangeNotifier {
  int _count = 0;

  int get value => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    return Card(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              'Value: ${_counter.value}',
              style: TextStyle(fontSize: textSize),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Consumer2<CounterModel, int>(
          builder: (context, CounterModel counter, int textSize, _) => Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 80.0, 8.0, 80.0),
              child: Text(
                'Value: ${counter.value}',
                style: TextStyle(
                  fontSize: textSize.toDouble(),
                ),
              ),
            ),
          ),
        ),
        Consumer<CounterModel>(
          builder: (context, CounterModel counter, child) => Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 80.0, 8.0, 80.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  onPressed: counter.decrement,
                  child: new Icon(Icons.thumb_down),
                ),
                FlatButton(
                  color: Colors.red,
                  onPressed: counter.increment,
                  child: new Icon(Icons.thumb_up),
                ),
              ],
            ),
          ),
          child: Icon(Icons.add),
        ),
      ]),
    );
  }
}
