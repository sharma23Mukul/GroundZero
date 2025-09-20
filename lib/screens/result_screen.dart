import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class ResultScreen extends StatefulWidget {
  final String? htmlFileName;

  const ResultScreen({super.key, this.htmlFileName});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _htmlContent = "";
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _loadHtmlFile();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  Future<void> _loadHtmlFile() async {
    String fileName = widget.htmlFileName ?? "Delhi_GW_Rainfall_Forecasts_Map.html";
    String html = await rootBundle.loadString("assets/html/$fileName");
    setState(() {
      _htmlContent = html;
    });
    _controller.loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: _htmlContent.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller),
    );
  }
}