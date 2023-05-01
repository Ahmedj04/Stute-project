import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_tutor_app/edit_info.dart';

import '../firebase_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FirebaseServices services=FirebaseServices();
  User? user=FirebaseAuth.instance.currentUser;
  final emailcontroller=TextEditingController();
  final namecontroller=TextEditingController();
  final addresscontroller=TextEditingController();
  final phonenumbercontroller=TextEditingController();
  final occupationcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile',
          style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontFamily: 'times new roman',
              fontSize: 20,
              fontWeight: FontWeight.bold,
          ),),
        elevation: 1,
        backgroundColor: Colors.white,
      ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          StreamBuilder(
            stream:FirebaseFirestore.instance.collection('Users').doc(user!.uid).snapshots(),
            builder: (BuildContext context , AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: const CircularProgressIndicator());
              }
              return Container(
                height: MediaQuery.of(context).size.height*.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/images/profilepic.jpg'),
                        ),
                      ],
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('\n'+snapshot.data['Name'],style: TextStyle(fontSize: 17 ,color: Colors.deepPurple[400]),)
                     ],
                   ),
                   SizedBox(height: 5,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(snapshot.data['Occupation'],style: TextStyle(fontSize: 11 ,color: Colors.deepPurple[400]),),
                     ],
                   ),

                ]

                )
              );
            }
          ),
          Container(
            height: 550,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Users').doc(user!.uid).snapshots(),
                builder: (BuildContext context , AsyncSnapshot snapshot){
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: const CircularProgressIndicator());
                  }
                  emailcontroller.text=snapshot.data['Email'];
                  namecontroller.text=snapshot.data['Name'];
                  addresscontroller.text=snapshot.data['Address'];
                  phonenumbercontroller.text=snapshot.data['Phone Number'];
                  occupationcontroller.text=snapshot.data['Occupation'];
                  return  Form(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                                children:[

                                  InkWell(
                                    // onTap: (){
                                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Name_edit_page()));
                                    // },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*.065,
                                      child: TextFormField(
                                        enabled: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'please fill Name field';
                                          }
                                          else if(value.length<2){
                                            return "Username should atleast be of 2 characters";
                                          }
                                          setState(() {
                                            namecontroller.text=value;
                                          });
                                          return null;
                                        },
                                        controller: namecontroller,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(fontSize: 13.5),
                                        decoration: const InputDecoration(
                                          label: Text('Name',style:TextStyle(color:Colors.grey)),
                                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),

                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20,),


                                  InkWell(
                                    // onTap: (){
                                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>web_edit_page()));
                                    // },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*.065,
                                      child: TextFormField(
                                        enabled: false,
                                        controller: addresscontroller,
                                        // keyboardType: TextInputType.url,
                                        style: const TextStyle(fontSize: 13.5),
                                        decoration: const InputDecoration(
                                          label: const Text('Address'),
                                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),

                                  InkWell(
                                    // onTap: (){
                                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Bio_edit_page()));
                                    // },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*.065,
                                      child: TextFormField(
                                        enabled: false,
                                        controller: occupationcontroller,
                                        // keyboardType: TextInputType.multiline,
                                        // maxLines: null,
                                        style: const TextStyle(fontSize: 13.5),
                                        decoration: const InputDecoration(
                                          label: const Text('Occupation'),
                                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20,),

                                  InkWell(
                                    // onTap: (){
                                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Bio_edit_page()));
                                    // },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*.065,
                                      child: TextFormField(
                                        enabled: false,
                                        controller:  phonenumbercontroller,
                                        // keyboardType: TextInputType.multiline,
                                        // maxLines: null,
                                        style: const TextStyle(fontSize: 13.5),
                                        decoration: const InputDecoration(
                                          label: const Text('Contact No.'),
                                          hintStyle: TextStyle(color:Colors.grey , fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20,),

                                  Container(
                                    height: MediaQuery.of(context).size.height*.065,
                                    child: TextFormField(
                                      enabled: false,
                                      cursorHeight: 20,
                                      controller: emailcontroller ,
                                      style: const TextStyle(fontSize: 13.5),

                                      keyboardType: TextInputType.emailAddress,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        label: Text('Email'),
                                        hintStyle:TextStyle(color:Colors.grey , fontSize: 13),
                                      ),

                                    ),
                                  ),

                                  // const SizedBox(height: 20,),

                                  // Container(
                                  //   height: MediaQuery.of(context).size.height*.065,
                                  //   child: TextField(
                                  //     controller: passwordcontroller,
                                  //     // keyboardType: TextInputType.visiblePassword,
                                  //     onChanged: (value){
                                  //       setState(() {
                                  //         this.password=value;
                                  //       });
                                  //     },
                                  //     onSubmitted: (value){
                                  //       setState(() {
                                  //         this.password=value;
                                  //       });
                                  //     },
                                  //     style: const TextStyle(fontSize: 13.5),
                                  //     decoration: InputDecoration(
                                  //         label: const Text('Password'),
                                  //         // labelStyle: TextStyle(color: Colors.grey , fontSize: 13),
                                  //         // hintText: 'Password',
                                  //         hintStyle: const TextStyle(color:Colors.grey , fontSize: 13),
                                  //         // border: OutlineInputBorder(),
                                  //         suffixIcon: IconButton(
                                  //           onPressed: (){
                                  //             setState(() {
                                  //               passwordhide=!passwordhide;
                                  //             });
                                  //           },
                                  //           icon:passwordhide ? const Icon(Icons.visibility_off):const Icon(Icons.visibility) ,
                                  //           iconSize: 18,
                                  //         )
                                  //
                                  //     ),
                                  //     obscureText: passwordhide,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 30,),

                                  ElevatedButton(onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit_info_screen()));
                                    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child:SignUpScreen()));
                                  },
                                    style: ButtonStyle(
                                      // overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                                      // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                      // side: MaterialStateProperty.all(
                                      //   const BorderSide(
                                      //     color: Colors.blue,
                                      //     width: 0,
                                      //   ),
                                      // ),
                                      fixedSize: MaterialStateProperty.all(const Size(300, 60)),
                                    ),
                                    child: Text('Edit Details',style: TextStyle(color: Colors.white , fontSize: 13),),
                                  ),

                                  const SizedBox(height: 30,),

                                  ElevatedButton(onPressed: (){
                                    services.logout(context);
                                  },
                                    style: ButtonStyle(
                                      // overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                                      // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                                      backgroundColor: MaterialStateProperty.all(Colors.red),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),

                                      fixedSize: MaterialStateProperty.all(const Size(300, 60)),
                                    ),
                                    child: Text('LOGOUT',style: TextStyle(color: Colors.white , fontSize: 13),),
                                  ),

                                ]
                            ),
                          ),

                        ],
                      )
                  );
                }),
          ),
        ],
      ),

    );
  }
}
