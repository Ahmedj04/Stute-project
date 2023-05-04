import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'Postdetails_screen.dart';
import 'firebase_services.dart';

class My_Post_Screen extends StatefulWidget {
  const My_Post_Screen({Key? key}) : super(key: key);

  @override
  State<My_Post_Screen> createState() => _My_Post_ScreenState();
}

class _My_Post_ScreenState extends State<My_Post_Screen> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseServices services = FirebaseServices();

  String formattedDate(timestamp) {
    var dateFromTimestamp =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Posts')
              .orderBy('DateTime', descending: true)
              .where("Parent UID", isEqualTo: user!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // return Text("Loading...");
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 300,
                        image: AssetImage("assets/images/nopost2.jpg"),
                      ),
                      Text('You have not Posted anything!!')
                    ],
                  ),
                ),
              );
            }
            return ListView(
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostDetailsScreen(id: data['id'])));
                  },
                  child: Card(
                    color: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0, left: 8),
                                child: Text(
                                  data["Name"],
                                  style: GoogleFonts.poppins(
                                      color: Colors.deepPurple[500],
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.blue.shade50,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .1,
                                            child: Wrap(children: [
                                              ListTile(
                                                leading: Icon(Icons.delete),
                                                title: Text('Delete'),
                                                onTap: () {
                                                  services
                                                      .deletepost(data['id']);
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                              ),
                                            ]),
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    size: 14,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text(
                              data['Title'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (data['Price'] != "") ...[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Price\n" + data['Price'],
                                    style: TextStyle(
                                        color: Colors.deepPurple[500],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                              if (data['Experience'] != "") ...[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Experience\n" + data['Experience'],
                                    style: TextStyle(
                                        color: Colors.deepPurple[500],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Row(
                            children: [
                              if (data['Teaching Mode'] != "") ...[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Teaching Mode\n" + data['Teaching Mode'],
                                    style: TextStyle(
                                        color: Colors.deepPurple[500],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data['Description'],
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  "Tap for details...",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300),
                                )),
                              ),
                              // Text(data['DateTime'].toString(),style: TextStyle(fontSize: 10),)
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, left: 50),
                                child: Text(
                                  formattedDate(data['DateTime']),
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
