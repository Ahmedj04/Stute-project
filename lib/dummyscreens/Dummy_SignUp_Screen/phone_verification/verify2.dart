//  import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:online_tutor_app/Dummy_SignUp_Screen/phone_verification/phone2.dart';
// import 'package:online_tutor_app/Dummy_SignUp_Screen/phone_verification/phone_Signup_screen.dart';
//
//
// class MyVerify extends StatefulWidget {
//   const MyVerify({Key? key}) : super(key: key);
//
//   @override
//   State<MyVerify> createState() => _MyVerifyState();
// }
//
// class _MyVerifyState extends State<MyVerify> {
//
//   @override
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   User? user=FirebaseAuth.instance.currentUser;
//
//
//   var code1="";
//   var code2="";
//   var code3="";
//   var code4="";
//   var code5="";
//   var code6="";
//
//   String name="";
//   String address="";
//   String occupation="";
//   String password="";
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Image.asset(
//               //   'assets/images/otp.png',
//               //   width: 150,
//               //   height: 150,
//               // ),
//               Image(image: NetworkImage("https://thumbs.dreamstime.com/b/otp-code-one-time-unlock-password-illustration-otp-code-one-time-unlock-password-illustration-261562501.jpg")),
//               SizedBox(
//                 height: 25,
//               ),
//               Text(
//                 "Phone Verification2",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "We need to register your phone without getting started!",
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       height:48,
//                       width: 44,
//                       child: TextField(
//                         onChanged: (value){
//                           if(value.length ==1){
//                             FocusScope.of(context).nextFocus();
//                           }
//                           code1=value;
//                         },
//                         style: Theme.of(context).textTheme.headline6,
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)
//                             )
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       height:48,
//                       width: 44,
//                       child: TextField(
//                         onChanged: (value){
//                           if(value.length ==1){
//                             FocusScope.of(context).nextFocus();
//                           }
//                           code2=value;
//                         },
//                         style: Theme.of(context).textTheme.headline6,
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)
//                             )
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       height:48,
//                       width: 44,
//                       child: TextField(
//                         onChanged: (value){
//                           if(value.length ==1){
//                             FocusScope.of(context).nextFocus();
//                           }
//                           code3=value;
//                         },
//                         style: Theme.of(context).textTheme.headline6,
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)
//                             )
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       height:48,
//                       width: 44,
//                       child: TextField(
//                         onChanged: (value){
//                           if(value.length ==1){
//                             FocusScope.of(context).nextFocus();
//                           }
//                           code4=value;
//                         },
//                         style: Theme.of(context).textTheme.headline6,
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)
//                             )
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       height:48,
//                       width: 44,
//                       child: TextField(
//                         onChanged: (value){
//                           if(value.length ==1){
//                             FocusScope.of(context).nextFocus();
//                           }
//                           code5=value;
//                         },
//                         style: Theme.of(context).textTheme.headline6,
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)
//                             )
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       height:48,
//                       width: 44,
//                       child: TextField(
//                         onChanged: (value){
//                           // if(value.length ==1){
//                           //   FocusScope.of(context).nextFocus();
//                           // }
//                           code6=value;
//                         },
//                         style: Theme.of(context).textTheme.headline6,
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1),
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)
//                             )
//                         ),
//                       ),
//                     ),
//
//
//                   ],
//                 ),
//
//               ),
//
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.deepPurple[400],
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//
//                     onPressed: () async{
//
//                       EasyLoading.show(status: "loading");
//                       try{
//                         PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code1+code2+code3+code4+code5+code6);
//
//                         // Sign the user in (or link) with the credential
//                         await auth.signInWithCredential(credential);
//
//                         // Timer(Duration(seconds: 1), () {
//                         //   EasyLoading.showSuccess("Phone number confirmed successfully");
//                         // });
//                         EasyLoading.showSuccess("Phone number confirmed successfully");
//                         print(MyPhone.phoneno);
//                         FirebaseFirestore.instance.collection('Users').doc(user!.uid).set(
//                             {
//                               'UID': user!.uid,
//                               'Phone number':MyPhone.phoneno,
//                               'Name': name,
//                               'Password': password,
//                               'Address':address,
//                               'Occupation':occupation,
//                               'DateTime':DateTime.now(),
//                             });
//
//
//                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                              SignUpScreen2()), (Route<dynamic> route) => false);
//                       }
//                       catch(e){
//                         print('wrong OTP');
//                         print(e.toString());
//                         EasyLoading.showError('Wrong Otp');
//                       }
//
//                     },
//                     child: Text("Verify Phone Number")),
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pushNamedAndRemoveUntil(
//                           context,
//                           'phone2',
//                               (route) => false,
//                         );
//                         // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                         //     MyPhone()), (Route<dynamic> route) => false);
//                       },
//                       child: Text(
//                         "Edit Phone Number ?",
//                         style: TextStyle(color: Colors.black),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }