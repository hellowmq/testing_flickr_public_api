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
  Future<String> _barcodeString;
  var viewList = new List<Widget>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('QRCode Reader Example'),
      ),
      body: new Container(
        child: new FutureBuilder<String>(
          future: _barcodeString,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            viewList.add(
              ExtendedText(
                snapshot.data != null ? snapshot.data : '',
                selectionEnabled: true,
              ),
            );
            return ListView(
              children: viewList,
            );
          },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          setState(() {
            _barcodeString = new QRCodeReader()
                .setAutoFocusIntervalInMs(200)
                .setForceAutoFocus(true)
                .setTorchEnabled(true)
                .setHandlePermissions(true)
                .setExecuteAfterPermissionGranted(true)
                .scan();
          });
        },
        tooltip: 'Reader the QRCode',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
