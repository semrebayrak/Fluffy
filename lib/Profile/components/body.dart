import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/Objects/profile.dart';
import 'package:fluffy/pets/pet.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluffy/Authentication/Firebase.dart';
import '../../Authentication/Firebase.dart';

List<Pet> pets;

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

Future classFuture;

class _Body extends State<Body> {
  initState() {
    classFuture = loadInformation();
  }

  File _pickedImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<Profile>(
        future: classFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Stack(children: [
              Container(
                width: size.width * 1,
                height: size.height / 5,
                decoration: BoxDecoration(color: Color(0xffB6D907)),
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.11,
                    height: size.height * 0.45,
                  ),
                  Container(
                      child: Column(
                        children: [
                          InkWell(
                            child: Container(
                              width: size.width * 0.78,
                              alignment: Alignment.topRight,
                              child: Icon(Icons.edit),
                            ),
                            onTap: () {
                              _showPickOptionsDialog(context);
                            },
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: size.width * 0.24,
                                child: Text(
                                  snapshot.data.sex,
                                  style: TextStyle(fontSize: size.width * 0.05),
                                ),
                              ),
                              Container(
                                height: size.height * 0.06,
                                width: size.width * 0.03,
                                child: VerticalDivider(
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: size.width * 0.24,
                                child: Text(
                                  snapshot.data.age,
                                  style: TextStyle(fontSize: size.width * 0.05),
                                ),
                              ),
                              Container(
                                height: size.height * 0.06,
                                width: size.width * 0.03,
                                child: VerticalDivider(
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: size.width * 0.24,
                                child: Text(
                                  snapshot.data.city,
                                  style: TextStyle(fontSize: size.width * 0.05),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      height: size.height * 0.10,
                      width: size.width * 0.78,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      )),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.16,

                        backgroundImage:
                            NetworkImage(snapshot.data.profilePicture==null? "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png":snapshot.data.profilePicture),
                        // _pickedImage != null ? FileImage(_pickedImage) : null,
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${snapshot.data.name} ${snapshot.data.surname}",
                          style: TextStyle(fontSize: size.width * 0.06))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text("     Pets",
                          style: TextStyle(fontSize: size.width * 0.05)),
                    ],
                  ),
                  Row(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            for (Pet pet in pets)
                              Container(
                                width: size.width * 0.23,
                                child: CircleAvatar(
                                  radius: size.width * 0.10,
                                  backgroundImage: NetworkImage(pet.petPic),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                    /*
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Container(
                        child: Text("Walking"),
                        alignment: Alignment.center,
                        width: size.width * 0.20,
                      ),
                      for (var i = 0; i < snapshot.data.ratings[0]; i++)
                        Container(
                          width: size.width * 0.06,
                          child: Image.asset("assets/star.png"),
                        )
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Container(
                        child: Text("Sitting"),
                        alignment: Alignment.center,
                        width: size.width * 0.20,
                      ),
                      for (var i = 0; i < snapshot.data.ratings[1]; i++)
                        Container(
                          width: size.width * 0.06,
                          child: Image.asset(
                            "assets/star.png",
                          ),
                        )
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
              

                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Container(
                          child: Text("Driving"),
                          alignment: Alignment.center,
                          width: size.width * 0.20,
                        ),
                        for (var i = 0; i < snapshot.data.ratings[2]; i++)
                          Container(
                            width: size.width * 0.06,
                            child: Image.asset("assets/star.png"),
                          )
                      ],
                    ),
                  ),

                  */
                ],
              ),
            ]);
          else
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

  Future<Profile> loadInformation() async {
    Profile profile = await FirebaseAuthenticationService.getSelfProfile();

    List<int> petids;

    await FirebaseAuthenticationService.getPets(profile.pets)
        .then((s) => setState(() {
              pets = s;
            }));

    return profile;
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

      FirebaseAuthenticationService.uploadProfilPhoto(_pickedImage);
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
}
