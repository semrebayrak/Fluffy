import 'package:flutter/material.dart';

class Walking {
  String id;
  String title;
  String coverimage;

  String walker;

  String city;
  String description;
  int price;
  List<String> acceptedpets;
  List<String> ownings;
  List<String> reserved;
  String type;
  double rating;
  Walking({
    @required this.description,
    @required this.walker,
    @required this.city,
    @required this.id,
    @required this.coverimage,
    this.reserved,
    this.rating,
    this.price,
    this.acceptedpets,
    this.title,
    this.ownings,
    this.type,
  });
}
