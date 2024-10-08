import 'dart:io';

import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Widget/button/setting_button.dart';
import 'package:apollo_app/Features/Capture/Components/notebook_button.dart';
import 'package:apollo_app/Features/Capture/Presentation/Provider/capture_provider.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/capture_page.dart';
import 'package:apollo_app/Features/Chat/Presentation/Enum/prompt_enum.dart';
import 'package:apollo_app/Features/Chat/Presentation/View/chat_page.dart';
import 'package:apollo_app/Features/Common/Setting/View/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String id = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

typedef CallBackContext = Function(BuildContext context);

class _HomePageState extends State<HomePage> {
  final GlobalKey<ChatPageState> _chatPageKey = GlobalKey<ChatPageState>();
  final GlobalKey<CapturePageState> _capturePageKey =
      GlobalKey<CapturePageState>();

  int _selectedSegment = 1;
  late CaptureProvider _captureProvider;
  late File? capturedImage;
  late ChatPage chatPage;
  late CapturePage capturePage;
  PromptEnum? _promptState = PromptEnum.generateSimiliarQuestion;
  bool _isChipsButtonHidden = false;
  @override
  void initState() {
    super.initState();

    if (_selectedSegment == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<CaptureProvider>(context, listen: false).init();
      });
    }
  }

  void _invokeDoPromptOnChat(File image) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("CHECK!");
      if (_promptState != null && !_isChipsButtonHidden) {
        _chatPageKey.currentState?.chatProvider.changePrompt(_promptState!);
      }
      _chatPageKey.currentState?.promptWithImage(image);
      print("CHECK SINI");
      setState(() {
        _isChipsButtonHidden = false;
      });
    });
  }

  void _invokeHideChips(bool newState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _capturePageKey.currentState?.isChipButtonHidden = newState;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _captureProvider = Provider.of<CaptureProvider>(context, listen: false);
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle camera initialization and disposal based on the selected segment
    final cameraProvider = Provider.of<CaptureProvider>(context, listen: false);

    if (_selectedSegment == 0) {
      cameraProvider.init();
    } else {
      cameraProvider.disposeCamera();
    }
  }

  @override
  void dispose() {
    _captureProvider.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chatPage = ChatPage(
      key: _chatPageKey,
    );
    final cameraProvider = Provider.of<CaptureProvider>(context);
    capturePage = CapturePage(
      cameraProvider: cameraProvider,
      callBackWithImage: (File image) {
        setState(() {
          _selectedSegment = 1;
        });
        _invokeDoPromptOnChat(image);
      },
      callBackChangePrompt: (prompt) {
        _promptState = prompt;
      },
      key: _capturePageKey,
    );
    chatPage.callback = () {
      setState(() {
        _isChipsButtonHidden = true;
        _invokeHideChips(_isChipsButtonHidden);
        _selectedSegment = 0;
        cameraProvider.init();
      });
    };
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          _selectedSegment == 0 ? capturePage : chatPage,
          _buildNavbar(
            onPressedSetting: (context) => navigateToSetting(context),
          ),
        ],
      ),
    ));
  }

  Widget _buildNavbar({required CallBackContext onPressedSetting}) {
    return Container(
      color: ABColors.deepSea,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SettingButton(
                  onPressed: () => onPressedSetting(context),
                  iconColor: Colors.white,
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSegment = 0;
                            _isChipsButtonHidden = false;
                            _invokeHideChips(_isChipsButtonHidden);
                          });
                          Provider.of<CaptureProvider>(context, listen: false)
                              .init();
                        },
                        child: Container(
                          width: 57,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _selectedSegment == 0
                                ? ABColors.accent
                                : Colors.white.withOpacity(0.25),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(9),
                              bottomLeft: Radius.circular(9),
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 16, // Set icon size to 16x16
                            color: _selectedSegment == 0
                                ? Colors.black
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSegment = 1;
                          });
                          Provider.of<CaptureProvider>(context, listen: false)
                              .disposeCamera();
                        },
                        child: Container(
                          width: 57,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _selectedSegment == 1
                                ? ABColors.accent
                                : Colors.white.withOpacity(0.25),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(9),
                              bottomRight: Radius.circular(9),
                            ),
                          ),
                          child: Icon(
                            Icons.chat,
                            size: 16, // Set icon size to 16x16
                            color: _selectedSegment == 1
                                ? Colors.black
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //SWITCH
                NotebookButton(
                  onPressed: () {},
                  iconColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  navigateToSetting(BuildContext context) {
    Navigator.pushNamed(context, SettingPage.id);
  }
}
