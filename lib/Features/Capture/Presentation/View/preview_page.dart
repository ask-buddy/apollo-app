import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  static String id = '/previewimage';
  const PreviewPage({super.key, required this.imgPath});
  final XFile imgPath;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: Image.file(
            File(widget.imgPath.path),
            fit: BoxFit.cover,
          ))
        ],
      ),
    );
  }
}
