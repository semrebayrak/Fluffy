import 'package:fluffy/House/addhouse.dart';
import 'package:fluffy/Road/mainmenu.dart';
import 'package:fluffy/Road/addcar.dart';
import 'package:fluffy/Road/reservecar.dart';
import 'package:fluffy/Road/showcar.dart';
import 'package:fluffy/Stay/mainmenu.dart';
import 'package:fluffy/Walk/addwalk.dart';
import 'package:fluffy/Walk/mainmenu.dart';
import 'package:fluffy/Message/message.dart';
import 'package:fluffy/Profile/profile.dart';
import 'package:fluffy/User/Login/loginscreen.dart';
import 'package:fluffy/User/ResetPassword/resetpassword.dart';
import 'package:fluffy/Walk/reservewalk.dart';
import 'package:fluffy/Walk/showwalk.dart';
import 'package:fluffy/pet/showpet.dart';
import 'package:fluffy/pets/pets.dart';
import 'package:fluffy/userprofile/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:fluffy/Welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:fluffy/Authentication/Firebase.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'House/reservehouse.dart';
import 'House/showhouse.dart';
import 'User/CreateAccount/createaccount.dart';
import 'VaccineCalendar/calendar.dart';

final auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Fluffy());
}

class Fluffy extends StatelessWidget {
  @override
  Widget getScreenId() {
    return StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (FirebaseAuthenticationService.current != null) {
            return Stay();
          } else
            return Welcome();
        });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fluffy",
      theme: ThemeData(
          primaryColor: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: Welcome(),
      routes: {
        // When navigating to the "homeScreen" route, build the HomeScreen widget.
        'create': (context) => CreateAccount(),
        'stay': (context) => Stay(),
        'walk': (context) => Walk(),
        'enter': (context) => Fluffy(),
        'message': (context) => PetList(),
        'login': (context) => LoginScreen(),
        'reset': (context) => ResetPassword(),
        'profile': (context) => ProfilePage(),
        'calendar': (context) => Calendar(),
        'pets': (context) => Pets(),
        'showhouse': (context) => ShowHouse(),
        'reservehouse': (context) => ReserveHouse(),
        'road': (context) => Road(),
        'showpet': (context) => ShowPet(),
        'showwalk': (context) => ShowWalk(),
        'reservewalk': (context) => ReserveWalk(),
        'editprofile': (context) => userProfile(),
        'addhouse': (context) => addHouse(),
        'addwalk': (context) => addWalk(),
        'addcar' : (context) => addCar(),
        'showcar' : (context) => showCar(),
        'reservecar': (context) => ReserveCar(),
        // When navigating to the "secondScreen" route, build the SecondScreen widget.
      },
    );
  }
}
