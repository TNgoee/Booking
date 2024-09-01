import 'package:flutter/material.dart';

import 'avatar_status.dart';

class StatusLine extends StatefulWidget{
  const StatusLine({super.key});

  @override
  State<StatefulWidget> createState() => _StatusLineViewState();
}

class _StatusLineViewState extends State<StatusLine>{
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(top: 20, bottom: 15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                AvatarStatus(note: 'Ghi chú của bạn', image: 'assets/images/th.jpg',),
                AvatarStatus(note: 'Thảo Nguyên', image: 'assets/images/tn.JPG',),
                AvatarStatus(note: 'note', image: 'assets/images/cat.jpg',),
                AvatarStatus(note: 'note', image: 'assets/images/cat.jpg',),
                AvatarStatus(note: 'note', image: 'assets/images/cat.jpg',),
                AvatarStatus(note: 'note', image: 'assets/images/cat.jpg',),
                AvatarStatus(note: 'note', image: 'assets/images/cat.jpg',),
                AvatarStatus(note: 'note', image: 'assets/images/cat.jpg',),
                AvatarStatus(note: 'note', image: 'assets/images/cat.jpg',),
              ],
            ),
          ]
      ),
    );
  }

}