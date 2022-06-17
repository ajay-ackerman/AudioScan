import 'dart:io';
import 'package:pdf_viewer/page/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer/api/speech_api.dart';
// import 'package:pdf_viewer/main.dart';
import 'package:pdf_viewer/widget/substring_highlighted.dart';
// import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf_viewer/page/utils.dart';

class Audio_pdf extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Audio_pdf> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Audio to PDF"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 128, 167),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(text);

                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('✓   Copied to Clipboard')),
                  );
                },
              ),
            ),
            Builder(
                builder: (context) => IconButton(
                    onPressed: createPdf,
                    icon: const Icon(Icons.picture_as_pdf))),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.all(30).copyWith(bottom: 150),
            child: SubstringHighlight(
              text: text,
              terms: Command.all,
              textStyle: TextStyle(
                fontSize: 32.0,
                fontFamily: 'Cardo',
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              // textStyleHighlight: TextStyle(
              //   fontSize: 32.0,
              //   color: Colors.red,
              //   fontWeight: FontWeight.w400,
              // ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 75,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 128, 167),
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
            onPressed: toggleRecording,
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              // Utils.scanText(text);
            });
          }
        },
      );

  createPdf() async {
    // final pdf = pw.Document();
    // final font = await rootBundle.load("assets/fonts/Cardo-Italic.ttf");
    // final ttf = pw.Font.ttf(font);
    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Center(
    //         child: pw.Text(
    //           text,
    //           style: pw.TextStyle(
    //             font: ttf,
    //           ),
    //           //child: pw.Text('Dart is awesome', style: TextStyle(font: ttf, fontSize: 40)),
    //         ),
    //       ); // Center
    //     }));

// ==========================================================================
    // final output = await getTemporaryDirectory();
    // final output = await getExternalStorageDirectory();
    // print("===============================");
    // // print(output);
    // // final file = File("${output?.path}/example.pdf");
    // // Directory? dir = await getExternalStorageDirectory();
    // // Future<String> path = ExtStorage.getExternalStoragePublicDirectory(
    // //     ExtStorage.DIRECTORY_DOWNLOADS);
    // // print(path);
    // final file =
    //     File("/user/android/download/" + text.substring(0, 5) + ".pdf");
    // // final file = File("/storage/emulated/0/Downloads/example.pdf");
    // await file.writeAsBytes(await pdf.save());

    //====================================
    // Future<Directory?> getExternalStorageDirectory() async {
    // final String? path = await _platform.getExternalStoragePath();
    // if (path == null) {
    //   return null;
    // }
    // return Directory(path);
    // }

    //=================
    // String myJpgPath = path.toString() + "/Download/" + text[5] + ".pdf";

    // final file =
    //     File("/storage/emulated/0/Download/" + text.substring(0, 5) + ".pdf");

    // await file.writeAsBytes(await pdf.save());
    //==========================================================
    // final output = await getExternalStorageDirectory();
    // print("===============================");
    // print(output);
    // final file = File("${output?.path}/example.pdf");
    // await file.writeAsBytes(await pdf.save());
    ///////////////////////////////////////////////////////////////////////

    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics
        .drawString(text, PdfStandardFont(PdfFontFamily.helvetica, 30));
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, (text.substring(0, 5) + ".pdf"));
  }
}
