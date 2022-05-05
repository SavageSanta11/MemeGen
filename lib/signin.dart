// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memegen/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SignInBody());
  }
}

class SignInBody extends StatefulWidget {
  
  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool signin = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff344966),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Color(0xff74A57F)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Color(0xff74A57F)),
                  ),
                ),
              ),
            ),
            InkWell(
              child: signin
                  ? Text(
                      'Register as a user',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text('Returning User? Click here',
                      style: TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  signin = !signin;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xff74A57F),
                onPressed: () async {
                  String? x = signin
                      ? await context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                      : await context.read<AuthenticationService>().signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                  if (x == "Signed up") {
                    final docRef =  FirebaseFirestore.instance
                        .collection('users').doc();
                        await docRef.set({'docID': docRef.id, 'email': emailController.text, 'urls': {}});
                    
                  } else {
                    final snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(x.toString()),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    );

                    // Find the Scaffold in the widget tree and use
                    // it to show a SnackBar.
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
                child: signin ? const Text("Sign In") : const Text("Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
