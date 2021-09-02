import 'package:fluffy/User/Login/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluffy/Welcome/components/body.dart';
import 'package:fluffy/Authentication/Firebase.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputBox(
                color: Colors.deepPurple.shade200,
                child: TextField(
                  controller: emailController,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    contentPadding: EdgeInsets.all(20.0),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              InputBox(
                color: Colors.deepPurple.shade200,
                child: TextField(
                  controller: passwordController,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Password",
                    contentPadding: EdgeInsets.only(top: size.height* 0.01,left: size.width* 0.05),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              RoundedButton(
                  text: "Register",
                  color: Colors.black.withOpacity(0.9),
                  textColor: Colors.white,
                  press: () async {
                    bool isValid = await FirebaseAuthenticationService.signUp(
                        "Emre",
                        emailController.text.toString().trim(),
                        passwordController.text.toString().trim());

                    if (isValid) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                title: Text("Succesful Register"),
                              ));
                    }
                  }),
            ],
          )
        ],
      ),
    );
  }
}
