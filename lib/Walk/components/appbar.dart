import 'package:fluffy/Stay/mainmenu.dart';
import 'package:fluffy/Message/message.dart';
import "package:flutter/material.dart";
import 'dart:developer';

class Appbar extends StatelessWidget {
  const Appbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Actionbutton:
    //FloatingActionButtonLocation.centerDocked;

    ModalRoute route = ModalRoute.of(context);
    

    return BottomAppBar(
      color: Color(0xffD98007),
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.home),
                  onPressed: () {
                    if (route.settings.name != 'walk') {
                      Navigator.pushNamed(context, 'walk');
                    }
                  }),
              IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.colorize_rounded),
                  onPressed: () {


                    if (route.settings.name != 'calendar') {
                      Navigator.pushNamed(context, 'calendar');
                    }
                  }),
              SizedBox(
                width: 50,
              ),
              IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.pets),
                  onPressed: () {
                    if (route.settings.name != 'pets') {
                      Navigator.pushNamed(context, 'pets');
                    }
                  }),
              IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.account_circle_outlined),
                  onPressed: () {

                    if (route.settings.name != 'profile') {
                      Navigator.pushNamed(context, 'profile');
                    }
                  })
            ]),
      ),
    );
  }
}

class Actionbutton extends StatelessWidget {
  const Actionbutton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      width: 65.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          // elevation: 5.0,
        ),
      ),
    );
  }
}
