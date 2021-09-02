import 'package:fluffy/Walk/components/appbar.dart';
import 'package:fluffy/Walk/components/body.dart';
import "package:flutter/material.dart";
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../ChangeButton.dart';

class Walk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      floatingActionButton: SpeedDialWidget(),
      bottomNavigationBar: Appbar(),
      body: Body(),
     
      
     
      



     
    );
  }
}


