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
          Container(
            color: Color.fromARGB(223, 251, 254, 255),
            child: Center(
                child: Lottie.network(
              'https://assets10.lottiefiles.com/packages/lf20_7fmryqpe.json',
              addRepaintBoundary: true,
              height: 250,
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
            )),
          ),
          const Positioned(
            top: 10,
            left: 120,
            child: Text(
              "shrt notes about audioScan ",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Positioned(
            top: 270,
            left: 130,
            child: Center(
              child: Container(
                color: Color.fromARGB(197, 255, 255, 255),
                child: DropdownButton(
                  value: "",
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  items: const [
                    DropdownMenuItem(
                      child: Text(
                        "• Audio to pdf",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "",
                    ),
                    DropdownMenuItem(
                      child: Text("about audio to pdf",
                          style: TextStyle(color: Colors.blue)),
                      value: " ",
                    ),
                  ],
                  onChanged: (String? value) {},
                ),
              ),
            ),
          ),
          Positioned(
            top: 330,
            left: 130,
            child: Container(
                color: Color.fromARGB(197, 255, 255, 255),
                child: DropdownButton(
                  focusColor: Colors.black,
                  value: "",
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  items: const [
                    DropdownMenuItem(
                      child: Text(
                        "• PDF to Udio",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "about audio to pdf",
                        style: TextStyle(color: Colors.blue),
                      ),
                      value: " ",
                    ),
                  ],
                  onChanged: (String? value) {},
                )),
          ),
          Positioned(
            top: 390,
            left: 130,
            child: Container(
                color: Color.fromARGB(197, 255, 255, 255),
                child: DropdownButton(
                  focusColor: Colors.black,
                  value: "",
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  items: const [
                    DropdownMenuItem(
                      child: Text(
                        "• Translate ",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: "",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "about PDF translater",
                        style: TextStyle(color: Colors.blue),
                      ),
                      value: " ",
                    ),
                  ],
                  onChanged: (String? value) {},
                )),
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
