// @dart = 2.9
// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  MyHomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: textEditingController,
              maxLength: 10,
              onSaved: (phoneNumber) {
                textEditingController.text = "+91" + phoneNumber.toString();
              },
            ),
            RaisedButton(
              child: const Text("Launch Phone URL"),
              onPressed: () {
                _launchPhoneURL(textEditingController.text);
              },
            ),
            RaisedButton(
              child: const Text("Call Number"),
              onPressed: () {
                _callNumber(textEditingController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}

_launchPhoneURL(String phoneNumber) async {
  String url = 'tel:' + phoneNumber;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
