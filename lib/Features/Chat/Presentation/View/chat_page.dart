import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../QuestionGenerator/Presentation/Provider/generate_question_provider.dart';

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

  final List<String> suggestions = [
    '5+5',
    '10/5*2',
    '10/4*5',
    '7+1-5',
    '50/2'
  ];

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    bool isAtBottom = _scrollController.offset >= _scrollController.position.maxScrollExtent;

    setState(() {
      // Add user message
      messages.add({'sender': 'user', 'text': _controller.text});

      // Add AI response
      messages.add({
        'sender': 'ai',
        'text': '${_controller.text}'
      });
    });

    _controller.clear();

    // Scroll to the bottom only if the chat was already at the bottom
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

    // Scroll to the bottom only if the chat was already at the bottom
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

  @override
  Widget build(BuildContext context) {
    final generateQuestionProvider = Provider.of<GenerateQuestionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _refreshChat,
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
            icon: Icon(Icons.settings),
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
                return Align(
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
                );
              },
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = suggestions[index];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(suggestions[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'What do you want to ask?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0), // Rounded corners
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0), // Rounded corners when focused
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0), // Rounded corners when enabled
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: -45 * 3.14159 / 180, // Rotate the icon by -45 degrees
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
