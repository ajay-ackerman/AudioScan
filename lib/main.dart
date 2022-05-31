// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_viewer/page/audio_to_pdf_page.dart';
import 'package:pdf_viewer/page/homePage.dart';
// import 'package:pdf_viewer/page/pdf_viewer_example.dart';
import 'package:pdf_viewer/page/profilePage.dart';

import 'api/pdf_api.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'PDF Viewer';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 124, 25, 245),
        ),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentindex = 1;
  final pages = [Audio_pdf(), Home(), Profile()];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: pages[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentindex,
            backgroundColor: Color.fromARGB(255, 39, 39, 39),
            unselectedItemColor: Colors.white70,
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
