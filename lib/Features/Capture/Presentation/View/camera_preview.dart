import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

import '../Provider/capture_provider.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CaptureProvider>(context);
    final size = MediaQuery.of(context).size;

    if (cameraProvider.cameraController == null ||
        !cameraProvider.cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: 100,
          child: CameraPreview(cameraProvider.cameraController!),
        ),
      ),
    );
  }
}
