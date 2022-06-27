// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("About AudioScan"),
          backgroundColor: const Color.fromARGB(255, 0, 128, 167),
          centerTitle: true,
        ),
        body: Container(
          child: Positioned(
            child: Column(
              children: [
                const Text("\n\nListen and read PDF with AUDIOSCAN.",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 128, 167))),
                const Text(
                    " \n\n   ● AUDIOSCAN makes any time a reading  \n     time with great audible functionality of reading \n      text from pdfs.\n\n   ● It Enables the feature of Listening the PDF \n\n   ● Supports Original Pdf View\n\n   ●Translates the PDF in multiple language\n\n   ● Listen with Original Pdf View",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                const Text(
                    "\n\n\nDeveloped By  -\n\n\nAjay Awchar(1906004)\n\nSamarth Hadawale(1906034)\n\nShruti Jagtap(1906042)\n\nAtharva Kavitake(1906061)")
              ],
            ),
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      );
}
