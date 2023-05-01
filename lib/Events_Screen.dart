import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Event_Screen extends StatefulWidget {
  const Event_Screen({Key? key}) : super(key: key);

  @override
  State<Event_Screen> createState() => _Event_ScreenState();
}

class _Event_ScreenState extends State<Event_Screen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formattedDate(timestamp){
    var dateFromTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection('Events').orderBy('DateTime',descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                        image: AssetImage("assets/images/nopost3.webp"),
                      ),
                      Text('No Events Posted!!')
                    ],
                  ),
                ),
              );
            }
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<
                      String,
                      dynamic>;
                  return Container(
                    // decoration: BoxDecoration(
                    //      //color: Colors.deepPurple[400],
                    //     borderRadius: BorderRadius.circular(10),
                    //     shape: BoxShape.rectangle
                    // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: Text(data["Name"],
                              style: GoogleFonts.poppins(
                                  color: Colors.deepPurple[500],
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.013,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data['Title'], style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500
                            ),),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,bottom: 10),
                            child: Text(data['Description'],
                              style: TextStyle(
                                fontSize: 13,
                                // fontWeight: FontWeight.w400
                            ),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0, left: 50),
                                child: Text(formattedDate(data['DateTime']),style: TextStyle(fontSize: 8 , color:Colors.grey,),),
                              )
                            ],
                          ),

                          Divider()

                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Center(child: Text("Tap for details...",
                          //     style: TextStyle(fontSize: 10,
                          //         fontWeight: FontWeight.w300),)),
                          // ),

                        ],
                      )
                  );
                }).toList(),

              );







          }),
    );
  }
}
