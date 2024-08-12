import 'dart:io';

import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Features/Chat/Presentation/Enum/prompt_enum.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import '../../Components/camera_button.dart';
import '../../Components/flash_button.dart';
import '../../Components/galery_button.dart';
import '../Provider/capture_provider.dart';
import 'camera_preview.dart';

typedef OnDismissWithImage = void Function(File image);
typedef OnChangePrompt = void Function(PromptEnum prompt);

class CapturePage extends StatefulWidget {
  final CaptureProvider cameraProvider;
  final OnDismissWithImage callBackWithImage;
  final OnChangePrompt callBackChangePrompt;
  final GlobalKey<CapturePageState> key;
  CapturePage(
      {required this.key,
      required this.cameraProvider,
      required this.callBackWithImage,
      required this.callBackChangePrompt})
      : super(key: key);

  @override
  State<CapturePage> createState() => CapturePageState();
}

class CapturePageState extends State<CapturePage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  bool _isFlashOn = false;
  bool isChipButtonHidden = true;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                  isChipButtonHidden
                      ? const SizedBox()
                      : Center(
                          child: SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width, // Lebar layar penuh
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                  ),
                                  _buildButton(0, 'Similar Question',
                                      PromptEnum.generateSimiliarQuestion),
                                  _buildButton(1, 'Question Solver',
                                      PromptEnum.solveNewQuestion),
                                  _buildButton(2, 'Answer Checker',
                                      PromptEnum.checkAnswer),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 24),

                  /// FOOTER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlashButton(
                            isFlashOn: _isFlashOn, onPressed: _toggleFlash),
                        CameraButton(
                          onPressed: () async {
                            await cameraProvider.onCapture(true, context);
                            if (cameraProvider.capturedImage != null) {
                              widget.callBackWithImage(
                                  cameraProvider.capturedImage!);
                            }
                          },
                        ),
                        GaleryButton(onPressed: () async {
                          await cameraProvider.onCapture(false, context);
                          widget.callBackWithImage(
                            cameraProvider.capturedImage!,
                          );
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

  Widget _buildButton(int index, String text, PromptEnum promptType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedIndex = index;
          });
          widget.callBackChangePrompt(promptType);
          _scrollToIndex(index);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor:
                _selectedIndex == index ? ABColors.accent : ABColors.darkGray,
            foregroundColor:
                _selectedIndex == index ? ABColors.black : ABColors.white,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        child: Text(text),
      ),
    );
  }

  void _scrollToIndex(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double buttonWidth = 130;
      double offset = 0;
      if (index == 0) {
        offset = (buttonWidth * index + (index * 10 * index));
      } else {
        offset = (buttonWidth * index + (index * 10 * index) + 20);
      }
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _toggleFlash() async {
    print("oke");
    try {
      if (_isFlashOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        print("state");
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      print(e);
    }
  }
}
