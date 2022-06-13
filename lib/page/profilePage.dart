// import 'dart:io';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Color.fromARGB(255, 0, 128, 167),
          centerTitle: true,
        ),
        body: Container(
          color: Color.fromARGB(255, 148, 148, 148),
        ),
      );
}
