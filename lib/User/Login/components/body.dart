import 'dart:developer';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/Welcome/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModalRoute route = ModalRoute.of(context);
    
    Size size = MediaQuery.of(context).size;
    return Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            InputBox(
              color: Colors.lightBlue.shade200,
              child: TextField(
                controller: emailController,
                style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                // textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Your e-mail",
                  contentPadding: EdgeInsets.all(20.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            InputBox(
              color: Colors.deepPurple.shade200,
              child: TextField(
                obscureText: true,
                controller: passwordController,
                style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                // textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Password",
                  contentPadding: EdgeInsets.only(
                      top: size.height * 0.01, left: size.width * 0.05),
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.08),
            RoundedButton(
                text: "Login",
                color: Colors.black.withOpacity(0.9),
                textColor: Colors.white,
                press: () async {
                  bool isValid = await FirebaseAuthenticationService.login(
                      emailController.text.toString().trim(),
                      passwordController.text.toString().trim());
                  int logincount =
                      await FirebaseAuthenticationService.getLoginCount();
                  if (isValid && logincount == 0) {
                    Navigator.pushNamed(context, 'editprofile');
                  } else if (isValid && logincount != 0) {
                    Navigator.pushNamed(context, 'stay');
                  }
                }),
            SizedBox(height: size.height * 0.04),
            new InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "reset");
                },
                child: Text("Forgot Your Password?")),
            SizedBox(height: size.height * 0.02),
            new InkWell(
              onTap: () {
                Navigator.pushNamed(context, "create");
              },
              child: Text("Still Dont Have An Account?"),
            )
          ],
        ));
  }
}

class InputBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final ValueChanged<String> onChanged;
  const InputBox({
    this.color,
    this.onChanged,
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.15,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: child,
    );
  }
}
