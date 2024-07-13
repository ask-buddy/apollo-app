import 'package:apollo_app/Features/Capture/Presentation/View/preview_page.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/widget/camera_button.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/widget/flash_button.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/widget/galery_button.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/widget/reload_button.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/widget/setting_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  CameraController? cameraController;
  late List<CameraDescription> cameras;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.isNotEmpty) {
        selectedCameraIndex = 0;
        initCamera(cameras[selectedCameraIndex]).then((_) {});
      } else {
        print("no camera found");
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    cameraController?.dispose();
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    if (cameraController!.value.hasError) {
      print("camera error");
    }
    try {
      await cameraController!.initialize();
    } catch (e) {
      print("camera error $e");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              _cameraPreview(),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReloadButton(onPressed: () {}),
                    //SWITCH
                    SettingsButton(onPressed: () {})
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 12,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlashButton(isFlashOn: true, onPressed: () {}),
                        CameraButton(
                          onPressed: () {
                            onCapture(context);
                          },
                        ),
                        GaleryButton(onPressed: () {})
                      ],
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // CAMERA PREVIEW
  Widget _cameraPreview() {
    final size = MediaQuery.of(context).size;
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: 100,
          child: CameraPreview(cameraController!),
        ),
      ),
    );
  }

  void onCapture(BuildContext context) async {
    try {
      // Capture the image
      final XFile picture = await cameraController!.takePicture();
      if (!Navigator.of(context).mounted) return;

      // Navigate to PreviewPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(imgPath: picture),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
