import 'package:flutter/material.dart';

import 'List_Message/message.dart';
import 'Note/status_line.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _homeViewState();
}

// ignore: camel_case_types
class _homeViewState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  late final List<Widget> _cards = [];

  @override
  void initState() {
    super.initState();
    _controller.text;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _addCard() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _cards.add(Card(
          elevation: 20,
          margin: const EdgeInsets.only(bottom: 20),
          color: Colors.redAccent,
          child: ListTile(
            title: Text(
              _controller.text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins'),
            ),
            subtitle: const Center(
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ),
          ),
        ));
        _controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: flipAxis(Axis.horizontal),
        child: Column(
          children: [
            const SizedBox(height: 10),

            //Thanh tìm kiếm
            SizedBox(
              height: 35,
              child: TextField(
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.blueAccent,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 25,
                  ),
                  hintText: 'Tìm kiếm',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            //Dòng ghi chú
            const StatusLine(),
            //Tin nhắn
            const Message(),

            // Expanded(
            //   child: ListView(
            //     children: _cards,
            //   ),
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showModalBottomSheet(
      //       context: context,
      //       isScrollControlled: true,
      //       builder: (context) {
      //         return Padding(
      //           padding: MediaQuery.of(context).viewInsets,
      //           child: SingleChildScrollView(
      //             padding: const EdgeInsets.all(20),
      //             child: Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(top: 20),
      //                   child: TextField(
      //                       controller: _controller,
      //                       decoration: const InputDecoration(
      //                         border: OutlineInputBorder(),
      //                         labelText: 'Enter a value',
      //                         hintText: 'Enter a value',
      //                       )
      //                   ),
      //                 ),
      //                 const SizedBox(height: 50),
      //                 SizedBox(
      //                   width: double.infinity,
      //                   height: 50,
      //                   child: ElevatedButton(
      //                     style: const ButtonStyle(
      //                         backgroundColor: WidgetStatePropertyAll(
      //                             Colors.pinkAccent
      //                         )
      //                     ),
      //                     onPressed: _addCard,
      //                     child: const Text(
      //                       'Add',
      //                       style: TextStyle(color: Colors.white),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    )));
    //   Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 30),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const SizedBox(
    //         height: 50,
    //       ),
    //       // Expanded(
    //       //   child: ListView(
    //       //     children: cards,
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
