import 'package:flutter/material.dart';

class Pet {
  String id;
  String petPic, sex, name, race;
  String age;

  Pet({
    @required this.id,
    this.petPic,
    this.sex,
    @required this.name,
    this.race,
    this.age,
  });
}
