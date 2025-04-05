import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ManHinhBangGiaChungKhoan extends StatefulWidget {
  @override
  _ManHinhBangGiaChungKhoanState createState() => _ManHinhBangGiaChungKhoanState();
}

class _ManHinhBangGiaChungKhoanState extends State<ManHinhBangGiaChungKhoan> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse('https://iboard.ssi.com.vn/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bảng Giá Chứng Khoán')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
