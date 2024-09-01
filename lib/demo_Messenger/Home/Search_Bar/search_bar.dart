import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget{
  const SearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }

}