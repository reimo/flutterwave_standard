import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';

import 'flutterwave_in_app_browser.dart';

class StandardPaymentWidget extends StatefulWidget {
  final String webUrl;

  StandardPaymentWidget({required this.webUrl});

  @override
  State<StandardPaymentWidget> createState() =>
      _StandardPaymentWidgetAppState();
}

class _StandardPaymentWidgetAppState extends State<StandardPaymentWidget>
    implements TransactionCallBack {
  InAppBrowserClassSettings settings = InAppBrowserClassSettings(
    browserSettings: InAppBrowserSettings(hideUrlBar: true),
    webViewSettings: InAppWebViewSettings(
      javaScriptEnabled: true,
      cacheEnabled: false,
      clearCache: true,
      cacheMode: CacheMode.LOAD_NO_CACHE,
      incognito: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    final browser = FlutterwaveInAppBrowser(callBack: this);
    browser.openUrlRequest(
      urlRequest: URLRequest(url: WebUri(widget.webUrl)),
      settings: settings,
    );
  }

  @override
  onTransactionComplete(ChargeResponse? chargeResponse) {
    Navigator.pop(context, chargeResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      backgroundColor: Colors.white,
    );
  }
}