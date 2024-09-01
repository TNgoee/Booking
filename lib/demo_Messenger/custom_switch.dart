
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget{
  const CustomSwitch({super.key});

  @override
  State<StatefulWidget> createState() => _CustomSwitchViewState();
}

class _CustomSwitchViewState extends State<CustomSwitch>{
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSwitched = !_isSwitched;
                });
              },
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: 100.0, // Length of the switch
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: _isSwitched ? Colors.green : Colors.grey,
                    ),
                  ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    alignment: _isSwitched
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 40.0, // Size of the thumb
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}