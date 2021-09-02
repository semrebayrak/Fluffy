import 'dart:developer';
import 'dart:io';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/Stay/components/safearea.dart';
import 'package:fluffy/VaccineCalendar/components/body.dart';
import 'package:fluffy/pets/pet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final priceController = TextEditingController();
final descriptionController = TextEditingController();

class addHouse extends StatefulWidget {
  @override
  _addHouseState createState() => _addHouseState();
}

List<Pet> pets;
bool run = false;

class _addHouseState extends State<addHouse> {
  initState() {
    callPets();
  }

  List<int> selectedRatio = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  String imageURL;
  File _pickedImage;
  @override
  Widget build(BuildContext context) {
    String showCity = ModalRoute.of(context).settings.arguments;

    Size size = MediaQuery.of(context).size;
    if (run) {
      return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Mysafearea(size: size),
            ),
            Positioned(
                top: size.height * 0.14,
                left: size.width * 0.60,
                child: Container(
                  width: size.width * 0.30,
                  height: size.height * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: size.width * 0.025, top: 2),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(),
                        hintText: 'Price'),
                  ),
                )),
            Positioned(
                top: size.height * 0.20,
                left: size.width * 0.30,
                child: Container(
                  width: size.width * 0.60,
                  height: size.height * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: size.width * 0.025, top: 2),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(),
                        hintText: 'Title'),
                  ),
                )),
            Positioned(
                top: size.height * 0.12,
                left: size.width * 0.05,
                child: Text(
                  "Photo",
                  style: TextStyle(fontSize: size.width * 0.07),
                )),
            Positioned(
              top: size.height * 0.17,
              left: size.width * 0.05,
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      height: size.height * 0.10,
                      width: size.width * 0.20,
                      child: _pickedImage == null ? Icon(Icons.add) : null,
                      decoration: BoxDecoration(
                        image: _pickedImage == null
                            ? null
                            : DecorationImage(
                                image: FileImage(File(_pickedImage.path))),
                        color: Colors.grey.withOpacity(0.4),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    onTap: () {
                      _showPickOptionsDialog(context);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.30,
              child: Row(children: [
                SizedBox(
                  width: size.width * 0.10,
                ),
                Text(
                  "House Features",
                  style: TextStyle(fontSize: size.width * 0.05),
                ),
              ]),
            ),
            Positioned(
                top: size.height * 0.34,
                child: Container(
                  width: size.width,
                  height: size.height * 0.006, // Thickness
                  color: Colors.grey,
                )),
            Positioned(
              top: size.height * 0.35,
              child: Row(children: [
                SizedBox(
                  width: size.width * 0.10,
                ),
                Container(
                  width: size.width * 0.40,
                  child: Text(
                    "Garden ",
                    style: TextStyle(fontSize: size.width * 0.05),
                  ),
                ),
                Container(
                  width: size.width * 0.50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: selectedRatio[0],
                        activeColor: Colors.green,
                        onChanged: (val) {
                          setState(() {
                            selectedRatio[0] = val;
                          });
                        },
                      ),
                      Radio(
                        value: 2,
                        groupValue: selectedRatio[0],
                        activeColor: Colors.red,
                        onChanged: (val) {
                          setState(() {
                            selectedRatio[0] = val;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ]),
            ),
            Positioned(
              top: size.height * 0.45,
              child: Row(children: [
                SizedBox(
                  width: size.width * 0.10,
                ),
                Text(
                  "Add Pet  ",
                  style: TextStyle(fontSize: size.width * 0.05),
                ),
              ]),
            ),
            for (int i = 0; i < pets.length; i++)
              Positioned(
                top: size.height * (0.50 + (0.06 * i)),
                child: Row(children: [
                  SizedBox(
                    width: size.width * 0.10,
                  ),
                  Container(
                    width: size.width * 0.40,
                    child: Text(
                      pets[i].name,
                      style: TextStyle(fontSize: size.width * 0.05),
                    ),
                  ),
                  Container(
                    width: size.width * 0.50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedRatio[1 + i],
                          activeColor: Colors.green,
                          onChanged: (val) {
                            setState(() {
                              selectedRatio[1 + i] = val;
                            });
                          },
                        ),
                        Radio(
                          value: 2,
                          groupValue: selectedRatio[1 + i],
                          activeColor: Colors.red,
                          onChanged: (val) {
                            setState(() {
                              selectedRatio[1 + i] = val;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            Positioned(
                top: size.height * 0.49,
                child: Container(
                  width: size.width,
                  height: size.height * 0.006, // Thickness
                  color: Colors.grey,
                )),
            Positioned(
              top: size.height * (0.55 + (0.06 * pets.length)),
              child: Row(children: [
                SizedBox(
                  width: size.width * 0.10,
                ),
                Text(
                  "Accepted Pets",
                  style: TextStyle(fontSize: size.width * 0.05),
                ),
              ]),
            ),
            Positioned(
                top: size.height * (0.59 + (0.06 * pets.length)),
                child: Container(
                  width: size.width,
                  height: size.height * 0.006, // Thickness
                  color: Colors.grey,
                )),
            Positioned(
              top: size.height * (0.60 + (0.06 * pets.length)),
              child: Row(children: [
                SizedBox(
                  width: size.width * 0.10,
                ),
                Container(
                  width: size.width * 0.40,
                  child: Text(
                    "Dog ",
                    style: TextStyle(fontSize: size.width * 0.05),
                  ),
                ),
                Container(
                  width: size.width * 0.50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: selectedRatio[1 + pets.length],
                        activeColor: Colors.green,
                        onChanged: (val) {
                          setState(() {
                            selectedRatio[1 + pets.length] = val;
                          });
                        },
                      ),
                      Radio(
                        value: 2,
                        groupValue: selectedRatio[1 + pets.length],
                        activeColor: Colors.red,
                        onChanged: (val) {
                          setState(() {
                            selectedRatio[1 + pets.length] = val;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ]),
            ),
            Positioned(
                top: size.height * (0.66 + (0.06 * pets.length)),
                child: Container(
                  width: size.width,
                  child: Row(children: [
                    SizedBox(
                      width: size.width * 0.10,
                    ),
                    Container(
                      width: size.width * 0.40,
                      child: Text(
                        "Cat",
                        style: TextStyle(fontSize: size.width * 0.05),
                      ),
                    ),
                    Container(
                      width: size.width * 0.50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: selectedRatio[2 + pets.length],
                            activeColor: Colors.green,
                            onChanged: (val) {
                              setState(() {
                                selectedRatio[2 + pets.length] = val;
                              });
                            },
                          ),
                          Radio(
                            value: 2,
                            groupValue: selectedRatio[2 + pets.length],
                            activeColor: Colors.red,
                            onChanged: (val) {
                              setState(() {
                                selectedRatio[2 + pets.length] = val;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ]),
                )),
            Positioned(
                top: size.height * (0.76 + (0.06 * pets.length)),
                child: InkWell(
                  onTap: () {
                    if (_pickedImage != null) {
                      uploadPhoto();
                      List<String> ownings = [];
                      List<String> acceptedpets = [];
                      if (selectedRatio[0] == 1) {
                        ownings.add("Garden");
                      }

                      for (var i = 0; i < pets.length; i++) {
                        if (selectedRatio[i + 1] == 1)
                          ownings.add(pets[i].race);
                      }
                      if (selectedRatio[1 + pets.length] == 1) {
                        acceptedpets.add("Dog");
                      }
                      if (selectedRatio[2 + pets.length] == 1) {
                        acceptedpets.add("Cat");
                      }
                      FirebaseAuthenticationService.addHouse(
                        descriptionController.text.toString(),
                        priceController.text.toString(),
                        ownings,
                        acceptedpets,
                        imageURL,
                        showCity,
                      ).then((value) => {
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
                                    title: Text("Added"),
                                    content: Text("House Added"),
                                  );
                                })
                          });
                    } else {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
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
                              title: Text("Missing Argument"),
                              content: Text("Please pick a photo"),
                            );
                          });
                    }
                  },
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_business_rounded,
                          color: Colors.green,
                        ),
                        Text("   Add"),
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
                    ),
                  ),
                ))
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
  }

  callPets() async {
    List<String> petids;
    await FirebaseAuthenticationService.getPetIds().then((s) => setState(() {
          petids = s;
        }));

    await FirebaseAuthenticationService.getPets(petids)
        .then((s) => setState(() {
              run = true;
              pets = s;
            }));
  }

  _loadPicker(ImageSource source) async {
    File picked = await ImagePicker.pickImage(source: source, imageQuality: 50);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(File picked) async {
    File cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarColor: Colors.red,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
      });
    }
  }

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("Pick from Gallery"),
              onTap: () {
                _loadPicker(ImageSource.gallery);
              },
            ),
            ListTile(
              title: Text("Take a picture"),
              onTap: () {
                _loadPicker(ImageSource.camera);
              },
            )
          ],
        ),
      ),
    );
  }

  uploadPhoto() {
    FirebaseAuthenticationService.uploadPhoto(_pickedImage)
        .then((value) => setState(() {
              imageURL = value;
            }));
    log(imageURL);
  }
}
