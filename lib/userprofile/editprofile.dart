import 'dart:developer';
import 'dart:io';

import 'package:fluffy/Authentication/Firebase.dart';
import 'package:fluffy/Objects/profile.dart';
import 'package:fluffy/Welcome/components/body.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

TextEditingController nameController = new TextEditingController();
TextEditingController surnameController = new TextEditingController();
TextEditingController ageController = new TextEditingController();
TextEditingController sexController = new TextEditingController();
TextEditingController cityController = new TextEditingController();
class userProfile extends StatefulWidget {
  userProfile({Key key}) : super(key: key);

  @override
  _userProfile createState() => _userProfile();
}
class _userProfile extends State<userProfile> {
  File _pickedImage;
  String url;
  @override
  Widget build(BuildContext context) {
    final userprofile = ModalRoute.of(context).settings.arguments as Profile;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.01),
              InputBox(
                color: Colors.lightBlue.shade200,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Name",
                    contentPadding: EdgeInsets.all(20.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              InputBox(
                color: Colors.deepPurple.shade200,
                child: TextField(
                  controller: surnameController,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Surname",
                    contentPadding: EdgeInsets.only(
                        top: size.height * 0.01, left: size.width * 0.05),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              InputBox(
                color: Colors.deepPurple.shade200,
                child: TextField(
                  controller: sexController,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Sex",
                    contentPadding: EdgeInsets.only(
                        top: size.height * 0.01, left: size.width * 0.05),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              InputBox(
                color: Colors.deepPurple.shade200,
                child: TextField(
                  controller: ageController,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Age",
                    contentPadding: EdgeInsets.only(
                        top: size.height * 0.01, left: size.width * 0.05),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              InputBox(
                color: Colors.deepPurple.shade200,
                child: TextField(
                  controller: cityController,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15),
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "City",
                    contentPadding: EdgeInsets.only(
                        top: size.height * 0.01, left: size.width * 0.05),
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Flexible(
                  child: SizedBox(
                      child: InkWell(
                child: Container(
                  width: size.width*0.30,
                  child: _pickedImage == null
                      ? Image.asset(
                          "assets/icons/camera.png",
                          width: size.width * 0.03,
                        )
                      :  Image.file(File(_pickedImage.path)),
                ),
                onTap: () async {
                  _showPickOptionsDialog(context);
                },
              ))),
              SizedBox(
                height: size.height * 0.07,
              ),
              RoundedButton(
                  text: "Done",
                  color: Colors.black.withOpacity(0.9),
                  textColor: Colors.white,
                  press: () {
                    setUserInfo(
                        nameController.text,
                        url,
                        cityController.text,
                        sexController.text,
                        surnameController.text,
                        ageController.text,
                        _pickedImage);
                    Navigator.pushNamed(context, 'stay');

                    /* if (logincount==1) {
                      Navigator.pushNamed(context, 'home');
                    } */
                  }),
            ],
          )),
    );
  }

  _loadPicker(ImageSource source) async {
    File picked = await ImagePicker.pickImage(source: source, imageQuality: 50);
    if (picked != null) {
      _cropImage(picked);
    }
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Take a picture"),
              onTap: () {
                _loadPicker(ImageSource.camera);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  setUserInfo(String name, String url, String city, String sex, String surname,
      String age, File _pickedImage) async {
    int logincount = await FirebaseAuthenticationService.getLoginCount();
    FirebaseAuthenticationService.uploadProfilPhoto(_pickedImage);
    FirebaseAuthenticationService.createUser(
        name, url, city, sex, surname, logincount, age);
    FirebaseAuthenticationService.setLoginCount(logincount);
  }
}

class InputBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final ValueChanged<String> onChanged;
  const InputBox({
    this.color,
    this.onChanged,
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.15,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: child,
    );
  }
}
