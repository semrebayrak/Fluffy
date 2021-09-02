import 'package:fluffy/User/Login/components/body.dart';
import 'package:fluffy/Welcome/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluffy/Authentication/Firebase.dart';
import 'package:flutter/cupertino.dart';

class Body extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Enter your email")],
        ),
        SizedBox(height: size.height * 0.02),
        InputBox(
          color: Colors.lightBlue.shade200,
          child: TextField(
            controller: emailController,
            style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: size.height* 0.01,left: size.width* 0.05),
              hintText: "Your e-mail",
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        RoundedButton(
            text: "Send",
            color: Colors.black.withOpacity(0.9),
            textColor: Colors.white,
            press: () {
              FirebaseAuthenticationService.reset(
                  emailController.text.toString().trim());

              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text("An Email has been sent"),
                      ));
            }),
      ],
    ));
  }
}
