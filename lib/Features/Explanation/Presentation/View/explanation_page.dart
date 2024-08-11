import 'dart:io';
import 'package:apollo_app/Core/Constants/app_label.dart';
import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Constants/htmlstyle.dart';
import 'package:apollo_app/Core/Themes/Textstyle/AB_textstyle.dart';
import 'package:apollo_app/Core/Widget/text/left_text_body.dart';
import 'package:apollo_app/Core/Widget/text/left_text_bold.dart';
import 'package:apollo_app/Core/Widget/text/text_fire_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          // MarkdownView(resultText: explanationProvider.explanation)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: explanationProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        // SIMILAR QUESTION
                        Container(
                          decoration: BoxDecoration(
                            color: ABColors.white
                                .withOpacity(0.04), // Warna background
                            borderRadius: BorderRadius.circular(8), // Radius 8
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const LeftTextBold(text: "Matematika"),
                                SizedBox(height: 12),
                                const LeftTextBold(text: "Aljabar Linear"),
                                SizedBox(height: 28),
                                const LeftTextBold(text: "Your Questions"),
                                SizedBox(height: 8),
                                LeftTextBody(
                                  text:
                                      "Lorem ipsum dolor sit amet consectetur. Non praesent nulla nec tortor eget libero fames. Morbi ac leo scelerisque tellus praesent nisl etiam dolor habitant.",
                                ),
                                SizedBox(height: 12),
                                TextFireClock(
                                  color: ABColors.errorBrightRed,
                                  text1: "Level 5",
                                  icon1: FontAwesomeIcons.fire,
                                  icon2: FontAwesomeIcons.solidClock,
                                  text2: "> 10 Mnt",
                                ),
                              ],
                            ),
                          ),
                        ),

                        //SOLVE QUESTION
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: ABColors.white
                                .withOpacity(0.04), // Warna background
                            borderRadius: BorderRadius.circular(8), // Radius 8
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //SUBJECT
                                const LeftTextBold(text: "Matematika"),
                                const SizedBox(height: 12),
                                //TOPICS
                                const LeftTextBold(text: "Aljabar Linear"),
                                const SizedBox(height: 12),
                                //LEVEL
                                const TextFireClock(
                                  color: ABColors.secondaryGoldYellow,
                                  text1: "Level 4",
                                  icon1: FontAwesomeIcons.fire,
                                  icon2: FontAwesomeIcons.solidClock,
                                  text2: "8-10 Mnt",
                                ),
                                const SizedBox(height: 28),

                                //STRATEGY
                                const LeftTextBold(text: "Strategy"),
                                const SizedBox(height: 8),
                                const LeftTextBody(
                                  text:
                                      "Lorem ipsum dolor sit amet consectetur. Non praesent nulla nec tortor eget libero fames. Morbi ac leo scelerisque tellus praesent nisl etiam dolor habitant.",
                                ),
                                const SizedBox(height: 28),

                                //STEP BY STEP
                                const LeftTextBold(text: "Step By Step"),
                                const SizedBox(height: 8),
                                const LeftTextBody(
                                  text:
                                      "Lorem ipsum dolor sit amet consectetur. Non praesent nulla nec tortor eget libero fames. Morbi ac leo scelerisque tellus praesent nisl etiam dolor habitant.",
                                ),
                                const SizedBox(height: 12),
                                //STEP BY STEP
                                MarkdownView(
                                    resultText:
                                        explanationProvider.explanation),
                                //BUTTON MORE
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      ABTexts.moreExp,
                                      style: ABTextstyle.body1Medium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
      padding: EdgeInsets.all(0),
      child: TeXView(
        renderingEngine: const TeXViewRenderingEngine.katex(),
        child: TeXViewDocument(
          ABStyle.mainStyle + resultText,
          style: const TeXViewStyle(contentColor: Colors.white),
        ),
      ),
    );
  }
}
