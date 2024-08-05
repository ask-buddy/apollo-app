import 'package:apollo_app/Core/Widget/button/setting_button.dart';
import 'package:apollo_app/Features/Capture/Components/notebook_button.dart';
import 'package:apollo_app/Features/Capture/Presentation/Provider/capture_provider.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/capture_page.dart';
import 'package:apollo_app/Features/Chat/Presentation/View/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String id = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedSegment = 1;
  @override
  void initState() {
    super.initState();
    if (_selectedSegment == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<CaptureProvider>(context, listen: false).init();
      });
    }
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
    Provider.of<CaptureProvider>(context, listen: false).disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CaptureProvider>(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          _selectedSegment == 0
              ? CapturePage(
                  cameraProvider: cameraProvider,
                )
              : const ChatPage(),
          _buildNavbar(),
        ],
      ),
    ));
  }

  Padding _buildNavbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SettingButton(
              onPressed: () {},
              iconColor: _selectedSegment == 0 ? Colors.white : Colors.black,
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSegment = 0;
                      });
                      Provider.of<CaptureProvider>(context, listen: false)
                          .init();
                    },
                    child: Container(
                      width: 57,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _selectedSegment == 0
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(9),
                          bottomLeft: Radius.circular(9),
                        ),
                      ),
                      child: Icon(Icons.camera_alt,
                          color: _selectedSegment == 0
                              ? Colors.white
                              : Colors.black),
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
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(9),
                          bottomRight: Radius.circular(9),
                        ),
                      ),
                      child: Icon(Icons.chat,
                          color: _selectedSegment == 1
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            //SWITCH
            NotebookButton(
              onPressed: () {},
              iconColor: _selectedSegment == 0 ? Colors.white : Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
