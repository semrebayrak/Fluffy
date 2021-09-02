import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluffy/Objects/car.dart';
import 'package:fluffy/Profile/profile.dart';
import 'package:fluffy/VaccineCalendar/components/body.dart';
import 'package:fluffy/Walk/mainmenu.dart';
import 'package:fluffy/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluffy/pets/pet.dart';
import '../Objects/appointment.dart';
import '../Objects/house.dart';
import '../Objects/profile.dart';
import '../Objects/walking.dart';

class FirebaseAuthenticationService {
  static final _auth = FirebaseAuth.instance;
  static final _fireStore = FirebaseFirestore.instance;
  static User signedInUser;
  static User current = auth.currentUser;
  static Future<bool> signUp(String name, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      signedInUser = authResult.user;

      if (signedInUser != null) {
        _fireStore.collection('users').doc(signedInUser.uid).set({
          'name': name,
          'email': email,
          'profilePicture': '',
          'coverImage': '',
          'bio': '',
          'pets': [],
        });
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      signedInUser = authResult.user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> createUser(String name, String profilePicture,
      String city, String sex, String surname, int login, String age) async {
    if (signedInUser != null) {
      log('yarattıuser');
      _fireStore.collection('users').doc(signedInUser.uid).update({
        'name': name,
        'profilePicture': profilePicture,
        'sex': sex,
        'city': city,
        'surname': surname,
        'age': age,
        'login': login.toDouble(),
      });
      return true;
    }
    return false;
  }

  static Future<int> getLoginCount() async {
    final snapshot = await _fireStore
        .collection('users')
        .doc(signedInUser.uid)
        .get(); //get the data

    int logincount = snapshot.data()['login'];

    return logincount;
  }

  static Future<bool> setLoginCount(int count) async {
    log('login count++');
    try {
      _fireStore.collection('users').doc(signedInUser.uid).update({
        'login': count + 1,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> uploadPhoto(File photo) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('photos')
        .child(signedInUser.uid)
        .child('house');

    UploadTask task = reference.putFile(photo);
    String url = await (await task).ref.getDownloadURL();

    return url;
  }

  static Future<bool> reset(String email) async {
    try {
      auth.sendPasswordResetEmail(
        email: email,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void logout() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  static Future<String> uploadProfilPhoto(File photo) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('photos')
        .child(signedInUser.uid)
        .child('profilephoto');

    UploadTask task = reference.putFile(photo);
    String url = await (await task).ref.getDownloadURL();

    _fireStore.collection('users').doc(signedInUser.uid).update({
      'profilePicture': url,
    });

    return url;
  }

  static Future<String> uploadpetProfilPhoto(File photo, int id) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('photos')
        .child(signedInUser.uid)
        .child('pets')
        .child(id.toString());

    UploadTask task = reference.putFile(photo);
    String url = await (await task).ref.getDownloadURL();

    return url;
  }

  static Future<bool> setAppointment(
      String petid, DateTime date, String description) async {
    final countshot = await _fireStore.collection('counts').doc('counts').get();

    int appointmentCounter = countshot.data()['ac'];

    _fireStore.collection('counts').doc('counts').update({
      'ac': ++appointmentCounter,
    });

    if (signedInUser != null) {
      _fireStore.collection('pets').doc(petid).update({
        'appointments': FieldValue.arrayUnion([appointmentCounter]),
      });

      _fireStore
          .collection('appointments')
          .doc(appointmentCounter.toString())
          .set({
        'appointmentid': appointmentCounter,
        'date': date,
        'description': description,
      });

      return true;
    }
    return false;
  }

  static Future<List<String>> getPetIds() async {
    final snapshot = await _fireStore
        .collection('users')
        .doc(signedInUser.uid)
        .get(); //get the data

    List<String> petids = List.from(snapshot.data()['pets']);

    return petids;
  }

  static Future<List<Appointment>> getAppointments(String petid) async {
    List<Appointment> appointments = [];

    final snapshotpet = await _fireStore
        .collection('pets')
        .doc(petid.toString())
        .get(); //get the data
    try {
      for (int item in List.from(snapshotpet.data()['appointments'])) {
        final snapshotappointment = await _fireStore
            .collection('appointments')
            .doc(item.toString())
            .get(); //get the data

        DateTime temp = DateTime.fromMicrosecondsSinceEpoch(
            snapshotappointment.data()['date'].microsecondsSinceEpoch);
        DateTime temp2 = temp.add(Duration(hours: 3));
        appointments.add(new Appointment(
          date: temp2,
          description: snapshotappointment.data()['description'],
          id: snapshotappointment.data()['id'],
        ));
      }

      return appointments;
    } catch (e) {
      return null;
    }
  }

  static Future<List<House>> getHouses(
      String city, String pettype, String orderType) async {
    List<House> houselist = [];
    bool descending = false;
    if (orderType == "rating") descending = true;
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (pettype != "any")
      snapshot = await _fireStore
          .collection('houses')
          .where("city", isEqualTo: city)
          .where("acceptedpets", arrayContains: pettype)
          .orderBy(orderType, descending: descending)
          .get();
    else
      snapshot = await _fireStore
          .collection('houses')
          .where("city", isEqualTo: city)
          .orderBy(orderType, descending: descending)
          .get();

    snapshot.docs.forEach((res) {
      houselist.add(new House(
        id: res.data()['id'],
        city: res.data()['city'].toString(),
        owner: res.data()['owner'].toString(),
        coverimage: res.data()['coverimage'].toString(),
        rating: res.data()['rating'].toDouble(),
        acceptedpets: List.from(res.data()['acceptedpets']),
        price: res.data()['price'],
        title: res.data()['title'],
        ownings: List.from(res.data()['ownings']),
        reserved: List.from(res.data()['reserved']),
      ));
    });

    return houselist;
  }

  static Future<List<Car>> getCars(String departure, String destination,
      String pettype, String orderType) async {
    List<Car> carlist = [];
    bool descending = false;
    if (orderType == "rating") descending = true;
    final snapshot = await _fireStore
        .collection('cars')
        .where("departure", isEqualTo: departure)
        .where("destination", isEqualTo: destination)
        .where("acceptedpets", arrayContains: pettype)
        .orderBy(orderType, descending: descending)
        .get();

    snapshot.docs.forEach((res) {
      carlist.add(new Car(
        id: res.data()['id'],
        owner: res.data()['owner'].toString(),
        brand: res.data()['brand'].toString(),
        model: res.data()['model'].toString(),
        coverimage: res.data()['coverimage'].toString(),
        plate: res.data()['plate'],
        acceptedpets: List.from(res.data()['acceptedpets']),
        price: res.data()['price'],
        rating: res.data()['rating'].toDouble(),
        ownings: List.from(res.data()['ownings']),
        reserved: List.from(res.data()['reserved']),
      ));
    });

    return carlist;
  }

  static Future<List<Pet>> getPets(List<String> petid) async {
    List<Pet> pets = [];
    for (int i = 0; i < petid.length; i++) {
      final snapshot = await _fireStore
          .collection('pets')
          .doc(petid[i].toString())
          .get(); //get the data

      pets.add(new Pet(
          id: snapshot.data()['id'],
          petPic: snapshot.data()['petPic'],
          age: snapshot.data()['age'],
          race: snapshot.data()['race'],
          sex: snapshot.data()['sex'],
          name: snapshot.data()['name']));
    }

    return pets;
  }

  static Future<int> getPetCount() async {
    final snapshot = await _fireStore
        .collection('counts')
        .doc('counts')
        .get(); //get the data

    int pc = snapshot.data()['pc'];

    return pc;
  }

  static Future<bool> setPetCount(int count) async {
    try {
      _fireStore.collection('counts').doc('petcount').set({
        'pc': count + 1,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setuserPets(int generalpet) async {
    try {
      await _fireStore.collection('users').doc(signedInUser.uid).update({
        'pets': FieldValue.arrayUnion([generalpet.toString()])
      }); //get the data

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> createPet(
      String name, String url, String sex, String race, int id, int age) async {
    if (signedInUser != null) {
      String document = id.toString();
      log('yarattı');
      _fireStore.collection('pets').doc(document).set({
        'name': name,
        'petPic': url,
        'sex': sex,
        'race': race,
        'id': document,
        'age': age.toString(),
        'appointments': [],
      });
      return true;
    }
    return false;
  }

  static Future<Profile> getSelfProfile() async {
    Profile profile;
    final snapshot = await _fireStore
        .collection('users')
        .doc(signedInUser.uid)
        .get(); //get the data

    profile = new Profile(
        name: snapshot.data()['name'],
        surname: snapshot.data()['surname'],
        age: snapshot.data()['age'],
        city: snapshot.data()['city'],
        number: snapshot.data()['number'],
        sex: snapshot.data()['sex'],
        pets: List.from(snapshot.data()['pets']),
        ratings: List.from(snapshot.data()['ratings']),
        profilePicture: snapshot.data()['profilePicture']);

    return profile;
  }

  static Future<Profile> getProfile(String userid) async {
    Profile profile;
    final snapshot =
        await _fireStore.collection('users').doc(userid).get(); //get the data

    profile = new Profile(
        name: snapshot.data()['name'],
        surname: snapshot.data()['surname'],
        age: snapshot.data()['age'],
        city: snapshot.data()['city'],
        number: snapshot.data()['number'],
        sex: snapshot.data()['sex'],
        pets: List.from(snapshot.data()['pets']),
        ratings: List.from(snapshot.data()['ratings']),
        profilePicture: snapshot.data()['profilePicture']);

    return profile;
  }

  static Future<bool> setHouseReservation(DateTime date, House house) async {
    try {
      await _fireStore.collection('houses').doc(house.id.toString()).update({
        'reserved':
            FieldValue.arrayUnion(["${date.day}-${date.month}-${date.year}"])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Walking>> getWalks(
      String city, String pettype, String orderType) async {
    bool descending = false;
    List<Walking> walklist = [];
    if (orderType == "rating") descending = true;
    final snapshot = await _fireStore
        .collection('walks')
        .where("city", isEqualTo: city)
        .where("acceptedpets", arrayContains: pettype)
        .orderBy(orderType, descending: descending)
        .get();

    snapshot.docs.forEach((res) {
      walklist.add(new Walking(
        description: res.data()['description'].toString(),
        id: res.data()['id'],
        city: res.data()['city'].toString(),
        rating: res.data()['rating'].toDouble(),
        walker: res.data()['walker'].toString(),
        coverimage: res.data()['coverimage'].toString(),
        acceptedpets: List.from(res.data()['acceptedpets']),
        price: res.data()['price'],
        title: res.data()['title'],
        reserved: List.from(res.data()['reserved']),
        ownings: List.from(res.data()['ownings']),
        type: res.data()['type'],
      ));
    });

    return walklist;
  }

  static Future<bool> addHouse(String title, String price, List<String> ownings,
      List<String> acceptedpets, String coverimage, String city) async {
    if (signedInUser != null) {
      final snapshot =
          await _fireStore.collection('counts').doc('counts').get();

      int houseCounter = snapshot.data()['hc'];

      _fireStore.collection('counts').doc('counts').update({
        'hc': ++houseCounter,
      });
      _fireStore.collection('houses').doc(houseCounter.toString()).set({
        'rating': -1,
        'title': title,
        'price': int.parse(price),
        'ownings': ownings,
        'acceptedpets': acceptedpets,
        'city': city,
        'coverimage': coverimage,
        'id': houseCounter.toString(),
        'owner': signedInUser.uid,
        'reserved': [],
      });
      log(houseCounter.toString());
      _fireStore.collection('users').doc(signedInUser.uid).update({
        'houses': FieldValue.arrayUnion([houseCounter.toString()]),
      });
      return true;
    }
    return false;
  }

  static Future<bool> addCar(
      String brand,
      String model,
      String price,
      List<String> ownings,
      List<String> acceptedpets,
      String coverimage,
      String plate,
      String departure,
      String destination) async {
    if (signedInUser != null) {
      final snapshot =
          await _fireStore.collection('counts').doc('counts').get();

      int carCounter = snapshot.data()['cc'];

      _fireStore.collection('counts').doc('counts').update({
        'cc': ++carCounter,
      });
      _fireStore.collection('cars').doc(carCounter.toString()).set({
        'rating': -1,
        'id': carCounter.toString(),
        'brand': brand,
        'model': model,
        'coverimage': ownings,
        'acceptedpets': acceptedpets,
        'price': price,
        'ownings': ownings,
        'owner': signedInUser.uid,
        'reserved': [],
        'plate': plate,
        'departure': departure,
        'destination': destination,
      });

      _fireStore.collection('users').doc(signedInUser.uid).update({
        'cars': FieldValue.arrayUnion([carCounter.toString()]),
      });
      return true;
    }
    return false;
  }

  static Future<bool> addWalk(
    String title,
    String city,
    String coverimage,
    List<String> acceptedpets,
    List<String> ownings,
    String price,
  ) async {
    if (signedInUser != null) {
      final snapshot =
          await _fireStore.collection('counts').doc('counts').get();

      int walkCounter = snapshot.data()['wc'];

      _fireStore.collection('counts').doc('counts').update({
        'wc': ++walkCounter,
      });
      await _fireStore.collection('walks').doc(walkCounter.toString()).set({
        'id': walkCounter.toString(),
        'city': city,
        'walker': signedInUser.uid,
        'coverimage': coverimage,
        'acceptedpets': acceptedpets,
        'price': price,
        'title': title,
        'reserved': [],
        'ownings': ownings,
        'rating': -1,
      });
      return true;
    }
    return false;
  }

  static Future<bool> setWalkReservation(DateTime date, Walking walk) async {
    try {
      await _fireStore.collection('walks').doc(walk.id.toString()).update({
        'reserved':
            FieldValue.arrayUnion(["${date.day}-${date.month}-${date.year}"])
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
