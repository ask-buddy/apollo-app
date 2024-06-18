import 'dart:io';
import 'package:apollo_app/Core/Constants/gen_ai_api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ExplanationPage extends StatefulWidget {
  const ExplanationPage({super.key});

  @override
  State<ExplanationPage> createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {
  File? _image;
  final picker = ImagePicker();
  String contentText = "";

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

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
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  void _getExplanation(Uint8List image) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-pro-latest',
      apiKey: GenAiApiConstants.apiKey,
    );

    const prompt =
        """input adalah soal matematika yang perlu diselesaikan. Tolong jelaskan langkah-langkah penyelesaiannya secara detail , mulai dari konsep dasar hingga penyelesaian soal dengan penjelasaan seperti kepada teman dan tentu menggunakan bahasa indonesia. Berikut adalah struktur atau section yang saya harapkan:

    1. **Memahami Konsep Dasar**:
    - Jelaskan definisi dan istilah yang relevan dengan soal.
    - Berikan contoh kontekstual yang relevan dengan konsep tersebut dengan kehidupan sehari hari dan pemanfaatannya.

    2. **Menjelaskan Teori dan Rumus**:
    - Jelaskan teori di balik konsep yang diperlukan untuk menyelesaikan soal.
    - Tunjukkan bagaimana rumus diturunkan jika memungkinkan.
    - Gunakan diagram atau visualisasi jika diperlukan.

    3. **Langkah-langkah Penyelesaian Soal**:
    - Identifikasi informasi yang diberikan dalam soal.
    - Tentukan apa yang diminta dalam soal.
    - Diskusikan strategi yang bisa digunakan untuk menyelesaikan soal.

    4. **Penyelesaian Soal Langkah demi Langkah**:
    - Berikan solusi langkah demi langkah dengan penjelasan yang detail.
    - Tunjukkan cara menuliskan setiap langkah dengan jelas.

    Selalu gunakan struktur yang sama untuk setiap soal.
    """;
    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart("image/jpeg", image),
      ])
    ];
    final response = await model.generateContent(content);

    print(response.text);
    setState(() {
      contentText = response.text ?? "No Response";
    });
  }

  Uint8List convertFromImage(File image) {
    return image.readAsBytesSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text('Select Image'),
            onPressed: showOptions,
          ),
          Center(
            child: _image == null
                ? Text('No Image selected')
                : Image.file(
                    _image!,
                    height: 100,
                  ),
          ),
          ElevatedButton(
            onPressed: () => _getExplanation(convertFromImage(_image!)),
            child: Text("Explain !"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                contentText,
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
