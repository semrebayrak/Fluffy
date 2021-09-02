import 'dart:developer';
import 'dart:io';

import 'package:fluffy/generalarea.dart';
import 'package:fluffy/pets/pet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../Authentication/Firebase.dart';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

int ct;
List<Pet> pets = [];
List<int> petids = [];
Size size;
File _pickedImage;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

Future petFuture;
String url;

class _BodyState extends State<Body> {
  initState() {
    petFuture = callAsyncFetch();
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController sexController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController specieController = new TextEditingController();
  static final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pet>>(
        future: petFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            size = MediaQuery.of(context).size;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Mysafearea(size: size),
                  InkWell(
                    child: Container(
                      height: size.height * 0.12,
                      width: size.width * 1,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                            "Add Pet",
                            style: TextStyle(
                                fontFamily: "Quicksand",
                                fontSize: size.width * 0.07,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: size.height / 2,
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: nameController,

                                      style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontSize: 15),
                                      // textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        contentPadding: EdgeInsets.only(
                                            top: size.height * 0.03,
                                            left: size.width * 0.10),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: sexController,

                                      style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontSize: 15),
                                      // textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Sex",
                                        contentPadding: EdgeInsets.only(
                                            top: size.height * 0.03,
                                            left: size.width * 0.10),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: ageController,

                                      style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontSize: 15),
                                      // textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "Age",
                                        contentPadding: EdgeInsets.only(
                                            top: size.height * 0.03,
                                            left: size.width * 0.10),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: specieController,
                                      style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontSize: 15),
                                      decoration: InputDecoration(
                                        hintText: "Pet Specie(Dog, cat etc.",
                                        contentPadding: EdgeInsets.only(
                                            top: size.height * 0.03,
                                            left: size.width * 0.10),
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.07,
                                  ),
                                  Flexible(
                                      child: SizedBox(
                                          child: InkWell(
                                    child: Container(
                                      child: Image.asset(
                                        "assets/icons/camera.png",
                                        width: size.width * 0.06,
                                      ),
                                    ),
                                    onTap: () async {
                                      gettCount();
                                      _showPickOptionsDialog(context, ct);
                                    },
                                  ))),
                                  SizedBox(
                                    height: size.height * 0.07,
                                  ),
                                  CupertinoActionSheetAction(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        url =
                                            await FirebaseAuthenticationService
                                                .uploadpetProfilPhoto(
                                                    _pickedImage, pid);
                                        Pet newpet = new Pet(
                                          name: nameController.text,
                                          petPic: url,
                                          sex: sexController.text,
                                          age: ageController.text,
                                          id: ct.toString(),
                                          race: specieController.text,
                                        );

                                        setState(() {
                                          snapshot.data.add((newpet));
                                          nameController.text;
                                          sexController.text;
                                          specieController.text;
                                          gettCount();
                                          ct++;
                                          int age =
                                              int.parse(ageController.text);

                                          FirebaseAuthenticationService
                                              .setPetCount(ct);
                                          FirebaseAuthenticationService
                                              .createPet(
                                                  nameController.text,
                                                  url,
                                                  sexController.text,
                                                  specieController.text,
                                                  ct,
                                                  age);
                                          /* FirebaseAuthenticationService
                                                      .getuserPetCount(); */
                                          FirebaseAuthenticationService
                                              .setuserPets(ct);
                                        });
                                      },
                                      child: Text("Done")),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                  for (int i = 0; i < snapshot.data.length; i++)
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: size.height * 0.12,
                          ),
                          SizedBox(
                            width: size.width * 0.10,
                          ),
                          CircleAvatar(
                            radius: size.width * 0.10,
                            backgroundImage:
                                NetworkImage(snapshot.data[i].petPic),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          SizedBox(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02),
                                child: Text(snapshot.data[i].name),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02),
                                child: Text(snapshot.data[i].race),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                ],
              ),
            );
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

  _cropImage(File picked, int pid) async {
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

      FirebaseAuthenticationService.uploadpetProfilPhoto(_pickedImage, pid);
    }
  }

  _loadPicker(ImageSource source, int pid) async {
    File picked = await ImagePicker.pickImage(source: source, imageQuality: 50);
    if (picked != null) {
      _cropImage(picked, pid);
    }
    Navigator.pop(context);
  }

  void _showPickOptionsDialog(BuildContext context, int pid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("Pick from Gallery"),
              onTap: () {
                _loadPicker(ImageSource.gallery, pid);
              },
            ),
            ListTile(
              title: Text("Take a picture"),
              onTap: () {
                _loadPicker(ImageSource.camera, pid);
              },
            )
          ],
        ),
      ),
    );
  }

  gettCount() async {
    return await FirebaseAuthenticationService.getPetCount()
        .then((s) => setState(() {
              ct = s;
            }));
  }
}

Future<List<Pet>> callAsyncFetch() async {
  return await FirebaseAuthenticationService.getPets(
      await FirebaseAuthenticationService.getPetIds());
}
