import 'dart:io';
import 'package:apollo_app/Core/Constants/htmlstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';

import '../../../../Core/Utilities/ImagePicker/image_picker_util.dart';
import '../Provider/explanation_provider.dart';

class ExplanationPage extends StatefulWidget {
  const ExplanationPage({super.key});

  @override
  State<ExplanationPage> createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {
  File? _image;

  //Image Picker function to get image from gallery
  Future _getImageFromGallery() async {
    final pickedFile = await ImagePickerUtil.shared.getImageFromGallery();

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future _getImageFromCamera() async {
    final pickedFile = await ImagePickerUtil.shared.getImageFromCamera();

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              _getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              _getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final explanationProvider = Provider.of<ExplanationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: showOptions,
            child: const Text('Select Image'),
          ),
          Center(
            child: _image == null
                ? const Text('No Image selected')
                : Image.file(
                    _image!,
                    height: 100,
                  ),
          ),
          ElevatedButton(
            onPressed: explanationProvider.isLoading
                ? null
                : () => explanationProvider.explainQuestion(
                      _image!,
                      context,
                    ),
            child: const Text("Explain !"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: explanationProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MarkdownView(resultText: explanationProvider.explanation),
            ),
          ),
        ],
      ),
    );
  }
}

class MarkdownView extends StatelessWidget {
  const MarkdownView({
    super.key,
    required this.resultText,
  });

  final String resultText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TeXView(
        renderingEngine: const TeXViewRenderingEngine.katex(),
        child: TeXViewDocument(
          ABStyle.mainStyle + resultText,
          style: const TeXViewStyle(
            padding: TeXViewPadding.only(left: 8, right: 8, bottom: 24),
          ),
        ),
      ),
    );
  }
}
