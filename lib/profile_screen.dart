
import 'dart:io';
// import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:online_tutor_app/Info_screen.dart';
import 'package:online_tutor_app/My_Events_Screen.dart';
import 'package:online_tutor_app/My_Posts_Screen.dart';
import 'firebase_services.dart';


class ProfileScreen2 extends StatefulWidget {
  const ProfileScreen2({Key? key}) : super(key: key);

  @override
  State<ProfileScreen2> createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2>  {

  FirebaseServices services=FirebaseServices();
  User? user=FirebaseAuth.instance.currentUser;

  File? img;
  String? Occupation;
  String? imageurl;
  bool isloading = false;

  String? useruid;


  void initState() {
    getDetail();
    super.initState();
  }


  Future getDetail() async{
    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).get().then((value) => {
      setState((){
        useruid=value['UID'];
        imageurl=value['imageurl'];
        Occupation=value['Occupation'];

      })
    });
  }

  void pick_image(ImageSource src) async{
    final pickedFile=await ImagePicker().pickImage(source: src,imageQuality: 20);
    if(pickedFile != null)
    {
      setState(() {
        this.img = File(pickedFile.path);
      });
    }

  }
  Future uploadFile(filePath) async{
    File file = File(filePath);
    FirebaseStorage _storage = FirebaseStorage.instance;
    try{
      await _storage.ref('userProfile/${useruid}').putFile(file);

    }on FirebaseException catch (e){
      print(e.code);
    }
    //  after uploading we need downloaded url
    String downloadurl = await _storage.ref('userProfile/${useruid}').getDownloadURL();
    return downloadurl;
  }
  void ShowOptions2(){
    showModalBottomSheet(
        context: context,
        builder:(BuildContext context){
          return Container(
            // height: 200,
            height: MediaQuery.of(context).size.height *.25,
            child: Wrap(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(left:20.0 , top: 20 , bottom: 20),
                    child: Text('Profile Photo' ,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                  ),
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                    onTap: (){
                      pick_image(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Gallery'),
                    onTap: (){
                      pick_image(ImageSource.gallery);
                    },
                  ),
                ]
            ),
          );
        }
    );
  }

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
            // fontWeight: FontWeight.bold,
          ),),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () async{
            uploadFile(img!.path).then((Url) => {
              print(Url),
              if(Url!=null)
                {
                  FirebaseFirestore.instance.collection("Users").doc(user!.uid).update(
                      {
                        'imageurl':Url,
                      }).whenComplete(()  => {
                    setState(() {
                      isloading = false;
                    }),
                    EasyLoading.showSuccess('Profile Pic Updated'),
                    print("data stored successfully")

                  })
                }
              else
                {
                  print("please upload your profile pic")
                }
            });
            setState(() {
              isloading = true;
            });
          },
            // icon: Icon(Icons.check , color:Colors.blue)
            icon: isloading ? SizedBox( height: 15,width: 15, child: CircularProgressIndicator(color:Colors.blue, strokeWidth: 2.5,)):Icon(Icons.check , color:Colors.blue),
          ),

        ],
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
                              // CircleAvatar(
                              //   radius: 60,
                              //   backgroundImage: AssetImage('assets/images/profilepic.jpg'),
                              // ),

                              InkWell(
                                onTap: ()async{
                                  ShowOptions2();
                                },
                                child: ClipOval(
                                  child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      // child: img!=null ? Image.file(img!,fit: BoxFit.fitHeight,): imageurl=="" ? Image(image: AssetImage('assets/images/profilepic.jpg')):Image.network(imageurl.toString())
                                      child: img!=null ? Image.file(img!,fit: BoxFit.fitHeight,): imageurl=="" ? Text("Select image to upload",style: TextStyle(fontSize: 8,color: Colors.black),):Image.network(imageurl.toString())

                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     InkWell(
                          //       onTap:()async{
                          //         if(img==null){
                          //           EasyLoading.showSuccess('Updated' );
                          //
                          //         }
                          //          uploadFile(img!.path).then((Url) => {
                          //           if(Url!=null)
                          //             {
                          //               EasyLoading.show(status: 'Uploading Image'),
                          //
                          //               FirebaseFirestore.instance.collection("Users").doc(user!.uid).update(
                          //                   {
                          //                     'imageurl':Url,
                          //                   }).then((value) => {
                          //                 EasyLoading.showSuccess('Profile pic updated'),
                          //                 print("data stored successfully")
                          //               })
                          //             }
                          //           else
                          //             {
                          //               print("please upload your profile pic")
                          //             }
                          //         });
                          //
                          //       },
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(top: 8.0),
                          //           child: Text('Upload',style: TextStyle(color: Colors.blue),),
                          //         ))
                          //   ],
                          // ),
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
          Occupation=='Teacher'?
          DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: TabBar(
                    indicatorColor: Colors.deepPurple[400],
                    indicatorWeight: 1,
                    labelColor: Colors.deepPurple[400],
                    labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'times new roman',),
                    unselectedLabelColor: Colors.grey.shade500,
                    tabs: [
                      Tab(text: "Info".toUpperCase(),),
                      Tab(text:"My Posts".toUpperCase()),
                      Tab(text: "My Events".toUpperCase(),),

                    ],
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height*.540, //height of TabBarView
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                    ),
                    child: TabBarView(
                        physics:BouncingScrollPhysics(),
                        children: [
                          Info_Screen(),
                          My_Post_Screen(),
                          My_Event_Screen(),
                        ]
                    )
                ),
              ],
            ),
          ): DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: TabBar(
                    indicatorColor: Colors.deepPurple[500],
                    indicatorWeight: 1,
                    labelColor: Colors.deepPurple[500],
                    labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'times new roman',),
                    unselectedLabelColor: Colors.grey.shade500,
                    tabs: [
                      Tab(text: "Info",),
                      Tab(text:"My Posts"),

                    ],
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height*.540, //height of TabBarView
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                    ),
                    child: TabBarView(
                        physics:BouncingScrollPhysics(),
                        children: [
                          Info_Screen(),
                          My_Post_Screen(),
                        ]
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}