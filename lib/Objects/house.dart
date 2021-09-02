import 'package:flutter/material.dart';

class House {
  String id;
  String title;
  String coverimage;
  List<String> images;
  String owner;
  double rating;

  String city;

  int price;
  List<String> acceptedpets;
  List<String> ownings;
  List<String> reserved;
  House({
  
   
    @required this.city,
    @required this.id,
    @required this.coverimage,
    @required this.owner,
    this.reserved,
    this.ownings,
    this.rating,
    this.images,
    this.price,
    this.acceptedpets,
    this.title,
  });
}
