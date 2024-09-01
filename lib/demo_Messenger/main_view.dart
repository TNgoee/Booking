import 'package:appthoitiet/demo_Messenger/bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'Drawer/drawer.dart';
import 'Home/home.dart';

class MainView extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const MainView({super.key, required this.onThemeChanged});

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _children = const [
    Home(),
    Center(child: Text('Story Screen')),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index when a tab is tapped
    });
  }

  @override
  Widget build(BuildContext context) {
    Function(bool) onThemeChanged = widget.onThemeChanged;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Đoạn chat',
            style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const BottomSheetCustom());
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.blueAccent,
              ))
        ],
        // backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: DrawerMenu(
        currentIndex: _currentIndex,
        onThemeChanged: onThemeChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // backgroundColor: Colors.white70,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_chat_unread_rounded),
            label: 'Đoạn chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_history_rounded),
            label: 'Tin',
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.pinkAccent,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
    ));
  }
}
