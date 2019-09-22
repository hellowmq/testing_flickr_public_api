import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:extended_text/extended_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This page use a Text to show what the qr code mean
class QrCodePage extends StatefulWidget {
  /// this method can be use as a [WidgetBuilder]
  static Widget startPage(BuildContext context) {
    return QrCodePage();
  }

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
/// This variable store the list of url that transfer to Qrcode
  var urlList = new List<String>();
  var lsView = new ListView();

  buildListView() {
    setState(() {
      lsView = new ListView.builder(
        itemBuilder: (buildContext, index) {
          return Card(
            child: Column(
              children: <Widget>[
                new ListTile(
                  title: ExtendedText(
                    urlList[index],
                    selectionEnabled: true,
                  ),
                  subtitle: Text(index.toString()),
                ),
                Center(
                  child: Container(
                    width: 280,
                    child: QrImage(
                      data: urlList[index],
                      foregroundColor: Color(0xff03291c),
                      embeddedImage: AssetImage('assets/images/genji.png'),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: urlList.length,
      );
      print("-------------------");
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('QRCode Reader Example'),
      ),
      body: Container(
        child: lsView,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          setState(() {
            new QRCodeReader()
                .setAutoFocusIntervalInMs(200)
                .setForceAutoFocus(true)
                .setTorchEnabled(true)
                .setHandlePermissions(true)
                .setExecuteAfterPermissionGranted(true)
                .scan()
                .then((v) {
              urlList.add(
                v != null ? v : '111',
              );
              print(urlList);
              buildListView();
              return;
            });
          });
        },
        tooltip: 'Reader the QRCode',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
