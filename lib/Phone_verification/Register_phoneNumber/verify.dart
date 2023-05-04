import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:online_tutor_app/Phone_verification/Register_phoneNumber/phone.dart';

class MyVerify extends StatefulWidget {

  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {

  @override

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user=FirebaseAuth.instance.currentUser;

   var code1="";
   var code2="";
   var code3="";
   var code4="";
   var code5="";
   var code6="";

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image(image: NetworkImage("https://thumbs.dreamstime.com/b/otp-code-one-time-unlock-password-illustration-otp-code-one-time-unlock-password-illustration-261562501.jpg")),

              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!\nOTP is sent to your number "+MyPhone.countryCode.text+MyPhone.phoneno,
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height:48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                          code1=value;
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                          )
                        ),
                      ),
                    ),

                    SizedBox(
                      height:48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                          code2=value;
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),

                    SizedBox(
                      height:48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                          code3=value;
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),

                    SizedBox(
                      height:48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                          code4=value;
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),

                    SizedBox(
                      height:48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length ==1){
                            FocusScope.of(context).nextFocus();
                          }
                          code5=value;
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),

                    SizedBox(
                      height:48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          // if(value.length ==1){
                          //   FocusScope.of(context).nextFocus();
                          // }
                          code6=value;
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),

                    onPressed: () async{

                      EasyLoading.show(status: "loading");
                      try{

                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code1+code2+code3+code4+code5+code6);

                        // Sign the user in (or link) with the credential
                        // await auth.signInWithCredential(credential);

                        // link the user  with the credential
                        // await auth.currentUser!.linkWithCredential(credential);

                       // update the user phonenumber  with the credential
                       // await auth.currentUser!.updatePhoneNumber(credential);
                        //print('update hona chahiye authentication mae');

                       await auth.currentUser!.linkWithCredential(credential).then((user) {
                         // print(auth.currentUser!.uid+"   link ke baaadd");
                          Timer(Duration(seconds: 2), () {
                            EasyLoading.showSuccess("Phone number confirmed successfully");
                            print('my phone number confirmed');
                            FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).update(
                                {
                                  'Phone Number':MyPhone.countryCode.text+MyPhone.phoneno
                                });

                            Navigator.pushNamedAndRemoveUntil(context, 'Homepage', (route) => false);
                          });
                        }).catchError((error) {
                          print(error.toString());
                        });
                      }
                      catch(e){
                        print('wrong OTP');
                        // EasyLoading.showError('Wrong Otp');
                        EasyLoading.showError(e.toString());
                      }

                    },
                    child: Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                              (route) => false,
                        );

                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}