import 'dart:io';
import 'package:apollo_app/Core/Constants/app_label.dart';
import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Constants/htmlstyle.dart';
import 'package:apollo_app/Core/Themes/Textstyle/AB_textstyle.dart';
import 'package:apollo_app/Core/Widget/text/left_text_body.dart';
import 'package:apollo_app/Core/Widget/text/left_text_bold.dart';
import 'package:apollo_app/Core/Widget/text/text_fire_clock.dart';
import 'package:apollo_app/Core/Widget/view/markdown_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../Core/Utilities/ImagePicker/image_picker_util.dart';
import '../../../../Core/Widget/view/similar_question.dart';
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
          // MarkdownView(resultText: explanationProvider.explanation)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: explanationProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Column(
                      children: [
                        // SIMILAR QUESTION
                        SimilarQuestionCard(
                            subject: "subject",
                            topics: "topics",
                            youQuestion: "youQuestion",
                            yourQuestionComplexity: 5,
                            youQuestionTime: "10",
                            newQuestion: "newQuestion",
                            newQuestionComplecxity: 5,
                            newQuestionTime: "10"),

                        //SOLVE QUESTION
                        const SizedBox(height: 24),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
