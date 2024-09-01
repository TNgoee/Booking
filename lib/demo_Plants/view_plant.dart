import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewPlant extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const ViewPlant({super.key, required this.onThemeChanged});

  @override
  State<StatefulWidget> createState() => _ViewPlantViewState();
}

class _ViewPlantViewState extends State<ViewPlant> {
  @override
  Widget build(BuildContext context) {
    // Function(bool) onThemeChanged = widget.onThemeChanged;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 70,
        //   flexibleSpace: Container(
        //     decoration:  const BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [
        //           Color(0xFFC12938),
        //           Color(0xFFA82B39),
        //           Color(0xFF94293D),
        //           Color(0xFF7B273D),
        //           Color(0xFF65253C),
        //           Color(0xFF54243C),
        //           Color(0xFF43213B),
        //           Color(0xFF311C36),
        //         ]
        //       )
        //     )
        //   ),
        //
        //   actions: [
        //     IconButton(
        //         onPressed: (){},
        //         icon: const Padding(
        //           padding: EdgeInsets.only(right: 10.0),
        //           child: Icon(Icons.menu, color: Colors.white, size: 30,),
        //         )
        //     ),
        //   ],
        // ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    alignment: FractionalOffset.center,
                    width: double.infinity,
                    // color: Colors.orangeAccent,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFC12938),
                          Color(0xFFA82B39),
                          Color(0xFF94293D),
                          Color(0xFF7B273D),
                          Color(0xFF65253C),
                          Color(0xFF54243C),
                          Color(0xFF43213B),
                          Color(0xFF311C36),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50, top: 30, bottom: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: Container(
                              alignment: FractionalOffset.centerRight,
                              width: double.infinity,
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/dumbell.png',
                                  fit: BoxFit.none,
                                  color: Colors.white,
                                ),
                                const Text(
                                  'FITNESS CLUB',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: FractionalOffset.center,
                            width: double.infinity,
                            child: const Text(
                              'Welcome Back',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 110.0),
                            child: Container(
                              alignment: FractionalOffset.center,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Column(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            side: WidgetStateProperty.all(
                                                const BorderSide(
                                                    color: Colors.white,
                                                    width: 1.8)),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100.0,
                                                vertical: 14),
                                            child: Text(
                                              'SIGN IN',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                          width: VisualDensity.maximumDensity,
                                        ),
                                        FilledButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100.0,
                                                vertical: 14),
                                            child: Text(
                                              'SIGN UP',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: FractionalOffset.center,
                            width: double.infinity,
                            // color: Colors.orangeAccent,
                            child: Column(
                              children: [
                                const Text(
                                  'Login with Social Media',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontFamily: 'Poppins'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/instagram.png',
                                        width: 40,
                                        height: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Image.asset(
                                          'assets/images/twitter.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/facebook.png',
                                        width: 40,
                                        height: 40,
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
