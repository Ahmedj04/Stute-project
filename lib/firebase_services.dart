import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'LoginScreen.dart';


class FirebaseServices{

  Future <dynamic> dynamiclogin(email,password) async{
    UserCredential? userCredentials;
    userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return userCredentials;
  }

  // Future <dynamic> dynamiclogin_using_phonenumber(phonenumber) async{
  //   UserCredential? userCredentials;
  //   userCredentials = await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
  //   return userCredentials;
  // }

  Future <DocumentSnapshot> getUserId(id) async{
    DocumentSnapshot doc=await FirebaseFirestore.instance.collection('Users').doc(id).get();
    return doc;
  }


// -----------no need of them in actual project just for dummy screen-------------------------------------
//   Future <DocumentSnapshot> getTeacherUserId(id) async{
//     DocumentSnapshot doc=await FirebaseFirestore.instance.collection('Teachers').doc(id).get();
//     return doc;
//   }
//
//   Future <DocumentSnapshot> getStudentUserId(id) async{
//     DocumentSnapshot doc=await FirebaseFirestore.instance.collection('Students').doc(id).get();
//     return doc;
//   }
// ----------------------------------------upto this-----------------------------------------------------------


  Future<void> logout(context) async{
    FirebaseAuth.instance.signOut();
    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dynamic_login()));
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        LoginScreen()), (Route<dynamic> route) => false);
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Dynamic_login()));

  }

  Future<void> deletepost(id)async{
    EasyLoading.show(status: 'Deleting...');
    await FirebaseFirestore.instance.collection("Posts").doc(id).delete();
    EasyLoading.showSuccess("Post Deleted");

  }
  Future<void> deleteEvent(id)async{
    EasyLoading.show(status: 'Deleting...');
    await FirebaseFirestore.instance.collection("Events").doc(id).delete();
    EasyLoading.showSuccess("Event Deleted");

  }


  //-----------first creating collection 'POSTS 'and storing it in variable 'data'----------------------
  CollectionReference data=FirebaseFirestore.instance.collection('Posts');
String? price="";
  Future saveddata_students(
      String? name,
      String? title ,
      String? description,
      price,
      String? number,
      String? address,
      String? parent_uid,
      String? experience,
      String? teachingmode,
      String? latitude,
      String? longitude,
      ) async{
    var r = Random();
    String chars='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String id=List.generate(20, (index) => chars[r.nextInt(chars.length)]).join();
    var currentPostid = id;
    await data.doc(id).set({
      'Name':name,
      'Title':title,
      'Description':description,
      'Price':price,
      'Phone Number':number,
      'Address':address,
      'id':id,
      'Parent UID':parent_uid,
      'Experience':experience,
      'Teaching Mode':teachingmode,
      'Latitude': latitude,
      'Longitude': longitude,
      'DateTime':DateTime.now()
    });
    return currentPostid;

  }

  Future<String> saveddata_teachers(
      String? name,
      String? title ,
      String? description,
      price,
      String? phonenumber,
      String? experience,
      String? teachingmode,
      String? address,
      String? parent_uid,
      String? latitude,
      String? longitude,

      ) async{
    var r = Random();
    String chars='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String id=List.generate(20, (index) => chars[r.nextInt(chars.length)]).join();
    var currentPostid = id;
      await data.doc(id).set({
      'Name':name,
      'Title':title,
      'Description':description,
      'Price':price,
      'Phone Number':phonenumber,
      'Address':address,
      'Experience':experience,
      'Teaching Mode':teachingmode,
      'id':id,
      'Parent UID':parent_uid,
      'Latitude': latitude,
      'Longitude': longitude,
      'DateTime':DateTime.now()
    });
      return currentPostid;
  }

  //-----------first creating collection 'Events 'and storing it in variable 'eventdata'----------------------
  CollectionReference eventdata=FirebaseFirestore.instance.collection('Events');
  Future<String> savedEventdata_teachers(
      String? name,
      String? title ,
      String? description,
      String? parent_uid,

      ) async{
    var r = Random();
    String chars='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String id=List.generate(20, (index) => chars[r.nextInt(chars.length)]).join();
    var currentPostid = id;
    await eventdata.doc(id).set({
      'Name':name,
      'Title':title,
      'Description':description,
      'id':id,
      'Parent UID':parent_uid,
      'DateTime':DateTime.now(),
    });
    return currentPostid;
  }


}


