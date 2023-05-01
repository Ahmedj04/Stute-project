import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:locally/locally.dart';
import 'package:online_tutor_app/GoogleMaps/Custom_GoogleMAP.dart';
import 'package:online_tutor_app/GoogleMaps/setLocation.dart';
import 'package:online_tutor_app/Homepage.dart';
import 'package:online_tutor_app/dummyscreens/HomeScreen.dart';

import '../firebase_services.dart';

class Upload_Event_Screen extends StatefulWidget {
  const Upload_Event_Screen({Key? key}) : super(key: key);
  @override
  State<Upload_Event_Screen> createState() => _Upload_Event_ScreenState();
}

class _Upload_Event_ScreenState extends State<Upload_Event_Screen>  {

  final titlecontroller=TextEditingController();
  final descriptioncontroller=TextEditingController();
  final pricecontroller=TextEditingController();
  final addresscontroller=TextEditingController();
  final location2controller=TextEditingController();
  final experiencecontroller=TextEditingController();
  final modecontroller=TextEditingController();
  User? user=FirebaseAuth.instance.currentUser;
  FirebaseServices services= FirebaseServices();
  final formkey=GlobalKey<FormState>();
  bool isloading=false;
  String? _chosenValue;
  String? _chosenValue2;
  String? _chosenValue3;

  final usernamecontroller=TextEditingController();
  final phonenumbercontroller=TextEditingController();
  final parentuidcontroller=TextEditingController();

  // bool disabled=false;
  bool uploadedBtnDisabled=false;


  var latitude="";
  var longitude="";

  late String temp;

  // String? latitude;
  // String? longitude;

  var db = FirebaseFirestore.instance;

  void initState() {
    // print ('fetching user post_details');
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
  final EventPosted=SnackBar(
    content: Text('Event posted'),
    duration: Duration(seconds: 1),
    action: SnackBarAction(onPressed: (){},label: 'close',textColor: Colors.red,),
  );

  @override
  Widget build(BuildContext context) {
    Locally locally = Locally(
      context: context,
      payload: 'test',
      pageRoute:  MaterialPageRoute(builder: (context) => HomeScreen()),
      appIcon: 'mipmap/ic_launcher',
    );
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text('Upload Event Teacher',
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
            onPressed: uploadedBtnDisabled?null:() async{
              if (formkey.currentState!.validate()) {
                await  db.collection('Users').doc(user!.uid).update({
                  'numberOfPosts': FieldValue.increment(1),
                });
                setState(() {
                  isloading = true;
                  uploadedBtnDisabled=true;
                });
                temp= await services.savedEventdata_teachers(
                  usernamecontroller.text,
                  titlecontroller.text,
                  descriptioncontroller.text,
                  parentuidcontroller.text,
                  // phonenumbercontroller.text,
                  // addresscontroller.text,
                  // latitude,
                  // longitude,
                ).whenComplete(() =>
                {
                  Timer(Duration(seconds: 1), () {
                    ScaffoldMessenger.of(context).showSnackBar(EventPosted);
                    // locally.show(title: titlecontroller, message: descriptioncontroller);
                    Navigator.pop(context);
                    // print(temp.toString()+" mae upload screeen mae hunnnnnnnnn");
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SetLocation(currentPostid: temp.toString(),)));
                  }),
                });
                locally.show(title: titlecontroller.text, message: descriptioncontroller.text ,);

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
                            return 'You must add Title to the Event';
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
                          label: Text('Title',style:TextStyle(color:Colors.grey)),
                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                        ),
                      ),
                      SizedBox(height: 40,),
                      TextFormField(
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must add Description to the Event';
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
                          label: Text('Description',style:TextStyle(color:Colors.grey)),
                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                        ),
                      ),

                      // SizedBox(height: 40,),


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
