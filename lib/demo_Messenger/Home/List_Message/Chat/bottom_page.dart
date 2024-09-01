import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomPage extends StatefulWidget {
  final TextEditingController controller;
  final List<String> messages;
  const BottomPage(
      {super.key, required this.controller, required this.messages});

  @override
  State<StatefulWidget> createState() => _BottomPageViewState();
}

class _BottomPageViewState extends State<BottomPage> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  void _sendMessage() {
    TextEditingController controller = widget.controller;
    List<String> messages = widget.messages;
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add(controller.text);
        controller.clear(); // Clear the TextField after sending
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  File? _image; // Variable to store the captured image

  Future<void> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = widget.controller;
    return BottomAppBar(
      child: Row(
        children: <Widget>[
          if (!_isFocused)
            Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.blueAccent,
                    )),
                IconButton(
                    onPressed: () {
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (_image != null)
                            Image.file(
                              _image!,
                              width: 300,
                              height: 300,
                            )
                          else
                            const Text('No image captured'),
                          const SizedBox(height: 20),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: _pickImageFromCamera,
                            iconSize: 50,
                          ),
                        ],
                      );
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.blueAccent,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blueAccent,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mic,
                      color: Colors.blueAccent,
                    )),
              ],
            )
          else
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.blueAccent,
                )),
          Expanded(
            child: SingleChildScrollView(
              child: TextField(
                focusNode: _focusNode,
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Aa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  suffixIcon: const Icon(
                    Icons.tag_faces_rounded,
                    color: Colors.blueAccent,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                ),
              ),
            ),
          ),
          if (!_isFocused)
            IconButton(
              icon: const Icon(
                Icons.bubble_chart_outlined,
                size: 30,
                color: Colors.blueAccent,
              ),
              onPressed: () {},
            )
          else
            IconButton(
              icon: const Icon(
                Icons.send,
                size: 30,
                color: Colors.blueAccent,
              ),
              onPressed: _sendMessage,
            )
        ],
      ),
    );
  }
}
