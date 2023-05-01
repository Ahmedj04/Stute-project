import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:online_tutor_app/Homepage.dart';
import 'package:online_tutor_app/Phone_verification/Register_phoneNumber/phone.dart';
import 'package:online_tutor_app/SignUpScreen.dart';
import 'package:online_tutor_app/firebase_services.dart';
import 'package:online_tutor_app/first_screen.dart';

import 'Phone_verification/login_with_phone/login_phone.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  String password='';
  bool passwordhide=true;
  bool enabled=false;

  FirebaseServices services=FirebaseServices();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple[400],
        // automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  FirstScreen()), (Route<dynamic> route) => false);
              },
            icon: Icon(Icons.arrow_back)
        ) ,
        // actions: [
        //   IconButton(onPressed: (){
        //
        //   },
        //       icon: Icon(Icons.arrow_back)
        //   )
        // ],
      ),
      body: Form(
        key: formkey,
        child: ListView(
            children:[
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      height: 160,
                      color: Colors.deepPurple[400],
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Text("Get To \nYour \nDashboard",style: TextStyle(fontSize: 32,fontFamily:  'times new roman' , fontWeight: FontWeight.w500,color: Colors.white),),
                                ],
                              ),
                            ),
                            // SizedBox(height: 25,),
                            // Row(
                            //   children: [
                            //     Text("Learn and interact with tutor online worldwide!",style: TextStyle(fontSize: 13 , color: Colors.white70),),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),

                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Container(
                          // height: MediaQuery.of(context).size.height*.085,
                          child: TextFormField(
                            focusNode: focus1,
                            controller: emailcontroller ,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please fill email address field';
                              }
                              bool check=EmailValidator.validate(emailcontroller.text);
                              if(!check)
                              {
                                return 'please enter valid email';
                              }

                              setState(() {
                                emailcontroller.text=value;
                              });
                              return null;
                            },
                            style: TextStyle(fontSize: 15),
                            keyboardType: TextInputType.emailAddress,
                            // keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              // label: Text('Phone number, email or username'),
                              // labelStyle: TextStyle(color: Colors.grey , fontSize: 13),
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.mail,
                                // color: focus1.hasFocus ? Color(0xa64700c6) : Colors.grey,
                                color: Colors.grey,
                              ),
                              hintStyle:TextStyle(color:Colors.grey , fontSize: 13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xa64700c6), width: 1),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.red,width: 1.5 ),
                                  borderRadius: BorderRadius.circular(50)
                              ),

                              // suffixIcon: emailcontroller.text.isEmpty ? Container(width: 0,) :
                              // IconButton(onPressed: ()=>emailcontroller.clear(),
                              //   icon: Icon(Icons.close) ,
                              //   iconSize: 13,
                              // ),

                            ),

                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          // height: MediaQuery.of(context).size.height*.085,
                          child: TextFormField(
                            obscureText: passwordhide,
                            focusNode: focus2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please fill password field';
                              }
                              else if(value.length<6){
                                return "password is too short";
                              }
                              setState(() {
                                passwordcontroller.text=value;
                              });
                              return null;
                            },
                            controller: passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              // label: Text('Password'),
                              // labelStyle: TextStyle(color: Colors.grey , fontSize: 13),
                              hintText: 'Password',
                              hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                              prefixIcon: Icon(
                                Icons.security,
                                // color: focus2.hasFocus ? Color(0xa64700c6) : Colors.grey,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xa64700c6), width: 1),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.red,width: 1.5 ),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    passwordhide=!passwordhide;

                                  });
                                },
                                icon:passwordhide ? Icon(Icons.visibility_off,color: focus2.hasFocus?Color(0xa64700c6):Colors.grey,):Icon(Icons.visibility,color:  focus2.hasFocus?Color(0xa64700c6):Colors.grey,) ,
                                iconSize: 18,
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // SizedBox(height: 20,),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     ElevatedButton(onPressed: (){
                  //       setState(() {
                  //         enabled = true;
                  //         S_selected = true;
                  //         T_selected = false;
                  //       });
                  //       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit_by_streambuilder()));
                  //     },
                  //       style: ButtonStyle(
                  //         overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                  //         // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                  //         backgroundColor: S_selected?MaterialStateProperty.all(Colors.deepPurple[400]): MaterialStateProperty.all(Colors.white),
                  //         elevation: MaterialStateProperty.all(0),
                  //         shape: MaterialStateProperty.all(
                  //           RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(50),
                  //           ),
                  //         ),
                  //         side: MaterialStateProperty.all(
                  //           BorderSide(
                  //             color: Color(0xa64700c6),
                  //             width: 0,
                  //           ),
                  //         ),
                  //         fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                  //       ),
                  //       child: Text('Student',style: TextStyle(color:S_selected?Colors.white:Colors.deepPurple[400] , fontSize: 16),),
                  //     ),
                  //
                  //
                  //     ElevatedButton(
                  //       onPressed: (){
                  //         setState(() {
                  //           enabled = true;
                  //           T_selected = true;
                  //           S_selected = false;
                  //         });
                  //         // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit_by_streambuilder()));
                  //       },
                  //       style: ButtonStyle(
                  //         overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                  //         // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                  //         backgroundColor:T_selected?MaterialStateProperty.all(Colors.deepPurple[400]): MaterialStateProperty.all(Colors.white),
                  //         elevation: MaterialStateProperty.all(0),
                  //         shape: MaterialStateProperty.all(
                  //           RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(50),
                  //           ),
                  //         ),
                  //         side: MaterialStateProperty.all(
                  //           BorderSide(
                  //             color: Color(0xa64700c6),
                  //             width: 0,
                  //           ),
                  //         ),
                  //         fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                  //       ),
                  //       child: Text('Teacher',style: TextStyle(color: T_selected?Colors.white:Colors.deepPurple[400] , fontSize: 16),),
                  //     ),
                  //   ],
                  // ),



                  ElevatedButton(onPressed:()async{
                    if(formkey.currentState!.validate()){
                      try{
                          EasyLoading.show(status: 'loading');
                          await services.dynamiclogin(emailcontroller.text, passwordcontroller.text).then((value) => {
                            services.getUserId(value.user!.uid).then((value) => {
                              if(value.exists){
                                if(value['Phone Number']==""){  //checking if user has provided the phone number if not then it will navigate to the myphone screen
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyPhone(),),),
                                  EasyLoading.showSuccess('Please verify your mobile number first!')
                                }// if user has already provided the phone details then it will navigate to the homepage
                                else{
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(),),),
                                  // EasyLoading.showSuccess('Welcome Back '+value['Name']+'!!')
                                  EasyLoading.showSuccess('Welcome Back!')
                                }
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(),),),
                                // // EasyLoading.showSuccess('Welcome Back '+value['Name']+'!!')
                                // EasyLoading.showSuccess('Welcome Back!')
                              }
                              else{
                                EasyLoading.showError('Account not found in Database')
                              }
                            })
                          });
                        }catch(e){
                          EasyLoading.showError(e.toString());
                        }
                    }
                  },
                    style: ButtonStyle(
                      // overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                      // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                      backgroundColor:MaterialStateProperty.all(Colors.deepPurple[400]),
                      elevation: MaterialStateProperty.all(1),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: enabled?Color(0xa64700c6):Colors.grey.shade200,
                          width: 0,
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all(const Size(300, 60)),
                    ),
                    child: Text('Login',style: TextStyle(color: Colors.white , fontSize: 16),),
                  ),

                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:55.0),
                        child: Text('Forgot your login details?',
                          style: TextStyle(fontSize: 12),

                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_with_MyPhone(),),);
                      },
                        child: Text('Login with Phone number.',
                          style: TextStyle(fontSize: 12 , color: Colors.deepPurple[400]),
                        ),),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // width: 170,
                            width: 150,
                            child: Divider(height: 1,thickness: 1,)),
                        Text('OR', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                        Container(
                          // width: 170,
                            width: 160,
                            child: Divider(height: 1,thickness: 1,)),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(fontSize: 12),),
                      TextButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen(),
                              ),
                            );
                      },
                          child: Text('SignUp.',style: TextStyle(fontSize: 12,color:Colors.deepPurple[400]),))

                    ],
                  ),

                  // SizedBox(height: 20,),

                  // ElevatedButton(onPressed: (){
                  //   // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit_by_streambuilder()));
                  // },
                  //   style: ButtonStyle(
                  //     // overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                  //     // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                  //     backgroundColor: MaterialStateProperty.all(Colors.deepPurple[400]),
                  //     elevation: MaterialStateProperty.all(0),
                  //     shape: MaterialStateProperty.all(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(50),
                  //       ),
                  //     ),
                  //     // side: MaterialStateProperty.all(
                  //     //   const BorderSide(
                  //     //     color: Colors.blue,
                  //     //     width: 0,
                  //     //   ),
                  //     // ),
                  //     fixedSize: MaterialStateProperty.all(const Size(300, 60)),
                  //   ),
                  //   child: Text('Registration',style: TextStyle(color: Colors.white , fontSize: 16),),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top:20.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Container(
                  //           width: 150,
                  //           child: Divider(height: 1,thickness: 1,)),
                  //       Text('OR', style: TextStyle(fontWeight: FontWeight.bold),),
                  //       Container(
                  //           width: 160,
                  //           child: Divider(height: 1,thickness: 1,)),
                  //     ],
                  //   ),
                  // ),
                  //
                  // Padding(
                  //     padding: const EdgeInsets.only(top:15.0),
                  //     child: InkWell(
                  //         onTap:(){},
                  //         child: Text("Admin login?",style: TextStyle(fontSize: 13,color: Colors.deepPurple[400]),))
                  //
                  // ),

                ],
              ),
            ]
        ),
      ),
    );
  }
}
