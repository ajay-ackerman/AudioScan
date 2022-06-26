// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf_viewer/page/loginMain.dart';
import 'package:pdf_viewer/page/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String useremail = ; //username, userid, useremail, userphotourl;
String emailId = "";

setEmail(String email) {
  emailId = email;
}

class Profile extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool loggedIn = false;
  Future<Null> _function() async {
    SharedPreferences prefs;

    final user = FirebaseAuth.instance.currentUser;

    prefs = await SharedPreferences.getInstance();

    setState(() {
      if (prefs.getString("useremail") != null) {
        loggedIn = true;
        // username = prefs.getString("username")!;
        // userid = prefs.getString("userid")!;
        // useremail = prefs.getString("useremail")!;
        // userphotourl = prefs.getString("userphotourl")!;
      } else {
        loggedIn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//   print(username);
//   print(userid);
//   print(useremail);
//   print(userphotourl);
    // final email = FirebaseAuth.instance.currentUser?.email.toString();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Color.fromARGB(255, 0, 128, 167),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: FadeInImage.memoryNetwork(
              //     placeholder: kTransparentImage,
              //     image: userphotourl,
              //     height: 150.0,
              //     width: 150.0,
              //     fadeInDuration: const Duration(milliseconds: 1000),
              //     alignment: Alignment.topCenter,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 128, 167),
                    border: Border.all(
                      color: Color.fromARGB(255, 0, 128, 167),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 80,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      "   " + emailId,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              RaisedButton(
                onPressed: () {
                  signOut();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 128, 167),
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 128, 167),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 80,
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 40,
                        color: Colors.white,
                      ),
                      Text(
                        "            About",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // color: const Color.fromARGB(255, 0, 128, 167),
                // textColor: Colors.white,
              ),
              // ),
              // Text(
              //   useremail,
              //   style:
              //       const TextStyle(fontSize: 18.0, color: Colors.blueAccent),
              // ),
              RaisedButton(
                onPressed: () {
                  signOut();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 100, left: 0),
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 128, 167),
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 128, 167),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 80,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 40,
                        color: Colors.white,
                      ),
                      Text(
                        "            Sign Out",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // color: const Color.fromARGB(255, 0, 128, 167),
                // textColor: Colors.white,
              )
            ],
          ),
        ),
        // body: ListView(
        //     padding: const EdgeInsets.only(top: 250, left: 10, right: 10),
        //     children: [
        //       Container(
        //         decoration: BoxDecoration(
        //             color: Color.fromARGB(255, 0, 128, 167),
        //             border: Border.all(
        //               color: Color.fromARGB(255, 0, 128, 167),
        //             ),
        //             borderRadius: BorderRadius.all(Radius.circular(20))),
        //         height: 80,
        //         child: Text(
        //           emailId,
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 25,
        //           ),
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        //     ]),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _function();
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await Fluttertoast.showToast(
          msg: "Signed Out",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(37, 49, 49, 49),
          textColor: Colors.white,
          fontSize: 16.0);
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => Login()));

      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }
}
