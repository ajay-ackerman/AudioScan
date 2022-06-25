import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_viewer/page/audio_to_pdf_page.dart';
import 'package:pdf_viewer/page/homePage.dart';
import 'package:pdf_viewer/page/pdf_viewer_example.dart';
import 'package:pdf_viewer/page/loginMain.dart';
import 'package:pdf_viewer/page/signup.dart';

import 'api/pdf_api.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'AudioScan';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) => SignupPage()
        },
        title: title,
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          fontFamily: 'Cardo', //Color.fromARGB(255, 124, 25, 245),
        ),
        home: const Login(
          title: '',
        ),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentindex = 1;
  final pages = [
    Audio_pdf(),
    Home(),
    const Login(
      title: 'Welcome',
    )
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: pages[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentindex,
            backgroundColor: Color.fromARGB(255, 0, 128, 167),
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Color.fromARGB(131, 251, 255, 251),
            onTap: (index) => setState(() => currentindex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.mic_external_on),
                label: "Audio to PDF",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ]),
      );
}
