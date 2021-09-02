import 'dart:developer';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/Stay/components/safearea.dart';
import 'package:fluffy/Objects/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Objects/house.dart';

Future classFuture;

class ShowHouse extends StatefulWidget {
  @override
  _ShowHouseState createState() => _ShowHouseState();
}

class _ShowHouseState extends State<ShowHouse> {

  @override
  Widget build(BuildContext context) {
    final house = ModalRoute.of(context).settings.arguments as House;
    Size size = MediaQuery.of(context).size;
      classFuture = loadInformation(house.owner);
    return Scaffold(
      body: FutureBuilder<Profile>(
          future: classFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Mysafearea(size: size),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 1,
                                child: Image.network(house.coverimage),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Container(
                              child: Stack(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text("    " + house.title,
                                          style: TextStyle(
                                              fontSize: size.width * 0.07)),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, 'profile');
                                      },
                                      child: Container(
                                          height: size.height * 0.06,
                                          width: size.width * 0.4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data.profilePicture),
                                              ),
                                              SizedBox(
                                                  width: size.width * 0.02),
                                              Expanded(
                                                  child: Text(snapshot
                                                          .data.name +
                                                      " " +
                                                      snapshot.data.surname[0] +
                                                      "."))
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          )),
                                    ),
                                  ]),
                            ],
                          )),
                          Container(
                            alignment: Alignment(-0.80, 0),
                            child: Text(
                              house.price.toString(),
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          for (var j = 0;
                              j < (house.ownings.length / 3).ceil();
                              j++)
                            Row(
                              children: [
                                SizedBox(
                                  height: size.height * 0.08,
                                  width: size.width * 0.07,
                                ),
                                for (var i = 0; i < 3; i++)
                                  if (3 * j + i < house.ownings.length)
                                    Container(
                                      width: size.width * 0.28,
                                      child: Align(
                                        alignment: Alignment(-0.80, 0),
                                        child: Container(
                                            height: size.height * 0.06,
                                            width: size.width * 0.25,
                                            child: Row(
                                              children: [
                                                if (3 * j + i == 0 &&
                                                    house.ownings[0] !=
                                                        "garden")
                                                  Icon(
                                                    Icons.cancel_sharp,
                                                    color: Colors.red,
                                                    size: size.width * 0.05,
                                                  )
                                                else
                                                  Icon(
                                                    Icons.done,
                                                    color: Colors.green,
                                                    size: size.width * 0.07,
                                                  ),
                                                if (3 * j + i == 0)
                                                  Container(
                                                    width: size.width * 0.13,
                                                    child: Center(
                                                      child: Text("Garden"),
                                                    ),
                                                  )
                                                else
                                                  Container(
                                                    width: size.width * 0.13,
                                                    child: Center(
                                                      child: Text(house
                                                          .ownings[3 * j + i]),
                                                    ),
                                                  )
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            )),
                                      ),
                                    )
                              ],
                            ),
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.07,
                              ),
                              Align(
                                  alignment: Alignment(-0.80, 0),
                                  child: InkWell(
                                    onTap: () {
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
                                              title: Text(
                                                "Number",
                                              ),
                                              content:
                                                  Text(snapshot.data.number),
                                            );
                                          });
                                    },
                                    child: Container(
                                        height: size.height * 0.06,
                                        width: size.width * 0.40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.message,
                                              color: Colors.green,
                                            ),
                                            Text("   Get Contact"),
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        )),
                                  )),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Align(
                                alignment: Alignment(-0.80, 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      'reservehouse',
                                      arguments: house,
                                    );
                                  },
                                  child: Container(
                                      height: size.height * 0.06,
                                      width: size.width * 0.40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_business_outlined,
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      /*    Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.93,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.04,
                          height: size.height * 0.07,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.44,
                          height: size.height * 0.05,
                          child: Text(
                            "Get Contact",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Quicksand",
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w600),
                          ),
                          decoration: new BoxDecoration(
                            color: Colors.deepOrange[600],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                        SizedBox(width: size.width * 0.04),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.44,
                          height: size.height * 0.05,
                          child: Text(
                            "Reserve",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Quicksand",
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w600),
                          ),
                          decoration: new BoxDecoration(
                            color: Colors.cyan[400],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ), */
                    ],
                  ),
                ),
              );
            else {
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
          }),
    );
  }

  Future<Profile> loadInformation(String userid) async {
    Profile profile = await FirebaseAuthenticationService.getProfile(userid);

    return profile;
  }
}
