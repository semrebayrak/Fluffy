import 'package:flutter/material.dart';

class Bodyd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String blank = "  ";
    String message = "this is a message";
    return Container(
        child: ListView(
      children: [
        SizedBox(height: size.height * 0.1),
        Column(
          children: [
            Row(
              children: [
                SizedBox(width: size.width * 0.1),
                SizedBox(
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/photo.png",
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(width: size.width * 0.02),
                SizedBox(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: Text("Emre Bayrak"),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: Text("This is a message"),
                    ),
                  ],
                ))
              ],
            ),
          ],
        )
      ],
    ));
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
            child: Column(
      children: [
        SizedBox(height: size.height * 0.1),
      
        for (var i = 0; i < 1; i++)
          Row(
            children: [
              SizedBox(height: size.height * 0.09),
              SizedBox(width: size.width * 0.1),
              SizedBox(
                  width: size.width * 0.15,
                  height: size.width * 0.15,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/photo.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(width: size.width * 0.02),
              SizedBox(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Text("Emre Bayraak"),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Text("This is a message"),
                  ),
                ],
              ))
            ],
          ),
      ],
    )));
  }
}
