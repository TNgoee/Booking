import 'package:flutter/material.dart';

class AvatarStatus extends StatefulWidget{
  final String note, image;
  const AvatarStatus({super.key, required this.note, required this.image});

  @override
  State<StatefulWidget> createState() => _AvatarStatusViewState();
}

class _AvatarStatusViewState extends State<AvatarStatus>{
  @override
  Widget build(BuildContext context) {
    String note = widget.note;
    String img = widget.image;
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image(
                image: AssetImage(img),
                height: 58,
                width: 58,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
              child: Text(
                  note,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                  ),
                ),
            ),
          ],
            ),
      );
  }
}