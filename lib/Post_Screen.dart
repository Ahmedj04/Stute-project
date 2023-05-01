import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:online_tutor_app/Postdetails_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Post_Screen extends StatefulWidget {
  const Post_Screen({Key? key}) : super(key: key);

  @override
  _Post_ScreenState createState() => _Post_ScreenState();
}

class _Post_ScreenState extends State<Post_Screen> {

 User? user=FirebaseAuth.instance.currentUser;
 FirebaseFirestore db = FirebaseFirestore.instance;

 var isFetched =false;
 late var users;

 // Location _location = Location() ;

 var lat;
 var long;
 // void CurrentLoc() async{
 //   _location.getLocation().then((value) => {
 //     lat=value.latitude,
 //     long=value.longitude,
 //     print("$lat"),
 //     print("$long"),
 //   });
 // }

 void initState() {

   super.initState();
   // PostDetail();
 }

// String getName(var data){
//   var Name;
//
//    var user = db.collection("Users").doc(data["Parent UID"]).get().then((value) => {
//      if(data["Parent UID"] == value["UID"]){
//        //print("MAIN ANDHAR WALA NAAM HU ${value["Name"]}")
//        Name = value["Name"],
//        print(Name)
//    }
//    });
//   isFetched= true;
//    return Name;
// }

 // Future<void> PostDetail() async{
 //   late var data2;
 //
 //   dynamic posti = await db.collection("Posts").get().then((QuerySnapshot querySnapshot) {
 //     querySnapshot.docs.forEach((doc) {
 //       var user= db.collection("Users").doc(doc["Parent UID"]).get().then((value) => {
 //         // print(value['Name'])
 //       });
 //
 //    data2 = user;
 //    isFetched= true;
 //     });
 //   });
 //   return data2;
 // }
 //


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection('Posts').orderBy('DateTime',descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.data!.docs.isEmpty) {
              // return Center(child: Text(' No Posts'));
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        // color: Colors.red,
                          height:300,
                          // image: AssetImage("assets/images/nopost1.jpg"),
                        image: NetworkImage('https://img.freepik.com/free-vector/business-team-looking-new-people-allegory-searching-ideas-staff-woman-with-magnifier-man-with-spyglass-flat-illustration_74855-18236.jpg?w=900&t=st=1667754109~exp=1667754709~hmac=e761f6d99a257a77d63be726224a6890d175d9a6161a68480248b16dae365184'),
                        ),
                      Text('No Posts!')
                    ],
                  ),
                ),
              );

            }
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  //CODE TEMP-------------------
                  //  data.forEach((key, value) {
                  //
                  //  });
                  // ------------------------------
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: PostDetailsScreen(id: (data['id']) ,)));
                    },
                    child: Container(
                      // decoration: BoxDecoration(
                      //      //color: Colors.deepPurple[400],
                      //     borderRadius: BorderRadius.circular(10),
                      //     shape: BoxShape.rectangle
                      // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(top:8.0,left: 8),
                              //NAME:------------------------------------------------------------------
                              // child: Text(data["Name"],style: GoogleFonts.poppins(color: Colors.deepPurple[500],
                              //     fontSize: MediaQuery.of(context).size.height*0.015 ,
                              //     fontWeight: FontWeight.w500),
                              // ),
                              //,
                              // child: isFetched?Text(nameOfCurrentDoc,style: GoogleFonts.poppins(color: Colors.deepPurple[500],
                              //     fontSize: MediaQuery.of(context).size.height*0.015 ,
                              //     fontWeight: FontWeight.w500),
                              // ):Text("RANDOM"),


                            // ),

                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data['Title'].toString().toUpperCase(),style: TextStyle(
                                      // color:Colors.grey,
                                      color:Colors.deepPurple[400],
                                      fontFamily: 'times new roman',
                                      fontSize: 14 ,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if(data['Price']!="")...[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Price\n"+data['Price'],style: TextStyle(
                                        // color: Colors.deepPurple[500],
                                        color: Colors.grey.shade600,
                                        fontSize: 13 ,
                                        fontWeight: FontWeight.w400),),
                                  ),
                                ],
                                if(data['Experience']!="")...[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Experience\n"+data['Experience'],style: TextStyle(
                                        // color:Colors.deepPurple[500],
                                        color: Colors.grey.shade600,
                                        fontSize: 13 , fontWeight: FontWeight.w400),),
                                  ),
                                ],
                              ],
                            ),
                            Row(
                              children: [
                                if(data['Teaching Mode']!="")...[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Teaching Mode\n"+data['Teaching Mode'],
                                      style: TextStyle(
                                          // color: Colors.deepPurple[500],
                                          color: Colors.grey.shade600,
                                          fontSize: 13 , fontWeight: FontWeight.w400),),
                                  ),
                                ],
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Description'],style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13 , fontWeight: FontWeight.w400),
                                maxLines: 2,
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("Tap for details",style: TextStyle(
                                      // color:Colors.grey,
                                      color:Colors.deepPurple[400],
                                      fontFamily: 'times new roman',
                                      fontSize: 8 ,
                                      fontWeight: FontWeight.bold
                                  ),)),
                                ),
                                // Text(data['DateTime'].toString(),style: TextStyle(fontSize: 10),)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0, left: 65),
                                  child: Text(formattedDate(data['DateTime']),style: TextStyle(fontSize: 8 , color:Colors.grey,),),
                                )
                              ],
                            ),

                            Divider(),



                          ],
                        )
                    ),
                  );

                }).toList(),

              );



          }),
    );
  }
  String formattedDate(timestamp){
   var dateFromTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }
}
