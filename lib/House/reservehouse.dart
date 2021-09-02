import 'dart:developer';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/Stay/components/safearea.dart';
import 'package:fluffy/Objects/house.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class ReserveHouse extends StatefulWidget {
  @override
  _ReserveHouseState createState() => _ReserveHouseState();
}

class _ReserveHouseState extends State<ReserveHouse> {
  bool reserved = false;

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  List<DateTime> absentDates = [];
  static Widget _absentIcon(String day) => CircleAvatar(
        backgroundColor: Colors.red,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
  static Widget _presentIcon(String day) => CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  @override
  Widget build(BuildContext context) {
    final house = ModalRoute.of(context).settings.arguments as House;

    for (var i = 0; i < house.reserved.length; i++) {
      absentDates.add(DateFormat("dd-MM-yyyy").parse(house.reserved[i]));
    }
    var len = absentDates.length;
    try {
      for (int i = 0; i < len; i++) {
        _markedDateMap.add(
          absentDates[i],
          new Event(
            date: absentDates[i],
            title: 'Event 5',
            icon: _absentIcon(
              absentDates[i].day.toString(),
            ),
          ),
        );
      }
    } catch (e) {
      absentDates = null;
    }

    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.red,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },

      showOnlyCurrentMonthDate: true,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,

      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),

      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      selectedDayButtonColor: Colors.black,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,

      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator

      markedDateIconBuilder: (event) {
        return event.icon;
      },
      inactiveDaysTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Mysafearea(size: size),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //custom icon
            SizedBox(
              height: size.height * 0.10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: new Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _currentMonth,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  )),
                  FlatButton(
                    child: Text('PREV'),
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month - 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  ),
                  FlatButton(
                    child: Text('NEXT'),
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month + 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              height: size.height * 0.60,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: _calendarCarouselNoHeader,
            ), // This trailing comma makes auto-formatting nicer for build methods.
            //custom icon without header
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: size.height * 0.80,
            ),
            Align(
              alignment: Alignment(0, 0),
              child: InkWell(
                onTap: () {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        if (!absentDates.contains(_currentDate2)) {
                          Reserve(_currentDate2, house);
                          reserved = true;
                          if (reserved) {
                            absentDates.add(_currentDate2);
                          }
                        } else {
                          reserved = false;
                        }
                        return CupertinoAlertDialog(
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          title: Text(
                            reserved ? "Reservation" : "Error",
                          ),
                          content: Text(reserved
                              ? "Reservation is done"
                              : "The selected date is already reserved"),
                        );
                      });
                },
                child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.send,
                          color: Colors.green,
                        ),
                        Text("   Reserve"),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Reserve(DateTime date, House house) async {
    return await FirebaseAuthenticationService.setHouseReservation(date, house)
        .then((s) => setState(() {
              reserved = s;
            }));
  }
}
