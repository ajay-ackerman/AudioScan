// // // import 'dart:io';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:flutter/material.dart';

// // class Profile extends StatelessWidget {
// //   GoogleSignIn _googleSignIn = GoogleSignIn(
// //     scopes: [
// //       'email',
// //       'https://www.googleapis.com/auth/contacts.readonly',
// //     ],
// //   );
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(
// //           title: Text("Profile"),
// //           backgroundColor: Color.fromARGB(255, 0, 128, 167),
// //           centerTitle: true,
// //         ),
// //         body: Container(
// //           color: Color.fromARGB(255, 255, 255, 255),
// //         ),
// //       );
// // }

// import 'dart:async';
// import 'dart:convert' show json;

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/admin.directory.user.security',
//   ],
// );

// void main() {
//   runApp(
//     const MaterialApp(
//       title: 'Sign In',
//       home: Profile(),
//     ),
//   );
// }

// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);

//   @override
//   State createState() => ProfileState();
// }

// class ProfileState extends State<Profile> {
//   GoogleSignInAccount? _currentUser;
//   String _contactText = '';

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact(_currentUser!);
//       }
//     });
//     _googleSignIn.signInSilently();
//   }

//   Future<void> _handleGetContact(GoogleSignInAccount user) async {
//     setState(() {
//       _contactText = 'Loading contact info...';
//     });
//     final http.Response response = await http.get(
//       Uri.parse('https://people.googleapis.com/v1/people/me/connections'
//           '?requestMask.includeField=person.names'),
//       headers: await user.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = 'People API gave a ${response.statusCode} '
//             'response. Check logs for details.';
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data =
//         json.decode(response.body) as Map<String, dynamic>;
//     final String? namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = 'I see you know $namedContact!';
//       } else {
//         _contactText = 'No contacts to display.';
//       }
//     });
//   }

//   String? _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic>? connections = data['connections'] as List<dynamic>?;
//     final Map<String, dynamic>? contact = connections?.firstWhere(
//       (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     ) as Map<String, dynamic>?;
//     if (contact != null) {
//       final Map<String, dynamic>? name = contact['names'].firstWhere(
//         (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       ) as Map<String, dynamic>?;
//       if (name != null) {
//         return name['displayName'] as String?;
//       }
//     }
//     return null;
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   Widget _buildBody() {
//     final GoogleSignInAccount? user = _currentUser;
//     if (user != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: user,
//             ),
//             title: Text(user.displayName ?? ''),
//             subtitle: Text(user.email),
//           ),
//           const Text('Signed in successfully.'),
//           Text(_contactText),
//           ElevatedButton(
//             onPressed: _handleSignOut,
//             child: const Text('SIGN OUT'),
//           ),
//           ElevatedButton(
//             child: const Text('REFRESH'),
//             onPressed: () => _handleGetContact(user),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text('You are not currently signed in.',
//               style: TextStyle(fontFamily: "Trajan Pro")),
//           ElevatedButton(
//             onPressed: _handleSignIn,
//             child: const Text('SIGN IN'),
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }

// ignore_for_file: unnecessary_const, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf_viewer/main.dart';
import 'package:pdf_viewer/page/homePage.dart';
import 'package:pdf_viewer/page/profilepPage.dart';

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
        setEmail(_userEmail);
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
              Container(
                alignment: const Alignment(1, 0),
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: const InkWell(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
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
                  color: Color.fromARGB(255, 0, 128, 167),
                  child: Text("LOGIN"),
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
}
