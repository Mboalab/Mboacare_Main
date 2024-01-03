// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({Key? key, required this.title, required this.url})
      : super(key: key);

  final url;
  final String title;
  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  late WebViewController _webViewController;
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.buttonColor),
          backgroundColor: AppColors.registerCard,
          elevation: 0,
          title: Text(
            widget.url,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              color: AppColors.buttonColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.buttonColor,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color:
                  _progress == 1.0 ? Colors.transparent : AppColors.buttonColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.url,
                zoomEnabled: true,
                onProgress: (progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
