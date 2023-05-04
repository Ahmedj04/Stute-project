import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../GoogleMaps/setLocation.dart';
import '../firebase_services.dart';

class Upload_Student_postscreen2 extends StatefulWidget {
  const Upload_Student_postscreen2({Key? key}) : super(key: key);

  @override
  State<Upload_Student_postscreen2> createState() => _Upload_Student_postscreen2State();
}

class _Upload_Student_postscreen2State extends State<Upload_Student_postscreen2>  {

  final titlecontroller=TextEditingController();
  final descriptioncontroller=TextEditingController();
  final pricecontroller=TextEditingController();
  final addresscontroller=TextEditingController();
  final experiencecontroller=TextEditingController();
  final teachingmodecontroller=TextEditingController();

  User? user=FirebaseAuth.instance.currentUser;
  FirebaseServices services= FirebaseServices();
  var db = FirebaseFirestore.instance;

  final formkey=GlobalKey<FormState>();

  bool isloading=false;
  bool uploadedBtnDisabled=false;


  var latitude="";
  var longitude="";

  late String temp;

  final usernamecontroller=TextEditingController();
  final phonenumbercontroller=TextEditingController();
  final parentuidcontroller=TextEditingController();


  void initState() {
    print ('fetching user post_details');
    getDetails();
    super.initState();
  }

  Future<void> getDetails() async{
    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).get().then((value) => {
      setState((){
        usernamecontroller.text=value['Name'];
        phonenumbercontroller.text=value['Phone Number'];
        parentuidcontroller.text=value['UID'];
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text('Upload Post Student',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontFamily: 'times new roman',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            //  letterSpacing: 2,
          ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.close, color: Colors.black, size: 29,)
        ),

        actions: [
          IconButton(
            onPressed:  uploadedBtnDisabled?null:() async{
              await  db.collection('Users').doc(user?.uid).update({
                'numberOfPosts': FieldValue.increment(1),
              });
              if (formkey.currentState!.validate()) {
               temp= await services.saveddata_students(
                  usernamecontroller.text,
                  titlecontroller.text,
                  descriptioncontroller.text,
                  pricecontroller.text,
                  phonenumbercontroller.text,
                  addresscontroller.text,
                  parentuidcontroller.text,
                  experiencecontroller.text,
                  teachingmodecontroller.text,
                  latitude,
                  longitude,
                ).whenComplete(() =>
                {

                  Timer(Duration(seconds: 1), () {
                    // Navigator.pop(context);
                    // print(temp.toString()+" mae upload screeen mae hunnnnnnnnn");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SetLocation(currentPostid: temp.toString(),)));

                  })

                });

                setState(() {
                  isloading = true;
                  uploadedBtnDisabled=true;

                });

              }

            },
            icon: isloading ? SizedBox( height: 15,width: 15, child: CircularProgressIndicator(color:Colors.blue, strokeWidth: 2.5,)):Icon(Icons.check , color:Colors.blue),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key:formkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must add Title to the Post';
                          }
                          // else if(value.length<2){
                          //   return "Username should atleast be of 5 characters";
                          // }
                          setState(() {
                            titlecontroller.text=value;
                          });
                          return null;
                        },
                        controller: titlecontroller,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        style: const TextStyle(fontSize: 13.5),
                        decoration: const InputDecoration(
                          label: Text('Title*',style:TextStyle(color:Colors.grey)),
                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                        ),
                      ),
                      SizedBox(height: 40,),
                      TextFormField(
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must add Description to the Post';
                          }
                          // else if(value.length<2){
                          //   return "Username should atleast be of 5 characters";
                          // }
                          setState(() {
                            descriptioncontroller.text=value;
                          });
                          return null;
                        },
                        controller: descriptioncontroller,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        style: const TextStyle(fontSize: 13.5),
                        decoration: const InputDecoration(
                          label: Text('Description*',style:TextStyle(color:Colors.grey)),
                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                        ),
                      ),
                      SizedBox(height: 40,),
                      TextFormField(
                        enabled: true,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'You must add Price to the Post';
                        //   }
                        //   // else if(value.length<2){
                        //   //   return "Username should atleast be of 5 characters";
                        //   // }
                        //   setState(() {
                        //     pricecontroller.text=value;
                        //   });
                        //   return null;
                        // },
                        controller: pricecontroller,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        style: const TextStyle(fontSize: 13.5),
                        decoration: const InputDecoration(
                          label: Text('Price',style:TextStyle(color:Colors.grey)),
                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            )
          ],
        ),
      ),
    );
  }
}
