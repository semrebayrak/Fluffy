import 'dart:developer';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/MainMenu/safearea.dart';
import 'package:fluffy/Objects/profile.dart';
import 'package:flutter/material.dart';
import '../pets/pet.dart';

Future classFuture;

class ShowPet extends StatefulWidget {
  @override
  _ShowPetState createState() => _ShowPetState();
}

class _ShowPetState extends State<ShowPet> {
  initState() {
    classFuture = loadInformation();
  }

  @override
  Widget build(BuildContext context) {
    final pet = ModalRoute.of(context).settings.arguments as Pet;
    Size size = MediaQuery.of(context).size;

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
                                width: size.width * 0.5,
                                child: Image.network(pet.petPic),
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
                                      child: Text(" Name:" + "    " + pet.name,
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
                              pet.race,
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
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
                                child: Container(
                                    height: size.height * 0.06,
                                    width: size.width * 0.40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Age:" + " " + pet.age.toString()),
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
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Align(
                                alignment: Alignment(-0.80, 0),
                                child: Container(
                                    height: size.height * 0.06,
                                    width: size.width * 0.40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Sex:" + " " + pet.sex),
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

  Future<Profile> loadInformation() async {
    Profile profile = await FirebaseAuthenticationService.getSelfProfile();

    return profile;
  }
}
