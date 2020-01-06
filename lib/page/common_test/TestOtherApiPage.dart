import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wenmq_first_flickr_flutter_app/api/jirengu_api/jirengu_api.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';

class TestOtherApiPage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return TestOtherApiPage();
  }

  @override
  _TestOtherApiPageState createState() => _TestOtherApiPageState();
}

class _TestOtherApiPageState extends State<TestOtherApiPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sendMessage(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => _sendMessage(context),
        ),
      ),
      appBar: AppBar(
        title: Text(this.toString()),
      ),
      body: ListView(
        children: cardResponseList,
      ),
    );
  }

  List<dynamic> strings = ["default text"];

  get cardResponseList => strings.map((result) {
        if (result is WeatherBean) {
          return buildWeatherCard(result);
        } else {
          return createResponseCard(result);
        }
      }).toList();

  Widget buildWeatherCard(WeatherBean text) {
    WeatherBean weatherBean = text;
    Results results = weatherBean.results[0];
    var indexList = (weatherBean.results[0].index);
    var weatherList = (weatherBean.results[0].weatherData);
    var weatherWidgetList = List.generate(
      weatherList.length,
      (index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: weatherList[index].date + ": ",
                        style: TextStyle(color: Colors.black87)),
                    TextSpan(
                        text: weatherList[index].weather + "/",
                        style: TextStyle(color: Colors.blue)),
                    TextSpan(
                        text: weatherList[index].wind + "/",
                        style: TextStyle(color: Colors.blue)),
                    TextSpan(
                        text: weatherList[index].temperature,
                        style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              subtitle: Text(
                indexList[index].des,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 5.0,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Image.network(
                      weatherList[index].dayPictureUrl,
                      fit: BoxFit.fill,
                    ),
                    Image.network(
                      weatherList[index].nightPictureUrl,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );

    return Card(
      color: CommonBuilder.getRandomColor(),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Container(
              child: createTagFlowWidget(getTagStringList(results)),
              padding: EdgeInsets.all(10.0),
            ),
          ),
          Divider(),
          SizedBox(
            width: double.infinity,
            child: Container(
              child: Column(
                children: weatherWidgetList,
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ),
          Divider(),
          buildDataTag(weatherBean),
        ],
      ),
    );
  }

  Container buildDataTag(WeatherBean weatherBean) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            weatherBean.date,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Milonga',
              letterSpacing: 1.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  List<String> getTagStringList(Results results) {
    List<String> strings = new List();
    strings.add(results.currentCity);
    strings.add("pm2.5:" + results.pm25);
    return strings;
  }

  Wrap createTagFlowWidget(List<String> strings) {
    return Wrap(
      spacing: 5.0,
      direction: Axis.horizontal,
      children: strings.map(
        (String result) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 7.5),
            decoration: BoxDecoration(
                color: CommonBuilder.getRandomColor(
                  a: 127,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: SizedBox(
              height: 20.0,
              child: Text(
                result,
                textAlign: TextAlign.center,
              ),
            ),
//            color: CommonBuilder.getRandomColor(),
          );
        },
      ).toList(),
    );
  }

  Widget createResponseCard(String text) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Text(
          text.toUpperCase(),
          textScaleFactor: 1.5,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  _sendMessage(BuildContext context) {
    GetWeather.getWeather((WeatherBean bean) {
      setState(() {
        if (strings.length > 1) {
          strings.removeAt(1);
        }
        strings.insert(1, bean);
      });
    }, (e, re) {
      MQLogger.debugPrint(e);
      ShowMessage.showSnackBarWithContext(context, e.toString());
      MQLogger.debugPrint(re);
    });
  }
}
