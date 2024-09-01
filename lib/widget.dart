import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final bool loading;
  const MyWidget(this.loading, {super.key});
  @override
  Widget build(BuildContext context) {
    return loading ? const CircularProgressIndicator() : const Text('State');
  }
}
