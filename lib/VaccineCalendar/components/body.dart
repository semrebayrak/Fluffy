import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/generalarea.dart';
import 'package:fluffy/pets/pet.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluffy/User/Login/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluffy/Welcome/components/body.dart';
import '../../Objects/appointment.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

List<String> petids;
List<String> monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
List<Appointment> appointments;

DateTime dateTime = DateTime.now();
TextEditingController descriptionController = new TextEditingController();
Size size;

class CalendarBody extends StatefulWidget {
  @override
  _CalendarBodyState createState() => _CalendarBodyState();
}

Future classFuture;
AsyncSnapshot<dynamic> snap;

class _CalendarBodyState extends State<CalendarBody> {
  Pet selectedPetfromPic;
  Pet searchinpets;
  Pet selectedPet;
  int appointmentslength = 0;
  initState() {
    classFuture = callAsyncFetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: classFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snap = snapshot;
            size = MediaQuery.of(context).size;
            return Container(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  Mysafearea(size: size),
                  Positioned(
                      top: size.height * 0.15,
                      left: size.width * 0.08,
                      child: Container(
                        width: size.width * 0.40,
                        height: size.height * 0.05,
                        child: TextButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Appointment",
                                  style: TextStyle(
                                      fontSize: size.width * 0.03,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                backgroundColor:
                                    Colors.black.withOpacity(0.10)),
                            onPressed: () {
                              /*
                       showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            */
                              bottomsheet(context, dateTime);
                            }),
                      )),
                  Positioned(
                      top: size.height * 0.25,
                      left: size.width * 0.08,
                      child: Container(
                          width: size.width * 0.40,
                          height: size.height * 0.05,
                          child: Text(
                            "My Appointments",
                            style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.black),
                          ))),
                  Positioned(
                    top: size.height * 0.30,
                    left: size.width * 0.08,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedPet == null
                                ? "Select a Pet"
                                : "    ${selectedPet.name}",
                            style: TextStyle(
                                fontSize: size.width * 0.03,
                                color: Colors.black),
                          ),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          backgroundColor: Colors.black.withOpacity(0.10)),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: size.height / 3.33,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: CupertinoPicker(
                                        itemExtent: size.height * 0.06,
                                        onSelectedItemChanged: (number) {
                                          setState(() {
                                            searchinpets =
                                                snapshot.data[number];
                                          });
                                        },
                                        children: [
                                          for (Pet pet in snapshot.data)
                                            Text(pet.name),
                                        ],
                                      ),
                                    ),
                                    CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context);

                                          setState(() {
                                            writeAppointments(searchinpets.id);

                                            selectedPet = searchinpets;
                                          });
                                        },
                                        child: Text("Done")),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  if (appointmentslength != 0)
                    for (var j = 0; j < appointmentslength; j++)
                      Positioned(
                          top: size.height * 0.10 * j,
                          left: size.width * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.40),
                                child: CircleButton(
                                  text: appointments[j]
                                      .date
                                      .difference(DateTime.now())
                                      .inDays
                                      .toString(),
                                  color: Colors.red.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Text(
                                  "Days Left for ${appointments[j].description}")
                            ],
                          )),
                ],
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                )
              ],
            );
          }
        });
  }

  Future bottomsheet(BuildContext context, DateTime dateTime) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.07,
                  ),
                  new Icon(Icons.calendar_today),
                  SizedBox(
                    width: size.width * 0.07,
                  ),
                  new Text(dateTime.day.toString(),
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: size.width * 0.07,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  new Text(month(dateTime.month.toInt()),
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: size.width * 0.07,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  new Text(dateTime.year.toString(),
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: size.width * 0.07,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  InkWell(
                    child: Icon(
                      Icons.arrow_circle_down_rounded,
                      size: size.width * 0.07,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                Flexible(
                                  child: CupertinoDatePicker(
                                      onDateTimeChanged: (date) {
                                    setState(() {
                                      dateTime = date;
                                    });
                                  }),
                                ),
                                CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Done"))
                              ],
                            );
                          });
                    },
                  )
                ],
              ),
              Row(children: [SizedBox(height: size.height * 0.03)]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < snap.data.length; i++)
                    Container(
                      width: size.width * 0.15,
                      child: InkWell(
                        child: CircleAvatar(
                          radius: size.width * 0.06,
                          backgroundImage: NetworkImage(snap.data[i]?.petPic),
                        ),
                        onTap: () {
                          setState(() {
                            selectedPetfromPic = snap.data[i];
                          });
                        },
                      ),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: snap.data[i] == selectedPetfromPic
                              ? Colors.black
                              : Colors.transparent,
                          width: 4.0,
                        ),
                      ),
                    ),
                ],
              ),
              Row(children: [SizedBox(height: size.height * 0.03)]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputBox(
                    color: Colors.blue.withOpacity(0.3),
                    child: TextField(
                      controller: descriptionController,
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "Description",
                        contentPadding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.05),
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
              Row(children: [SizedBox(height: size.height * 0.03)]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                      text: "Set Appointment",
                      color: Colors.black.withOpacity(0.7),
                      textColor: Colors.black,
                      press: () {
                        if (selectedPetfromPic != null) {
                          log(selectedPetfromPic.name);
                          FirebaseAuthenticationService.setAppointment(
                              selectedPetfromPic.id,dateTime,descriptionController.text);
                          
                        } else {
                          showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                  title: Text("Missing"),
                                  content: Text("Please Choose a Pet"),
                                );
                              });
                          return;
                        }
                        Navigator.pop(context);
                      })
                ],
              ),
            ]);
          });
        });
  }

  Future<List<Pet>> callAsyncFetch() async {
    await FirebaseAuthenticationService.getPetIds().then((s) => setState(() {
          petids = s;
        }));

    return await FirebaseAuthenticationService.getPets(petids);
  }

  writeAppointments(String petid) async {
    await FirebaseAuthenticationService.getAppointments(petid)
        .then((s) => setState(() {
              if (s != null) {
                appointments = s;
                appointmentslength = s.length;
              } else {
                appointmentslength = 0;
                s = null;
              }
            }));
  }
}

String month(int month) {
  return monthNames[month - 1];
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Color color;
  final String day;
  final String month;
  final String text;

  const CircleButton(
      {Key key, this.onTap, this.color, this.day, this.month, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sized = size.width * 0.13;

    return new InkResponse(
      onTap: () {
        if (day != null)
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: size.height / 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day + " " + month,
                            style: TextStyle(fontSize: size.width * 0.05),
                          )
                        ],
                      )
                    ],
                  ),
                );
              });
      },
      child: new Container(
        alignment: Alignment.center,
        child: SizedBox(
            child: Text(
          text,
          style: TextStyle(fontSize: size.width * 0.08),
        )),
        width: sized,
        height: sized,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
