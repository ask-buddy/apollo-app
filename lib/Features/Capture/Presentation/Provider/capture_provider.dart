import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../View/cropped_page.dart';

class CaptureProvider with ChangeNotifier {
  CameraController? cameraController;
  late List<CameraDescription> cameras;
  int selectedCameraIndex = 0;

  CaptureProvider() {
    init();
  }

  Future<void> init() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      selectedCameraIndex = 0;
      await initCamera(cameras[selectedCameraIndex]);
    } else {
      print("no camera found");
    }
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    cameraController?.dispose();
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    cameraController!.addListener(() {
      notifyListeners();
    });
    if (cameraController!.value.hasError) {
      print("camera error");
      return;
    }
    try {
      await cameraController!.initialize();
    } catch (e) {
      print("camera error $e");
      return;
    }
    notifyListeners();
  }

  void disposeCamera() {
    cameraController?.dispose();
    cameraController = null;
    notifyListeners();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  Future<void> onCapture(bool captureImage, BuildContext context) async {
    XFile? image;
    final picker = ImagePicker();

    if (captureImage) {
      // Capture the image
      image = await cameraController!.takePicture();
    } else {
      // Get the image from gallery
      image = await picker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      final croppedImage = await cropsImage(image);
      if (croppedImage != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CroppedImage(image: croppedImage),
          ),
        );
      }
    }
  }

  Future<CroppedFile?> cropsImage(XFile image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Select Question",
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
            title: "Selected Foto",
            rotateButtonsHidden: true,
            cancelButtonTitle: "Retake",
            aspectRatioPickerButtonHidden: true,
            doneButtonTitle: "Use Foto"),
      ],
    );
    return croppedFile;
  }
}
