import 'package:flutter/material.dart';
import '../color_theme.dart';
import 'drawer_item.dart';

class DrawerMenu extends StatefulWidget {
  final int currentIndex;
  final Function(bool) onThemeChanged;
  const DrawerMenu(
      {super.key, required this.currentIndex, required this.onThemeChanged});

  @override
  State<StatefulWidget> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerMenu> {
  // int _selectedIndex = 0;
  final colorProvider = ColorProvider();

  @override
  Widget build(BuildContext context) {
    // int index = widget.currentIndex;
    Function(bool) onThemeChanged = widget.onThemeChanged;
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          toolbarHeight: 60,
          leadingWidth: double.infinity,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to a new screen when the card is clicked
                        Navigator.push(
                          context,
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: TextField(
                                      decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter a value',
                                    hintText: 'Enter a value',
                                  )),
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.pinkAccent)),
                                    onPressed: () {},
                                    child: const Text(
                                      'Add',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ) as Route<Object?>,
                          // MaterialPageRoute(builder: (context) => const NewScreen()),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.network(
                              'https://gcs.tripi.vn/public-tripi/tripi-feed/img/474296CBv/avatar-facebook-2.jpg',
                              scale: 17,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Chung Hoàng',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.settings,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const DrawerItem(
                      index: 0,
                      icon: Icon(Icons.chat_bubble),
                      content: 'Đoạn chat'),
                  const DrawerItem(
                      index: 1,
                      icon: Icon(Icons.store),
                      content: 'Marketplace'),
                  const DrawerItem(
                      index: 2,
                      icon: Icon(Icons.chat),
                      content: 'Tin nhắn đang chờ'),
                  const DrawerItem(
                      index: 3,
                      icon: Icon(Icons.storage_rounded),
                      content: 'Kho lưu trữ'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (value) {
                            setState(() {
                              onThemeChanged(
                                  value); // Update the state of the switch
                            });
                          },
                          activeColor: colorProvider.getColor('white'),
                          // Color when switch is ON
                          activeTrackColor: colorProvider.getColor('white'),

                          inactiveThumbColor: colorProvider.getColor('black'),
                          // Color when switch is OFF
                          inactiveTrackColor: colorProvider.getColor('black'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class NewScreen extends StatelessWidget {
//   const NewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Screen'),
//       ),
//       body: const Center(
//         child: Text(
//           'Hello! You clicked the card.',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }