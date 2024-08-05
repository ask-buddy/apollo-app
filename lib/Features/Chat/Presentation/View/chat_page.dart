import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> messages = [
    {'sender': 'ai', 'text': 'Hello! How can I assist you today?'}
  ];

  int _selectedSegment = 1;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    bool isAtBottom = _scrollController.offset >= _scrollController.position.maxScrollExtent;

    setState(() {
      messages.add({'sender': 'user', 'text': _controller.text});
      messages.add({'sender': 'ai', 'text': '${_controller.text}'});
    });

    _controller.clear();

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

  void _refreshChat() {
    bool isAtBottom = _scrollController.offset >= _scrollController.position.maxScrollExtent;

    setState(() {
      messages.clear();
      messages.add({'sender': 'ai', 'text': 'Hello! How can I assist you today?'});
    });

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

  void _handleButtonPress(String buttonText) {
    switch (buttonText) {
      case 'Generate Similar Question':
        _generateSimilarQuestion();
        break;
      case 'Solve New Question':
        _refreshChat();
        break;
      case 'Check My Answer':
        _checkMyAnswer();
        break;
      case 'ACT Exam Information':
        _actExamInformation();
        break;
    }
  }

  void _generateSimilarQuestion() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Generate similar question')),
    );
  }

  void _checkMyAnswer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Check my answer')),
    );
  }

  void _actExamInformation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ACT exam information')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final generateQuestionProvider = Provider.of<GenerateQuestionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {

          },
        ),
        title: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSegment = 0;
                  });
                },
                child: Container(
                  width: 57,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _selectedSegment == 0 ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                    ),
                  ),
                  child: Icon(Icons.camera_alt, color: _selectedSegment == 0 ? Colors.white : Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSegment = 1;
                  });
                },
                child: Container(
                  width: 57,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _selectedSegment == 1 ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                  ),
                  child: Icon(Icons.chat, color: _selectedSegment == 1 ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () {
              // Handle settings icon press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
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
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message['sender'] == 'ai'
                              ? Colors.grey[300]
                              : Colors.blue[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message['text']!),
                      ),
                    ),
                    if (message['sender'] == 'ai')
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _buildElevatedButton('Copy', () => _copyToClipboard(message['text']!)),
                                SizedBox(width: 10),
                                _buildElevatedButton('Save to Notebook', () => _addToNotebook(message['text']!)),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 5), // Adjust top padding here
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        _buildElevatedButton('Generate Similar Question', _generateSimilarQuestion),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        _buildElevatedButton('Solve New Question', _refreshChat),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        _buildElevatedButton('Check My Answer', _checkMyAnswer),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        _buildElevatedButton('ACT Exam Information', _actExamInformation),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ) 
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50, // Set the height of the container to match TextField
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'What do you want to ask?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners when focused
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners when enabled
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add space between TextField and send icon
                GestureDetector(
                  onTap: _sendMessage, // Function to call when the area is tapped
                  child: Container(
                    height: 50,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    padding: EdgeInsets.all(8), // Padding around the icon
                    child: Transform.rotate(
                      angle: -45 * 3.25 / 190, // Rotate the icon by -45 degrees
                      child: Icon(
                        Icons.send,
                        color: Colors.black, // Icon color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(String label, Function() onPressed) {
  if (label == 'Copy') {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        padding: EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none, // Remove side border
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(Icons.content_copy, size: 18, color: Colors.black,), // Copy icon
          SizedBox(width: 8), // Adjust spacing between icon and text
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  } else if (label == 'Save to Notebook') {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        padding: EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none, // Remove side border
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(Icons.bookmark, size: 18, color: Colors.black,), // Bookmark icon
          SizedBox(width: 8), // Adjust spacing between icon and text
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  } else {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        padding: EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none, // Remove side border
        elevation: 0,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}





}
