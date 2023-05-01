import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_tutor_app/firebase_services.dart';

class Upload_Student_Post_Screen extends StatefulWidget {
  const Upload_Student_Post_Screen({Key? key}) : super(key: key);

  @override
  _Upload_Student_Post_ScreenState createState() => _Upload_Student_Post_ScreenState();
}

class _Upload_Student_Post_ScreenState extends State<Upload_Student_Post_Screen> {

  final titlecontroller=TextEditingController();
  final descriptioncontroller=TextEditingController();
  final pricecontroller=TextEditingController();
  final locationcontroller=TextEditingController();
  final experiencecontroller=TextEditingController();
  final teachingmodecontroller=TextEditingController();
  User? user=FirebaseAuth.instance.currentUser;
  FirebaseServices services= FirebaseServices();
  final formkey=GlobalKey<FormState>();
  bool isloading=false;

  var latitude="";
  var longitude="";
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
          StreamBuilder<Object>(
              stream: FirebaseFirestore.instance.collection('Users').doc(user!.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // return Text("Loading...");
                  return Center(child: CircularProgressIndicator());
                }
                return IconButton(
                  onPressed: () async{
                  if (formkey.currentState!.validate()) {
                    await services.saveddata_students(
                        snapshot.data['Name'],
                        titlecontroller.text,
                        descriptioncontroller.text,
                        pricecontroller.text,
                        snapshot.data['Phone Number'],
                        locationcontroller.text,
                        snapshot.data['UID'],
                        experiencecontroller.text,
                        teachingmodecontroller.text,
                      latitude,
                      longitude,

                    ).whenComplete(() =>
                    {
                      Navigator.pop(context)
                    });

                    setState(() {
                      isloading = true;
                    });
                  }
                },
                      icon: isloading ? SizedBox( height: 15,width: 15, child: CircularProgressIndicator(color:Colors.blue, strokeWidth: 2.5,)):Icon(Icons.check , color:Colors.blue),
                );
              }
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
                        controller: locationcontroller,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        style: const TextStyle(fontSize: 13.5),
                        decoration: const InputDecoration(
                          label: Text('Address',style:TextStyle(color:Colors.grey)),
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
