import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:extended_text/extended_text.dart';

class QrCodePage extends StatefulWidget {
  static Widget startPage(BuildContext context) {
    return QrCodePage();
  }

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  Future<String> _barcodeString;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('QRCode Reader Example'),
      ),
      body: new Center(
          child: new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return ExtendedText(
                  snapshot.data != null ? snapshot.data : '',
                  selectionEnabled: true,
                );
              })),
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
