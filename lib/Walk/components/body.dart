import 'dart:developer';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/Walk/components/safearea.dart';
import 'package:fluffy/pets/pet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Objects/walking.dart';

Future classFuture;
List<Pet> pets;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Walking> walks;

  List<String> orderBy = [
    "Rating",
    "Price",
  ];

  List<String> cities = [
    "İstanbul",
    "Ankara",
    "İzmir",
    "Adana",
    "Adıyaman",
    "Afyon",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Bartın",
    "Batman",
    "Balıkesir",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkari",
    "Hatay",
    "Iğdır",
    "Isparta",
    "İçel",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kilis",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Kahramanmaraş",
    "Mardin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Siirt",
    "Sinop",
    "Sivas",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Şanlıurfa",
    "Şırnak",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak"
  ];

  initState() {
    callPets();
  }

  String selectedPet;
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedCity;
  String showCity = "İzmir";
  String selectedOrder;
  String showOrder = "Rating";

  Pet showPet;
  String showPetName = "Select";
  @override
  Widget build(BuildContext context) {
    List<int> selectedRatio = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    ModalRoute route = ModalRoute.of(context);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Walking>>(
        future: classFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Stack(
              children: [
                Stack(
                  children: [
                    Mysafearea(size: size),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: size.height * 0.53,
                    ),
                    InkWell(
                      child: Container(
                        width: size.width * 0.16,
                        height: size.height * 0.05,
                        alignment: Alignment(0, 0),
                        child: Icon(Icons.add),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, 'addwalk',
                            arguments: showCity);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: size.height * 0.40,
                      width: size.width * 0.10,
                    ),
                    Container(
                      width: size.width * 0.50,
                      child: Text(
                        "The avaible walkings are listed in $showCity",
                        style: TextStyle(fontSize: size.width * 0.025),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.18,
                    ),
                    SizedBox(
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              showOrder,
                              style: TextStyle(
                                  fontSize: size.width * 0.03,
                                  color: Colors.black),
                            ),
                            Icon(Icons.arrow_drop_down_rounded),
                          ],
                        ),
                        style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                bool changed = false;
                                return Column(
                                  children: [
                                    Flexible(
                                      child: CupertinoPicker(
                                        itemExtent: size.height * 0.06,
                                        onSelectedItemChanged: (order) {
                                          changed = true;
                                          setState(() {
                                            selectedOrder = orderBy[order];
                                          });
                                        },
                                        children: [
                                          for (String order in orderBy)
                                            Text(order),
                                        ],
                                      ),
                                    ),
                                    CupertinoActionSheetAction(
                                        onPressed: () {
                                          if (showPetName == "Select") {
                                            showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return CupertinoAlertDialog(
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                    title: Text("Missing"),
                                                    content: Text(
                                                        "Please Choose a Pet"),
                                                  );
                                                });
                                            return;
                                          }
                                          setState(() {
                                            showOrder = selectedOrder;
                                            if (changed == false)
                                              showOrder = orderBy[0];
                                          });
                                          classFuture = callWalks(showCity,
                                              showPet.race, showOrder);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Done"))
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.30,
                    ),
                    for (int i = 0; i < snapshot.data.length; i++)
                      InkWell(
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.10,
                              ),
                              Container(
                                width: size.width * 0.25,
                                height: size.width * 0.25,
                                child: ClipRRect(
                                  child: Image.network(
                                    snapshot.data[i].coverimage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    )),
                              ),
                              SizedBox(
                                width: size.width * 0.06,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.03),
                                          child: Text(snapshot.data[i].title,
                                              style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  fontSize: size.width * 0.05)),
                                        ),
                                        Text(
                                            (snapshot.data[i].rating == -1
                                                    ? "..."
                                                    : snapshot.data[i].rating
                                                        .toString()) +
                                             
                                                "    ",
                                            style: TextStyle(
                                                fontFamily: "Quicksand",
                                                fontSize: size.width * 0.05)),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.0,
                                          vertical: size.height * 0.03),
                                      child: Text("${snapshot.data[i].price}₺"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'showwalk',
                            arguments: snapshot.data[i],
                          );
                        },
                      )
                  ],
                ),
                Positioned(
                  top: size.height * 0.07,
                  child: Container(
                      width: size.width * 1,
                      height: size.height * 0.09,
                      color: Color(0xffD98007),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.13,
                              ),
                              Text("City"),
                              SizedBox(
                                width: size.width * 0.13,
                              ),
                              SizedBox(
                                width: size.width * 0.24,
                              ),
                              Text("Pet"),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                            width: size.width,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.10,
                              ),
                              SizedBox(
                                width: size.width * 0.30,
                                height: size.height * 0.04,
                                child: TextButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "   " + showCity,
                                        style: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.black),
                                      ),
                                      Icon(Icons.arrow_drop_down_rounded),
                                    ],
                                  ),
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          bool changed = false;
                                          return Column(
                                            children: [
                                              Flexible(
                                                child: CupertinoPicker(
                                                  itemExtent:
                                                      size.height * 0.06,
                                                  onSelectedItemChanged:
                                                      (city) {
                                                    setState(() {
                                                      changed = true;
                                                      selectedCity =
                                                          cities[city];
                                                    });
                                                  },
                                                  children: [
                                                    for (String city in cities)
                                                      Text(city),
                                                  ],
                                                ),
                                              ),
                                              CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    if (showPetName ==
                                                        "Select") {
                                                      showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              false, // user must tap button!
                                                          builder: (BuildContext
                                                              context) {
                                                            return CupertinoAlertDialog(
                                                              actions: [
                                                                CupertinoDialogAction(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                              title: Text(
                                                                  "Missing"),
                                                              content: Text(
                                                                  "Please Choose a Pet"),
                                                            );
                                                          });
                                                      return;
                                                    }
                                                    setState(() {
                                                      showCity = changed == true
                                                          ? selectedOrder
                                                          : cities[0];
                                                    });
                                                    classFuture = callWalks(
                                                        showCity,
                                                        showPet.race,
                                                        showOrder);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Done"))
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.12,
                              ),
                              SizedBox(
                                width: size.width * 0.35,
                                height: size.height * 0.04,
                                child: TextButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "    " + showPetName,
                                        style: TextStyle(
                                            fontSize: size.width * 0.03,
                                            color: Colors.black),
                                      ),
                                      Icon(Icons.arrow_drop_down_rounded),
                                    ],
                                  ),
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          bool changed = false;
                                          return Column(
                                            children: [
                                              Flexible(
                                                child: CupertinoPicker(
                                                  itemExtent:
                                                      size.height * 0.06,
                                                  onSelectedItemChanged:
                                                      (number) {
                                                    setState(() {
                                                      changed = true;
                                                      selectedPet =
                                                          pets[number].name;
                                                    });
                                                  },
                                                  children: [
                                                    for (Pet pet in pets)
                                                      Text(pet.name),
                                                  ],
                                                ),
                                              ),
                                              CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    setState(() {
                                                      for (var i = 0;
                                                          i < pets.length;
                                                          i++) {
                                                        if (pets[i].name ==
                                                            selectedPet) {
                                                          showPet = pets[i];
                                                          showPetName =
                                                              selectedPet;
                                                        }
                                                      }
                                                      if (changed == false) {
                                                        showPet = pets[0];
                                                        showPetName =
                                                            pets[0].name;
                                                      }
                                                      classFuture = callWalks(
                                                          showCity,
                                                          showPet.race,
                                                          showOrder);
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Done"))
                                            ],
                                          );
                                        });
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                )
              ],
            ));
          } else
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                )
              ],
            );
        });
  }

  callPets() async {
    List<String> petids;
    await FirebaseAuthenticationService.getPetIds().then((s) => setState(() {
          petids = s;
        }));

    await FirebaseAuthenticationService.getPets(petids)
        .then((s) => setState(() {
              pets = s;
            }));

    if (pets.isEmpty) {
      classFuture = callWalks("İzmir", "", showOrder);
    } else {
      classFuture = callWalks("İzmir", pets[0].race, showOrder);
    }
  }

  Future<List<Walking>> callWalks(
      String city, String pettype, String showOrder) async {
    walks = await FirebaseAuthenticationService.getWalks(
        city, pettype, showOrder.toLowerCase());

    return walks;
  }
}
