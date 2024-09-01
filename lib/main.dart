import 'package:appthoitiet/Category/add_category.dart';
import 'package:appthoitiet/Color/add_color.dart';
import 'package:appthoitiet/Management/Dashboard.dart';
import 'package:appthoitiet/Product/add_product.dart';
import 'package:appthoitiet/Size/add_size.dart';
import 'package:appthoitiet/login/intro.dart';
import 'package:appthoitiet/login/login.dart';
import 'package:appthoitiet/manager_account/list_account.dart';
import 'package:appthoitiet/model/color_model.dart';
import 'package:appthoitiet/model/size_model.dart';
import 'package:appthoitiet/pages/home.dart';
import 'package:appthoitiet/uploadImages/upload_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA9Klql1MXvSOA_TRNRYCfGNwlKrbKIOTk",
        authDomain: "appthoitiet-23fa9.firebaseapp.com",
        projectId: "appthoitiet-23fa9",
        storageBucket: "appthoitiet-23fa9.appspot.com",
        messagingSenderId: "187709837472",
        appId: "1:187709837472:web:b943e2f2e855d81971b9c5",
        measurementId: "G-2E4572499H",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otelia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Dashboard(),
        '/home': (context) => const Home(),
        '/account': (context) => const ListAccount(),
        '/login': (context) => const Login(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'demo_Messenger/main_view.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (kIsWeb) {
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//         apiKey: "AIzaSyA9Klql1MXvSOA_TRNRYCfGNwlKrbKIOTk",
//         authDomain: "appthoitiet-23fa9.firebaseapp.com",
//         projectId: "appthoitiet-23fa9",
//         storageBucket: "appthoitiet-23fa9.appspot.com",
//         messagingSenderId: "187709837472",
//         appId: "1:187709837472:web:b943e2f2e855d81971b9c5",
//         measurementId: "G-2E4572499H",
//       ),
//     );
//   } else {
//     await Firebase.initializeApp();
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<StatefulWidget> createState() => _MyApp();
// }

// class _MyApp extends State<MyApp> {
//   ThemeMode _themeMode = ThemeMode.light;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData.light(),
//         darkTheme: ThemeData.dark(),
//         themeMode: _themeMode,
//         home: MainView(
//           onThemeChanged: _changeTheme,
//         ));
//   }

//   void _changeTheme(bool isDark) {
//     setState(() {
//       _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
//     });
//   }
// }
