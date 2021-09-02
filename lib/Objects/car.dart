import 'package:flutter/material.dart';

class Car {
  String brand;
  String id;
  String coverimage;

  String model;

  String owner;
  String plate;
  int price;
  List<String> acceptedpets;
  List<String> ownings;
  List<String> reserved;
  double rating;
  Car({
    @required this.brand,
    @required this.id,
    @required this.coverimage,
    @required this.model,
    this.owner,
    this.plate,
    this.price,
    this.acceptedpets,
    this.ownings,
    this.rating,
    this.reserved,
  });
}
