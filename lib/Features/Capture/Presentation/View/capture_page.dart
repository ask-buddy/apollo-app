import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../Components/camera_button.dart';
import '../../Components/flash_button.dart';
import '../../Components/galery_button.dart';
import '../Provider/capture_provider.dart';
import 'camera_preview.dart';

class CapturePage extends StatefulWidget {
  final CaptureProvider cameraProvider;
  const CapturePage({super.key, required this.cameraProvider});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  @override
  Widget build(BuildContext context) {
    return _buildCapturePage(widget.cameraProvider, context);
  }

  SafeArea _buildCapturePage(
      CaptureProvider cameraProvider, BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            const CameraPreviewWidget(),

            /// FEATURE
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 122,
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey,
                            ),
                            child: const Center(
                              child: Text("Feature"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// FOOTER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlashButton(isFlashOn: true, onPressed: () {}),
                        CameraButton(
                          onPressed: () {
                            cameraProvider.onCapture(true, context);
                          },
                        ),
                        GaleryButton(onPressed: () {
                          cameraProvider.onCapture(false, context);
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
