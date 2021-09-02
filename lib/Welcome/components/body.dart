
import 'package:fluffy/VaccineCalendar/components/body.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to Fluffy",
                style: TextStyle(fontSize: 26, fontFamily: "Quicksand")),
            SizedBox(height: size.height * 0.04),
            RoundedButton(
              text: "Login",
              color: Colors.cyan.shade500,
              press: () {
               Navigator.pushNamed(context, 'login');
              },
            ),
            SizedBox(height: size.height * 0.04),
            RoundedButton(
              text: "Sign Up", 
              color: Colors.deepOrange.shade500,
              press: () {
               Navigator.pushNamed(context, 'create');
              },
              ),
            SizedBox(height: size.height * 0.05),

            
            
          ],
        ));
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: ClipRRect(
        child: TextButton(
          style: TextButton.styleFrom(
           
            primary: Colors.white,
            backgroundColor: color,
            onSurface: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 120),
          ),
          onPressed: press,
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
