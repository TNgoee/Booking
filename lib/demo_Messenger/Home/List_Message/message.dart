import 'package:flutter/material.dart';

import 'dialogue_bar.dart';

class Message extends StatefulWidget{
  const Message({super.key});

  @override
  State<StatefulWidget> createState() => _MessageViewState();
}

class _MessageViewState extends State<Message>{
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Thảo Nguyên', image: 'assets/images/tn.JPG',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Trung Hoàng', image: 'assets/images/th.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),
        Card(
          elevation: 0,
          child: DialogueBar(name: 'Không rõ danh tính', image: 'assets/images/cat.jpg',),
        ),

      ],
    );
  }

}