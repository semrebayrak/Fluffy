import 'package:fluffy/generalappbar.dart';
import 'package:fluffy/pets/components/body.dart';
import 'package:flutter/material.dart';
import 'package:fluffy/Stay/mainmenu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authentication/Firebase.dart';

class Pets extends StatefulWidget {
  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  static final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: Appbar(),
    );
  }
}

/*class display_data extends StatelessWidget {
  String PetPic, age, name, sex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      children: [
        SizedBox(height: size.height * 0.1),
        Column(
          children: [
            for(hayvansayisi)
            Row(
              children: [
                SizedBox(width: size.width * 0.1),
                SizedBox(
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    child: ClipOval(
                      child: Image.network(
                        PetPic,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(width: size.width * 0.02),
                SizedBox(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: Text(
                        name,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: Text(
                        age,
                      ),
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
}*/
