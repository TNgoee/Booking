import 'package:appthoitiet/demo_Messenger/Home/List_Message/Chat/top_page.dart';
import 'package:flutter/material.dart';

import 'bottom_page.dart';

class ChatPage extends StatefulWidget {
  final String image, name;
  const ChatPage({super.key, required this.image, required this.name});

  @override
  State<StatefulWidget> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = []; // List to hold messages

  void _node() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String img = widget.image;
    String name = widget.name;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: TopPage(name: name, image: img),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              _messages[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          )));
                }),
          ),
        ],
      ),
      bottomSheet: BottomPage(
        controller: _controller,
        messages: _messages,
      ),
    );
  }
}
