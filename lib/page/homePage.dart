// ignore_for_file: deprecated_member_use

import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer/api/pdf_api.dart';
import 'package:pdf_viewer/page/aboutPage.dart';
import 'package:pdf_viewer/page/pdf_viewer_example.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

class Home extends StatelessWidget {
  // late final file;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("AUDIOSCAN"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 128, 167),
          actions: [
            IconButton(
              icon: const Icon(Icons.info, size: 20),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => About()));
              },
            ),
          ],
        ),
        body: Stack(children: [
          Positioned(
            top: 350,
            left: 80,
            child: Container(
              color: Color.fromARGB(223, 251, 254, 255),
              child: Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_7fmryqpe.json',
                addRepaintBoundary: true,
                height: 250,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const Positioned(
            top: 40,
            left: 50,
            child: Text(
              "WELCOME TO AUDIO SCAN ",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 128, 167), fontSize: 20),
            ),
          ),
          Positioned(
            top: 100,
            left: 114,
            child: RaisedButton(
              color: Color.fromARGB(255, 0, 128, 167),
              textColor: Colors.white,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          // To display the title it is optional
                          content: SingleChildScrollView(
                              child: Text(
                                  "About PDF to Audio")), // Message which will be pop up on the screen
                          // Action widget which will provide the user to acknowledge the choice
                        ));
              },
              child: Text("• About PDF to Audio"),
            ),
          ),
          Positioned(
            top: 150,
            left: 115,
            child: RaisedButton(
              color: Color.fromARGB(255, 0, 128, 167),
              textColor: Colors.white,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          // To display the title it is optional
                          content: SingleChildScrollView(
                              child: Text(
                                  "About Audio to PDF")), // Message which will be pop up on the screen
                          // Action widget which will provide the user to acknowledge the choice
                        ));
              },
              child: Text("• About Audio to PDF"),
            ),
          ),
          Positioned(
            top: 200,
            left: 130,
            child: RaisedButton(
              color: Color.fromARGB(255, 0, 128, 167),
              textColor: Colors.white,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          // To display the title it is optional
                          content: SingleChildScrollView(
                              child: Text(
                                  "About the translater")), // Message which will be pop up on the screen
                          // Action widget which will provide the user to acknowledge the choice
                        ));
              },
              child: Text("• About Translate"),
            ),
            // child: Container(
            //     color: Color.fromARGB(197, 255, 255, 255),
            //     child: DropdownButton(
            //       focusColor: Colors.black,
            //       value: "",
            //       icon: const Icon(Icons.arrow_drop_down_sharp),
            //       items: const [
            //         DropdownMenuItem(
            //           child: Text(
            //             "• Translate ",
            //             style: TextStyle(fontSize: 20),
            //           ),
            //           value: "",
            //         ),
            //         DropdownMenuItem(
            //           child: Text(
            //             "about PDF translater",
            //             style: TextStyle(color: Colors.blue),
            //           ),
            //           value: " ",
            //         ),
            //       ],
            //       onChanged: (String? value) {},
            //     )),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 128, 167),
            onPressed: () async {
              final file = await PDFApi.pickFile();
              if (file == null) return;
              openPDF(context, file);
            },
            child: Icon(Icons.add)),
      );

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}
