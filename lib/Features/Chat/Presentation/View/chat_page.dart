import 'dart:io';

import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Themes/Textstyle/AB_textstyle.dart';
import 'package:apollo_app/Features/Chat/Presentation/Enum/prompt_enum.dart';
import 'package:apollo_app/Features/Chat/Presentation/Providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  late File? capturedImage;
  late VoidCallback callback;
  final GlobalKey<ChatPageState> key;

  ChatPage({required this.key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatProvider _chatProvider;
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    _chatProvider.changePrompt(PromptEnum.normalPrompt);
    FocusManager.instance.primaryFocus?.unfocus();
    bool isAtBottom =
        _scrollController.offset >= _scrollController.position.maxScrollExtent;
    String userText = _controller.text;
    _controller.clear();
    _chatProvider.appendMessages(userText, context);

    if (userText != null &&
        _chatProvider.promptState == PromptEnum.normalPrompt) {
      _chatProvider.doPrompt(userText, context, null);
    }

    if (isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _clearChat() {
    bool isAtBottom =
        _scrollController.offset >= _scrollController.position.maxScrollExtent;

    _chatProvider.clearChat();

    if (isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _addToNotebook(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to notebook')),
    );
  }

  void _generateSimilarQuestion() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Generate similar question')),
    );
    _chatProvider.changePrompt(PromptEnum.generateSimiliarQuestion);
    widget.callback();
  }

  void _solveNewQuestion() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Solve new Question')),
    );
    _chatProvider.changePrompt(PromptEnum.solveNewQuestion);
    widget.callback();
  }

  void _checkMyAnswer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Check my answer')),
    );
    _chatProvider.changePrompt(PromptEnum.checkAnswer);
    widget.callback();
  }

  void _actExamInformation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ACT exam information')),
    );
    _chatProvider.changePrompt(PromptEnum.actExamInfo);
    widget.callback();
  }

  void promptWithImage(File image) {
    _chatProvider.doPrompt(null, context, image);
    print("MASUKKKK");
  }

  @override
  Widget build(BuildContext context) {
    _chatProvider = Provider.of<ChatProvider>(context);
    return _buildChatPage();
  }

  Widget _buildChatPage() {
    return Container(
        margin: const EdgeInsets.only(top: 40),
        child: Container(
          color: ABColors.deepSea,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: _chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final message = _chatProvider.messages[index];
                    return Column(
                      crossAxisAlignment: message['sender'] == 'ai'
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: message['sender'] == 'ai'
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: message['sender'] == 'ai'
                                  ? Colors.white.withOpacity(
                                      0.04) // Background color for 'ai'
                                  : Colors.white.withOpacity(
                                      0.2), // Background color for 'user'
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(message['sender'] ==
                                        'ai'
                                    ? 1
                                    : 16), // Top-left corner radius is 1 for 'ai', otherwise 16
                                topRight: Radius.circular(
                                    16), // Top-right corner radius
                                bottomLeft: Radius.circular(
                                    16), // Bottom-left corner radius
                                bottomRight: Radius.circular(
                                    16), // Bottom-right corner radius
                              ),
                            ),
                            child: Text(
                              message['text']!,
                              style: TextStyle(
                                color: Colors.white, // Text color set to white
                                fontSize: 12, // Font size
                                fontWeight:
                                    FontWeight.w500, // Medium font weight
                              ),
                            ),
                          ),
                        ),
                        if (message['sender'] == 'ai')
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _buildAiButton(message),
                          )
                      ],
                    );
                  },
                ),
              ),
              _buildTextField()
            ],
          ),
        ));
  }

  Widget _buildElevatedButton(
      String label, Function() onPressed, Color backgroundColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none, // Remove side border
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(
            _getIconForLabel(label),
            size: 18,
            color: Colors.white, // Icon color
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white, // Text color
              fontSize: 12, // Font size
              fontWeight: FontWeight.w500, // Medium font weight
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiButton(Map<String, String> message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildElevatedButton(
              'Copy',
              () => _copyToClipboard(message['text']!),
              Colors.white
                  .withOpacity(0.2), // Background color with 20% opacity
            ),
            SizedBox(width: 10),
            _buildElevatedButton(
              'Save to Notebook',
              () => _addToNotebook(message['text']!),
              Colors.white
                  .withOpacity(0.2), // Background color with 20% opacity
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildElevatedButton(
                    'Generate Similar Question',
                    _generateSimilarQuestion,
                    Colors.white
                        .withOpacity(0.2), // Background color with 20% opacity
                  ),
                ],
              ),
              Row(
                children: [
                  _buildElevatedButton(
                    'Solve New Question',
                    _solveNewQuestion,
                    Colors.white
                        .withOpacity(0.2), // Background color with 20% opacity
                  ),
                ],
              ),
              Row(
                children: [
                  _buildElevatedButton(
                    'Check My Answer',
                    _checkMyAnswer,
                    Colors.white
                        .withOpacity(0.2), // Background color with 20% opacity
                  ),
                ],
              ),
              Row(
                children: [
                  _buildElevatedButton(
                    'ACT Exam Information',
                    _actExamInformation,
                    Colors.white
                        .withOpacity(0.2), // Background color with 20% opacity
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      color: ABColors.deepSea, // Background color of the input section
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 40, top: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height:
                    40, // Set the height of the container to match TextField
                child: TextField(
                  controller: _controller,
                  style: ABTextstyle.body2.copyWith(
                      color: ABColors
                          .concrete), // Set input text color to match hint text color
                  decoration: InputDecoration(
                    hintText: 'You can ask me anything...',
                    hintStyle: ABTextstyle.body2.copyWith(
                        color:
                            ABColors.concrete), // Set hint text color to grey
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          4), // Rounded corners when focused
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          4), // Rounded corners when enabled
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10), // Center the hint text vertically
                  ),
                ),
              ),
            ),
            SizedBox(width: 10), // Add space between TextField and send icon
            GestureDetector(
              onTap: _sendMessage, // Function to call when the area is tapped
              child: Container(
                height: 40,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.grey, // Background color
                  borderRadius: BorderRadius.circular(4), // Rounded corners
                ),
                padding: EdgeInsets.all(4), // Padding around the icon
                child: Transform.rotate(
                  angle: -45 * 3.25 / 190, // Rotate the icon
                  child: Icon(
                    Icons.send,
                    color: ABColors.deepSea, // Icon color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper function to get the correct icon for each button label
  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Copy':
        return Icons.content_copy;
      case 'Save to Notebook':
        return Icons.bookmark;
      case 'Generate Similar Question':
        return Icons.question_mark_outlined;
      case 'Solve New Question':
        return Icons.lightbulb;
      case 'Check My Answer':
        return Icons.check_circle_outline;
      case 'ACT Exam Information':
        return Icons.info_outline;
      default:
        return Icons.help_outline; // Default icon
    }
  }
}
