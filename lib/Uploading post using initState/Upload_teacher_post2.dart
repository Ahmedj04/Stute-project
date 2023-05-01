import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_tutor_app/GoogleMaps/Custom_GoogleMAP.dart';
import 'package:online_tutor_app/GoogleMaps/setLocation.dart';

import '../firebase_services.dart';

class Upload_teacher_postscreen2 extends StatefulWidget {
  const Upload_teacher_postscreen2({Key? key}) : super(key: key);
  @override
  State<Upload_teacher_postscreen2> createState() => _Upload_teacher_postscreen2State();
}

class _Upload_teacher_postscreen2State extends State<Upload_teacher_postscreen2>  {

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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text('Upload Post Teacher',
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
                       temp= await services.saveddata_teachers(
                            usernamecontroller.text,
                            titlecontroller.text,
                            descriptioncontroller.text,
                            pricecontroller.text,
                            phonenumbercontroller.text,
                            experiencecontroller.text,
                            modecontroller.text,
                            addresscontroller.text,
                            parentuidcontroller.text,
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
                          label: Text('Title',style:TextStyle(color:Colors.grey)),
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
                          label: Text('Description',style:TextStyle(color:Colors.grey)),
                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                        ),
                      ),

                      SizedBox(height: 40,),
                      // TextFormField(
                      //   enabled: true,
                      //   // validator: (value) {
                      //   //   if (value!.isEmpty) {
                      //   //     return 'You must add Price to the Post';
                      //   //   }
                      //   //   // else if(value.length<2){
                      //   //   //   return "Username should atleast be of 5 characters";
                      //   //   // }
                      //   //   setState(() {
                      //   //     pricecontroller.text=value;
                      //   //   });
                      //   //   return null;
                      //   // },
                      //   controller: pricecontroller,
                      //   keyboardType: TextInputType.multiline,
                      //   textInputAction: TextInputAction.newline,
                      //   maxLines: null,
                      //   style: const TextStyle(fontSize: 13.5),
                      //   decoration: const InputDecoration(
                      //     label: Text('Price',style:TextStyle(color:Colors.grey)),
                      //     hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                      //   ),
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price:',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 13,letterSpacing: .1),),
                          SizedBox(width: 10,),
                          DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _chosenValue3,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.deepPurple[400],
                            items: <String>[
                              'Expert for Graduates \n Course fee Rs.3999',
                              'Expert for Post Graduates \n Course fee Rs.4999',
                              'Expert for Researchers \n Course fee Rs.9999',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color:Colors.black),),
                              );
                            }).toList(),
                            hint:Text("Please choose your Price",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue3 = value;
                                if(_chosenValue3=='Expert for Graduates \n Course fee Rs.3999'){
                                  pricecontroller.text=_chosenValue3!;
                                }else if(_chosenValue3=='Expert for Post Graduates \n Course fee Rs.4999'){
                                  pricecontroller.text=_chosenValue3!;
                                }else if(_chosenValue3=='Expert for Researchers \n Course fee Rs.9999'){
                                  pricecontroller.text=_chosenValue3!;
                                }
                              });
                            },
                          ),
                        ],
                      ),


                      SizedBox(height: 40,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Experience:',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 13,letterSpacing: .1),),
                          SizedBox(width: 10,),
                          DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _chosenValue,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.deepPurple[400],
                            items: <String>[
                              'Beginner',
                              'Intermediate',
                              'Advance'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color:Colors.black),),
                              );
                            }).toList(),
                            hint:Text("Please choose your Experience",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue = value;
                                if(_chosenValue=='Beginner'){
                                  experiencecontroller.text=_chosenValue!;
                                }else if(_chosenValue=='Intermediate'){
                                  experiencecontroller.text=_chosenValue!;
                                }else if(_chosenValue=='Advance'){
                                  experiencecontroller.text=_chosenValue!;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Teaching Mode:',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 13,letterSpacing: .1),),
                          SizedBox(width: 10,),
                          DropdownButton<String>(
                            focusColor:Colors.white,
                            value: _chosenValue2,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.deepPurple[400],
                            items: <String>[
                              'Online',
                              'Offline',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color:Colors.black),),
                              );
                            }).toList(),
                            hint:Text("Please choose mode of teaching",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue2 = value;
                                if(_chosenValue2=='Online'){
                                  modecontroller.text=_chosenValue2!;
                                }else if(_chosenValue2=='Offline') {
                                  modecontroller.text = _chosenValue2!;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      // SizedBox(height: 40,),
                      // TextFormField(
                      //   enabled: true,
                      //   // validator: (value) {
                      //   //   if (value!.isEmpty) {
                      //   //     return 'You must add Price to the Post';
                      //   //   }
                      //   //   // else if(value.length<2){
                      //   //   //   return "Username should atleast be of 5 characters";
                      //   //   // }
                      //   //   setState(() {
                      //   //     pricecontroller.text=value;
                      //   //   });
                      //   //   return null;
                      //   // },
                      //   controller: locationcontroller,
                      //   keyboardType: TextInputType.multiline,
                      //   textInputAction: TextInputAction.newline,
                      //   maxLines: null,
                      //   style: const TextStyle(fontSize: 13.5),
                      //   decoration: const InputDecoration(
                      //     label: Text('Current Address Details',style:TextStyle(color:Colors.grey)),
                      //     hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      // ),

                      // InkWell(
                      //   onTap: disabled ?null : (){
                      //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomGoogleMap()));
                      //     setState(() {
                      //       disabled=true;
                      //     });
                      //   },
                      //   child: TextFormField(
                      //     enabled: false,
                      //     // initialValue: 'set location',
                      //     // validator: (value) {
                      //     //   if (value!.isEmpty) {
                      //     //     return 'You must add Price to the Post';
                      //     //   }
                      //     //   // else if(value.length<2){
                      //     //   //   return "Username should atleast be of 5 characters";
                      //     //   // }
                      //     //   setState(() {
                      //     //     pricecontroller.text=value;
                      //     //   });
                      //     //   return null;
                      //     // },
                      //     controller: location2controller,
                      //     keyboardType: TextInputType.multiline,
                      //     textInputAction: TextInputAction.newline,
                      //     maxLines: null,
                      //     style: const TextStyle(fontSize: 13.5),
                      //     decoration: const InputDecoration(
                      //       label: Text('Set your curent location',style:TextStyle(color:Colors.grey)),
                      //       hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                      //     ),
                      //   ),
                      // ),

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
