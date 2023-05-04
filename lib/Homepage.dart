import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_tutor_app/Phone_verification/Register_phoneNumber/phone.dart';
import 'package:online_tutor_app/Upload_Event_teacher/upload_event_screen.dart';
import 'package:online_tutor_app/profile_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'Uploading post using initState/Upload_Std_post2.dart';
import 'Uploading post using initState/Upload_teacher_post2.dart';
import 'HomeScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  int iconindex = 0;
  final screens = [
    HomeScreen(),
    ProfileScreen2(),
  ];
  bool pressedhome = true;
  bool pressedprofile = false;

  String? Occupation;
  String? phonenumber;

  void initState() {
    getDetailOccupation();
    super.initState();
  }

  Future getDetailOccupation() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) => {
              setState(() {
                Occupation = value['Occupation'];
                phonenumber = value['Phone Number'];
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[iconindex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple[400],
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: pressedhome
                  ? Icon(
                      Icons.home,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.home,
                      color: Colors.grey,
                    ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                setState(() {
                  pressedhome = true;
                  pressedprofile = false;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen2(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var currentNumberOfPosts;
          var isPremium;

          await db.collection('Users').doc(user?.uid).get().then((value) => {
                currentNumberOfPosts = value['numberOfPosts'],
                isPremium = value['isPremium'],
              });

          if (Occupation == 'Teacher') {
            if (phonenumber == "") {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Add Phone Number? '),
                        content: Text(
                            'To Upload Post you need to first verify your mobile number'),
                        actions: [
                          // ignore: deprecated_member_use
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyPhone()));
                              },
                              child: Text('Add')),
                          // SizedBox(width: 70,),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Quit')),
                        ],
                      ));
            } else {
              if (!isPremium && !(currentNumberOfPosts < 100)) {
                // yaha pe wo buy prem ya quit rkhana
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Buy Premium? '),
                          content: Text(
                              'You have exceeded the limit!\nDo you want to buy the Premium?'),
                          actions: [
                            // ignore: deprecated_member_use
                            TextButton(onPressed: () {}, child: Text('Buy?')),
                            // SizedBox(width: 70,),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Quit')),
                          ],
                        ));
              } else {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.blue.shade50,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * .16,
                        child: Wrap(children: [
                          ListTile(
                            leading: Icon(Icons.post_add),
                            title: Text('Post'),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Upload_teacher_postscreen2(),
                                  ));
                              // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: Upload_teacher_postscreen2()));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.event),
                            title: Text('Event'),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Upload_Event_Screen()));
                            },
                          ),
                        ]),
                      );
                    });
              }
            }
          }

          // if user is student then this else will work
          else {
            if (phonenumber == "") {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Add Phone Number? '),
                        content: Text(
                            'To Upload Post you need to first verify your mobile number'),
                        actions: [
                          // ignore: deprecated_member_use
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyPhone()));
                              },
                              child: Text('Add')),
                          // SizedBox(width: 70,),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Quit')),
                        ],
                      ));
            } else {
              if (!isPremium && !(currentNumberOfPosts < 100)) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Buy Premium? '),
                          content: Text(
                              'You have exceeded the limit!\nDo you want to buy the Premium?'),
                          actions: [
                            // ignore: deprecated_member_use
                            TextButton(onPressed: () {}, child: Text('Buy?')),
                            // SizedBox(width: 70,),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Quit')),
                          ],
                        ));
              } else {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: Upload_Student_postscreen2()));
              }
            }
          }
        },
        child: Text(
          '+',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.deepPurple[400],
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
