import 'package:flutter/material.dart';

class BottomSheetCustom extends StatefulWidget{
  const BottomSheetCustom({super.key});

  @override
  State<StatefulWidget> createState() => _BottomSheetCustomViewState();
}

class _BottomSheetCustomViewState extends State<BottomSheetCustom>{
  final TextEditingController _controller = TextEditingController();
  late final List<Widget> _cards = [];


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
              // Text(
              //   _controller.text,
              //   style: const TextStyle(
              //       color: Colors.white,
              //       fontSize: 10,
              //   ),
              // ),
            ),
          ),
        ));
        _controller.clear();
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a value',
                      hintText: 'Enter a value',
                    )
                ),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.pinkAccent
                        )
                    ),
                    onPressed: _addCard,
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}