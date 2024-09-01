import 'package:flutter/material.dart';

class DrawerItem extends StatefulWidget{

  final Icon icon;
  final String content;
  final int index;

  const DrawerItem({
    super.key,
    required this.index,
    required this.icon,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() => _DrawerItemViewState();
}

class _DrawerItemViewState extends State<DrawerItem>{
  late int curIdx = 0;

  @override
  void initState() {
    super.initState();
    curIdx;
  }

  @override
  Widget build(BuildContext context) {
    // int index = widget.currentIndex;
    int idx = widget.index;
    Icon i = widget.icon;
    String c = widget.content;

    return ListTile(
      leading: Icon(
        i.icon,
        // color: Colors.black,
      ),
      selected: curIdx == idx,
      title: Text(
        c,
        style: const TextStyle(
          // color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      onTap: () {
        setState(() {
          curIdx = idx;
        });
        Navigator.pop(context);
        _showSnackBar(context, '[$c] is clicked!');
      },
    );
  }

  void _showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}