import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
// import 'package:pdf_text/pdf_text.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  // ignore: use_key_in_widget_constructors
  const PDFViewerPage({
    required this.file,
  });

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  late String text;
  // TextToSpeech tts = TextToSpeech();
  final FlutterTts tts = FlutterTts();
  double volume = 1.0;
  int pages = 0;
  int indexPage = 0;
  bool isStart = true;
  bool isPlay = false;

  extrator() async {
    if (isStart) {
      text = await getPDFtext(widget.file.path) as String;
      // TextEditingController ttscontroller = TextEditingController(text: text);

      print(text);
      await tts.setVolume(volume);
      String language = 'en-US';
      await tts.setLanguage(language);
      // await tts.getVoiceByLang(language);
      await tts.setVoice({"name": "Karen", "locale": "en-AU"});
      // tts.stop();
      isStart = false;
      await tts.speak(text);
      isPlay = true;
      print("-----------------------");
      print(isPlay);
    } else {
      if (isPlay) {
        print("-----------------------else isplay");
        print(isPlay);
        await tts.stop();
      } else {
        print("-----------------------elselese");
        print(isPlay);
        await tts.speak(text);
      }
    }
  }

  Future<String> getPDFtext(String path) async {
    String text = "";
    try {
      text = await ReadPdfText.getPDFtext(path);
    } on PlatformException {
      print('Failed to get PDF text.');
    }
    return text;
  }

  // ignore: non_constant_identifier_names
  translate() async {
    // final translator = GoogleTranslator();
    // translator.translate(text, from: 'ru', to: 'en').then(print);
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        title: Text(name),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: const Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.translate, size: 32),
                  onPressed: translate,
                ),
              ]
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        child: isPlay ? const Icon(Icons.pause) : const Icon(Icons.volume_up),
        onPressed: () {
          setState(() {
            if (isStart) {
              isPlay = true;
            }
            print("settttttjnkjf bfkjd ");
            print(isPlay);
          });
          extrator();
          if (!isStart) {
            isPlay = !isPlay;
          }
        },
      ),
      // IconButton(
      //     onPressed: () => extrator(), icon: const Icon(Icons.volume_up)),
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
  //===============================================================

  // ==================================================================

  // extrator() async {
  //   PdfDocument document =
  //       PdfDocument(inputBytes: await _readDocumentData('assets/sample.pdf'));
  //   PdfTextExtractor extractor = PdfTextExtractor(document);
  //   String text = extractor.extractText();
  //   print(text);

  //   TextToSpeech tts = TextToSpeech();
  //   double volume = 1.0;
  //   await tts.setVolume(volume);
  //   // await tts.pause();

  //   String language = 'en-US';
  //   await tts.setLanguage(language);
  //   await tts.getVoiceByLang(language);
  //   // tts.stop();
  //   await tts.speak(text);
  // }

  // Future<List<int>> _readDocumentData(String name) async {
  //   // final ByteData data = await rootBundle.load(name);
  //   final ByteData data = await rootBundle.load(name);
  //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // }

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
