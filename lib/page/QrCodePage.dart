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
        itemBuilder: (bc, index) {
          return Card(
            child: Column(
              children: <Widget>[
                new ListTile(
                  title: ExtendedText(
                    urlList[index],
                    selectionEnabled: true,
                  ),
                  subtitle: Text(index.toString()),
//                  onTap: () async {
//                    showBigQrCodePic(context, viewList[index]);
//                  },
                ),
                Center(
                  child: Container(
                    width: 280,
                    child: QrImage(
                      data: urlList[index],
                      foregroundColor: Color(0xff03291c),
                      embeddedImage: AssetImage('assets/images/logo_yakka.png'),
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

  Future<void> showBigQrCodePic(BuildContext context, String textContent) {
    final qrCodeImage = Center(
      child: Container(
        width: 280,
        child: QrImage(
          data: textContent,
          foregroundColor: Color(0xff03291c),
          embeddedImage: AssetImage('assets/images/logo_yakka.png'),
        ),
      ),
    );
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                qrCodeImage,
//               Text('You will never be satisfied.'),
//               Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('QRCode Reader Example'),
      ),
      body: Container(
        child: lsView,
//        color: Colors.red,
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
