import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Core/Utilities/ImagePicker/image_picker_util.dart';
import '../Provider/generate_question_provider.dart';

class GenerateQuestionPage extends StatefulWidget {
  const GenerateQuestionPage({super.key});

  @override
  State<GenerateQuestionPage> createState() => _GenerateQuestionPageState();
}

class _GenerateQuestionPageState extends State<GenerateQuestionPage> {
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
    final generateQuestionProvider = Provider.of<GenerateQuestionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Question from Image'),
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
            onPressed: generateQuestionProvider.isLoading
                ? null
                : () => generateQuestionProvider.generateQuestion(
                      _image!,
                      context,
                    ),
            child: const Text("Submit !"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: generateQuestionProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      generateQuestionProvider.generatedQuestion,
                      softWrap: true,
                    ),
            ),
          ),
        ],
      ),
    );
  }
  
}
