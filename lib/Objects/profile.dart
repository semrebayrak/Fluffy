import 'package:flutter/material.dart';

class Profile {
  int id;
  final String name;
  final String surname;
  final String city;
  final String sex;
  final String profilePicture;
  final List<String> pets;
  final String age;
  final List<int> ratings;
  final String number;
  Profile(
      {this.ratings,
      this.id,
      this.number,
      this.age,
      this.name,
      this.surname,
      this.city,
      this.sex,
      this.profilePicture,
      this.pets});
}
