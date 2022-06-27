import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf_viewer/main.dart';
// import 'package:pdf_viewer/page/homePage.dart';
import 'package:pdf_viewer/page/profilepPage.dart';
import 'package:pdf_viewer/page/utils.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";

  void _singIn() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;

    if (user != null) {
      setState(() {
        _success = 2;
        _userEmail = user.email!;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()));
      });
    } else {
      setState(() {
        _success = 3;
      });
    }
    Fluttertoast.showToast(
        msg: _success == 1
            ? ''
            : (_success == 2
                ? 'Successfully signed in ' + _userEmail
                : 'Sign in failed'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(37, 49, 49, 49),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text(
                  "Hello User , Welcome to AudioScan",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 128, 167),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 128, 167)),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 128, 167)),
                    )),
                obscureText: true,
              ),
              const SizedBox(
                height: 5.0,
              ),
              // FlatButton(
              //     onPressed: resetPassword,
              //     child: Container(
              //       alignment: const Alignment(1, 0),
              //       padding: const EdgeInsets.only(top: 15, left: 20),
              //       child: const InkWell(
              //         child: Text(
              //           'Forgot Password',
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: 'Montserrat',
              //               decoration: TextDecoration.underline),
              //         ),
              //       ),
              //     )),
              // Container(
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     child:
              //       style: const TextStyle(
              //           color: Color.fromARGB(255, 0, 128, 167)),
              //     )),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 40,

                // child: GestureDetector(
                //     onTap: () async {
                //       _singIn();
                //     },
                //     child: const Center(
                //         child: const Text('LOGIN',
                //             style: const TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold,
                //                 fontFamily: 'Montserrat')))),
                child: RaisedButton(
                  onPressed: _singIn,
                  color: const Color.fromARGB(255, 0, 128, 167),
                  child: const Text("LOGIN"),
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: const Text('\n\nRegister',
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    )));
  }

  Future resetPassword() async {
    print("//////////////////////////////////////////////////////" +
        _emailController.text);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      print("===================================\n" + _emailController.text);
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());

      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent...')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      Navigator.of(context).pop();
    }
  }
}
