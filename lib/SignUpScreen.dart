import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_tutor_app/Phone_verification/Register_phoneNumber/phone.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller1 = TextEditingController();
  final passwordcontroller2 = TextEditingController();
  final namecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();
  FocusNode focus5 = FocusNode();
  bool passwordhide1 = true;
  bool passwordhide2 = true;
  bool enabled = false;
  bool S_selected = false;
  bool T_selected = false;
  String? _chosenValue;

  String phnnumber = "";
  String url = "";

  String address = "";
  var latitude = "";
  var longitude = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple[400],
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .21,
                    color: Colors.deepPurple[400],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Fill In These \nDetails To Get \nRegistered",
                                style: TextStyle(
                                    fontFamily: 'times new roman',
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * .02,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: focus1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please fill Name field';
                          } else if (value.length < 5) {
                            return "Name should atleast be of 5 characters";
                          }
                          setState(() {
                            namecontroller.text = value;
                          });
                          return null;
                        },
                        controller: namecontroller,
                        keyboardType: TextInputType.name,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Name*',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 17.0, 20.0, 17.0),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xa64700c6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xa64700c6), width: 1),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextFormField(
                        focusNode: focus2,
                        controller: emailcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please fill email address field';
                          }
                          bool check =
                              EmailValidator.validate(emailcontroller.text);
                          if (!check) {
                            return 'please enter valid email';
                          }

                          setState(() {
                            emailcontroller.text = value;
                          });
                          return null;
                        },
                        style: TextStyle(fontSize: 15),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Email*',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 17.0, 20.0, 17.0),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Color(0xa64700c6),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xa64700c6), width: 1),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextFormField(
                        obscureText: passwordhide1,
                        focusNode: focus3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please fill password field';
                          } else if (value.length < 3) {
                            return "password is too short";
                          }
                          setState(() {
                            passwordcontroller1.text = value;
                          });
                          return null;
                        },
                        controller: passwordcontroller1,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Password*',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 17.0, 20.0, 17.0),
                          prefixIcon: Icon(
                            Icons.security,
                            color: Color(0xa64700c6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xa64700c6), width: 1),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(50)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordhide1 = !passwordhide1;
                              });
                            },
                            icon: passwordhide1
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: focus3.hasFocus
                                        ? Color(0xa64700c6)
                                        : Colors.grey,
                                  ),
                            iconSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextFormField(
                        obscureText: passwordhide2,
                        focusNode: focus4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please fill password field';
                          } else if (value.length < 3) {
                            return "password is too short";
                          }
                          setState(() {
                            passwordcontroller2.text = value;
                          });
                          return null;
                        },
                        controller: passwordcontroller2,
                        // keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Confirm Password*',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 17.0, 20.0, 17.0),
                          prefixIcon: Icon(
                            Icons.security,
                            color: Color(0xa64700c6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xa64700c6), width: 1),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(50)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordhide2 = !passwordhide2;
                              });
                            },
                            icon: passwordhide2
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: focus4.hasFocus
                                        ? Color(0xa64700c6)
                                        : Colors.grey,
                                  ),
                            iconSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Register as:',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          letterSpacing: .1),
                    ),
                    Container(
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _chosenValue,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.deepPurple[400],
                        items: <String>[
                          'Teacher',
                          'Student',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Please choose your occupation*",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _chosenValue = value;
                            if (_chosenValue == 'Teacher') {
                              enabled = true;
                              T_selected = true;
                              S_selected = false;
                            } else if (_chosenValue == 'Student') {
                              enabled = true;
                              T_selected = false;
                              S_selected = true;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: .5,
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: enabled
                      ? () async {
                          if (formkey.currentState!.validate()) {
                            EasyLoading.show(status: 'Creating account...');

                            if (passwordcontroller1.text ==
                                passwordcontroller2.text) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailcontroller.text,
                                        password: passwordcontroller1.text)
                                    .then((value) => {
                                          FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(value.user!.uid)
                                              .set({
                                            'UID': value.user!.uid,
                                            'Email': emailcontroller.text,
                                            'Name': namecontroller.text,
                                            'Password':
                                                passwordcontroller1.text,
                                            'Phone Number': phnnumber,
                                            'Occupation': _chosenValue,
                                            'DateTime': DateTime.now(),
                                            'isPremium': false,
                                            'numberOfPosts': 0,
                                            'imageurl': url
                                          }).whenComplete(() => {
                                                    print("$_chosenValue"),
                                                    EasyLoading.showSuccess(
                                                            'You Have registered Successfully.\nNow you need to first verify your mobile number')
                                                        .then((value) => {
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MyPhone(),
                                                                ),
                                                              ),
                                                              // Navigator.pushNamed(context, 'phone')
                                                            })
                                                  })
                                        });
                              } catch (e) {
                                // EasyLoading.showError(e.toString());
                                EasyLoading.showError("Something went wrong");
                              }
                            } else {
                              EasyLoading.showError('Password not Matching');
                            }
                          }
                        }
                      : null,
                  style: ButtonStyle(
                    // overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                    // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                    // backgroundColor: MaterialStateProperty.all(Colors.deepPurple[400]),
                    backgroundColor: enabled
                        ? MaterialStateProperty.all(Colors.deepPurple[400])
                        : MaterialStateProperty.all(Colors.grey.shade200),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color:
                            enabled ? Color(0xa64700c6) : Colors.grey.shade200,
                        width: 0,
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(const Size(300, 60)),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
