import 'package:fluffy/generalappbar.dart';
import 'package:fluffy/Stay/mainmenu.dart';
import 'package:fluffy/Profile/components/body.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Body(),
      bottomNavigationBar: Appbar(),




       
    );
  }
}