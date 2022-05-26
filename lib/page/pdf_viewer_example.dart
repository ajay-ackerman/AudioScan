import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({
    required this.file,
  });

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 39, 39),
        title: Text(name),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                    onPressed: () => extrator(), icon: Icon(Icons.volume_up))
              ]
            : null,
      ),
      body: UCPDFView(
        filePath: widget.file.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }

  // ==================================================================

  extrator() async {
    PdfDocument document =
        PdfDocument(inputBytes: await _readDocumentData('assets/sample.pdf'));
    PdfTextExtractor extractor = PdfTextExtractor(document);
    String text = extractor.extractText();
    print(text);

    TextToSpeech tts = TextToSpeech();
    double volume = 1.0;
    await tts.setVolume(volume);
    // await tts.pause();

    String language = 'en-US';
    await tts.setLanguage(language);
    // tts.stop();
    await tts.speak(text);
  }

  Future<List<int>> _readDocumentData(String name) async {
    // final ByteData data = await rootBundle.load(name);
    final ByteData data = await rootBundle.load(name);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  //===============================================================

  // extrator() async {
  //   PDFDoc doc = await PDFDoc.fromPath(widget.file.path);
  //   String docText = await doc.text;
  //   // print(docText);
  //   await ttspeech(docText);
  // }

//   ttspeech(docText) async {
//     TextToSpeech tts = TextToSpeech();
//     double volume = 1.0;
//     await tts.setVolume(volume);
//     // await tts.pause();

//     String language = 'en-US';
//     await tts.setLanguage(language);

//     await tts.speak(docText);
//   }
}
