import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:extended_text/extended_text.dart';

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
  var viewList = new List<String>();
  var lsView = new ListView();

  buildListView() {
    setState(() {
      lsView = new ListView.builder(
        itemBuilder: (bc, index) {
          return new ListTile(
            title: ExtendedText(
              viewList[index],
              selectionEnabled: true,
            ),
            subtitle: Text(index.toString()),
          );
        },
        itemCount: viewList.length,
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
        color: Colors.red,
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
              viewList.add(
                v != null ? v : '111',
              );
              print(viewList);
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
