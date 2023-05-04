import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_tutor_app/Postdetails_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class Post_Screen extends StatefulWidget {
  const Post_Screen({Key? key}) : super(key: key);

  @override
  _Post_ScreenState createState() => _Post_ScreenState();
}

class _Post_ScreenState extends State<Post_Screen> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;

  var isFetched = false;
  late var users;

  var lat;
  var long;

  String formattedDate(timestamp) {
    var dateFromTimestamp =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Posts')
              .orderBy('DateTime', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              // return Center(child: Text(' No Posts'));
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 300,
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/business-team-looking-new-people-allegory-searching-ideas-staff-woman-with-magnifier-man-with-spyglass-flat-illustration_74855-18236.jpg?w=900&t=st=1667754109~exp=1667754709~hmac=e761f6d99a257a77d63be726224a6890d175d9a6161a68480248b16dae365184'),
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
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: PostDetailsScreen(
                              id: (data['id']),
                            )));
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data['Title'].toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.deepPurple[400],
                                    fontFamily: 'times new roman',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
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
                                      color: Colors.grey.shade600,
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
                                      color: Colors.grey.shade600,
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
                                      color: Colors.grey.shade600,
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
                                color: Colors.grey.shade600,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            maxLines: 2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Tap for details",
                                  style: TextStyle(
                                      color: Colors.deepPurple[400],
                                      fontFamily: 'times new roman',
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 65),
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
                        Divider(),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
