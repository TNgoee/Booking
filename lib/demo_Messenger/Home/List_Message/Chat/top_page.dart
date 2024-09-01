import 'package:appthoitiet/demo_Messenger/Home/List_Message/Chat/phone_call.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  final String name, image;
  const TopPage({super.key, required this.name, required this.image});

  @override
  State<StatefulWidget> createState() => _TopPageViewState();
}

class _TopPageViewState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String img = widget.image;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.grey,
          title: Row(
            children: [
              Stack(children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image(
                    image: AssetImage(img),
                    height: 40,
                    width: 40,
                  ),
                ),
                Positioned(
                  bottom: 0, // Position the dot slightly above the bottom edge
                  right:
                      0, // Position the dot slightly to the left of the right edge
                  child: Container(
                    width: 13, // Width of the dot
                    height: 13, // Height of the dot
                    decoration: BoxDecoration(
                      color: Colors.green, // Green color for the active status
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors
                            .white, // White border to separate the dot from the avatar
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const Text(
                    'Đang hoạt động',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      const HomeScreen();
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Colors.blueAccent,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.video_call_rounded,
                      color: Colors.blueAccent,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.label,
                      color: Colors.blueAccent,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
