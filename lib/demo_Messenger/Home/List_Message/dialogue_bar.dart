

import 'package:flutter/material.dart';

import 'Chat/chat_page.dart';

class DialogueBar extends StatefulWidget{
  final String name, image;
  const DialogueBar({super.key, required this.name, required this.image});

  @override
  State<StatefulWidget> createState() => _DialogueBar();
}

class _DialogueBar extends State<DialogueBar>{

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String img = widget.image;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ChatPage(name: name, image: img),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Slide the new screen in from the right
              const begin = Offset(1.0, 0.0); // (1.0, 0.0) means start from right
              const end = Offset.zero; // End at the original position
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: SizedBox(
        height: 65,
        child: Card(
            elevation: 0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image(
                    image: AssetImage(img),
                    height: 58,
                    width: 58,
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Chưa có cuộc trò chuyện nào',
                        style: TextStyle(
                            fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );

  }
}

// class SecondScreen extends StatelessWidget {
//   final String name;
//   const SecondScreen({super.key, required this.name});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(name),
//         actions: [
//           Row(
//             children: [
//               IconButton(onPressed: (){}, icon: const Icon(Icons.call)),
//               IconButton(onPressed: (){}, icon: const Icon(Icons.video_call_rounded)),
//               IconButton(onPressed: (){}, icon: const Icon(Icons.label))
//             ],
//           )
//         ],
//         // leading: Builder(
//         //     builder: (context) => const Row(
//         //       children: [
//         //         // Icon(Icons.keyboard_arrow_left_rounded)
//         //         // Icon(Icons.call),
//         //         // Icon(Icons.video_call_rounded),
//         //         // Icon(Icons.new_label_rounded)
//         //       ],
//         //     )
//         // ),
//       ),
//       body: const Center(
//         child: Text('You are on the second screen!'),
//       ),
//     );
//   }
// }

// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => trangmoi()),
// );