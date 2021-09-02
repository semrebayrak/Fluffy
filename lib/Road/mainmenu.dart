import 'package:fluffy/Road/components/appbar.dart';
import 'package:fluffy/Road/components/body.dart';
import "package:flutter/material.dart";
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../ChangeButton.dart';

class Road extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      floatingActionButton: SpeedDialWidget(),
      bottomNavigationBar: Appbar(),
      body: Body(),
     
      
     
      



     
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
    );
  }
}

