import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer/api/pdf_api.dart';
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
              icon: const Icon(Icons.merge, size: 32),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          color: Color.fromARGB(223, 251, 254, 255),
          child: Center(
              child: Lottie.network(
            'https://assets10.lottiefiles.com/packages/lf20_7fmryqpe.json',
            height: 250,
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
          )),
        ),
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
