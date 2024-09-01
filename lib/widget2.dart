import 'package:flutter/material.dart';

class MyWidget2 extends StatefulWidget {
  final bool loading;

  const MyWidget2(this.loading, {super.key});

  @override
  State<StatefulWidget> createState() {
    return MyWidget3();
  }
}

class MyWidget3 extends State<MyWidget2> {
  late bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = widget.loading;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : FloatingActionButton(onPressed: onClickButton);
  }

  void onClickButton() {
    setState(() {
      _loading = true;
    });
  }
}
