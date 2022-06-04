import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
        ),
        body: Container(
          color: Color.fromARGB(199, 198, 240, 253),
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
