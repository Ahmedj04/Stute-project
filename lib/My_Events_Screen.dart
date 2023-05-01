import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'firebase_services.dart';

class My_Event_Screen extends StatefulWidget {
  const My_Event_Screen({Key? key}) : super(key: key);

  @override
  State<My_Event_Screen> createState() => _My_Event_ScreenState();
}

class _My_Event_ScreenState extends State<My_Event_Screen>  {

  User? user=FirebaseAuth.instance.currentUser;
  FirebaseServices services=FirebaseServices();

  String formattedDate(timestamp){
    var dateFromTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }

  @override

  Widget build(BuildContext context) {
    return Container(
      child:StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection('Events').where("Parent UID",isEqualTo: user!.uid ).orderBy("DateTime",descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // return Text("Loading...");
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.data!.docs.isEmpty) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        // color: Colors.red,
                        height: 300,
                        image: AssetImage("assets/images/nopost2.jpg"),
                      ),
                      Text('You have not Posted Any Event!!')
                    ],
                  ),
                ),
              );
            }
            return ListView(
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return InkWell(
                  // onTap: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsScreen(id: data['id'])));
                  // },
                  child: Card(
                    // color: const Color(0xffd5bee2),
                    //color: const Color(0xffbac7d3),//ye wala phele tha
                    color:Colors.blue.shade50,
                    // color: const Color(0xffc9c9c9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:0,left: 8),
                                  child: Text(data["Name"],style: GoogleFonts.poppins(color: Colors.deepPurple[500],
                                      fontSize: MediaQuery.of(context).size.height*0.015 ,
                                      fontWeight: FontWeight.w500),
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.blue.shade50,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height *.1,
                                          child: Wrap(
                                              children: [
                                                ListTile(
                                                  leading: Icon(Icons.delete),
                                                  title: Text('Delete'),
                                                  onTap: () {
                                                    services.deleteEvent(data['id']);
                                                    Navigator.of(context).pop(true);
                                                  },
                                                ),
                                              ]
                                          ),
                                        );
                                      }
                                  );
                                },
                                    icon: Icon(Icons.more_vert ,size: 14,))
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left:8.0,right: 8),
                              child: Text(data['Title'],style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w300
                              ),),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data['Description'],style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w300),),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0, left: 50,bottom: 10),
                                  child: Text(formattedDate(data['DateTime']),style: TextStyle(fontSize: 8 , color:Colors.grey,),),
                                )
                              ],
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Center(child: Text("Tap for details...",style: TextStyle(fontSize: 10 , fontWeight: FontWeight.w300),)),
                            // ),

                          ],
                        )
                    ),
                  ),
                );
              }).toList(),

            );

          }),

    );
  }
}
class Modelsheet {
  void ModalSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * .43,
            child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('View'),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Delete'),
                    onTap: () {

                    },
                  ),
                ]
            ),
          );
        }
    );
  }
}

