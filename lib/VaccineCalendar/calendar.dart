import 'package:fluffy/generalappbar.dart';
import 'package:fluffy/VaccineCalendar/components/body.dart';
import 'package:flutter/material.dart';



class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:CalendarBody(),
      bottomNavigationBar: Appbar(),
    );
    
  }
  
 
}
