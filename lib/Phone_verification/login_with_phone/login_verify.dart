// import 'dart:async';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:online_tutor_app/Phone_verification/Register_phoneNumber/phone.dart';
import 'package:online_tutor_app/firebase_services.dart';

import 'login_phone.dart';



class Login_with_MyVerify extends StatefulWidget {

  const Login_with_MyVerify({Key? key}) : super(key: key);

  @override
  State<Login_with_MyVerify> createState() => _Login_with_MyVerifyState();
}

class _Login_with_MyVerifyState extends State<Login_with_MyVerify> {

  @override

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user=FirebaseAuth.instance.currentUser;
  FirebaseServices services=FirebaseServices();

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
              // Image.asset(
              //   'assets/images/otp.png',
              //   width: 150,
              //   height: 150,
              // ),
              Image(image: NetworkImage("https://thumbs.dreamstime.com/b/otp-code-one-time-unlock-password-illustration-otp-code-one-time-unlock-password-illustration-261562501.jpg")),

              SizedBox(
                height: 25,
              ),
              Text(
                "Login Using Phone",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "OTP is sent to your number "+Login_with_MyPhone.countryCode.text+Login_with_MyPhone.phoneno+"!\n",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              // Pinput(
              //    length: 6,
              //    // defaultPinTheme: defaultPinTheme,
              //    // focusedPinTheme: focusedPinTheme,
              //    // submittedPinTheme: submittedPinTheme,
              //    showCursor: true,
              //    // onCompleted: (pin) => print(pin),
              //  ),
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

                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: Login_with_MyPhone.verify, smsCode: code1+code2+code3+code4+code5+code6);
                        // PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code1+code2+code3+code4+code5+code6);
                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential).then((value) => {
                          services.getUserId(value.user!.uid).then((value) => {
                            if(value.exists){
                              Timer(Duration(seconds: 1), () {
                                EasyLoading.showSuccess("Welcome you logged in");

                                print('you have logged through phone number');

                                Navigator.pushNamedAndRemoveUntil(context, 'Homepage', (route) => false);
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomePage()));
                              })
                            }else{
                              EasyLoading.showError('Account not found in Database')
                            }
                          })
                        });

                        // link the user  with the credential
                        // await auth.currentUser!.linkWithCredential(credential);

                        // update the user phonenumber  with the credential
                        // await auth.currentUser!.updatePhoneNumber(credential);
                        //print('update hona chahiye authentication mae');


                      }
                      catch(e){
                        print('wrong OTP');
                        print(e.toString());
                        // EasyLoading.showError('Wrong Otp');
                        EasyLoading.showError(e.toString());
                      }

                    },
                    child: Text("Verify the code")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   'phone',
                        //       (route) => false,
                        // );
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            Login_with_MyPhone()), (Route<dynamic> route) => false);
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