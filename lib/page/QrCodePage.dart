import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:extended_text/extended_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';

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

  updateListView() {
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
        onPressed: scan,
        tooltip: 'Reader the QRCode',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        urlList.add(barcode);
        return;
      });
      updateListView();
    } on Exception catch (e) {
      setState(() {
        return 'Unknown error: $e';
      });
    }
  }
}
