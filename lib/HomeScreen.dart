import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_tutor_app/Events_Screen.dart';
import 'package:online_tutor_app/Post_Screen.dart';
import 'package:online_tutor_app/Search_screen/searchscreen.dart';
import 'package:online_tutor_app/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseServices services = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  String? Occupation;

  void initState() {
    print('fetching details');
    getDetails();
    super.initState();
  }

  Future<void> getDetails() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) => {
              setState(() {
                Occupation = value['Occupation'];
                print("$Occupation");
              })
            });
  }

  // LinearGradient grad=LinearGradient(
  //   colors: [Colors.white,Colors.blue.shade200],
  //   begin: Alignment.bottomRight,
  //   end: Alignment.bottomLeft,
  // );

  final EventPosted = SnackBar(
    content: Text('You are using STUTE App'),
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      onPressed: () {},
      label: 'close',
      textColor: Colors.red,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 80,
        backgroundColor: Colors.deepPurple[400],
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height * .010),
              ),
              child: Text(
                "STUTE ",
                style: TextStyle(
                  fontFamily: 'times new roman',
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.height * .004)),
              child: Text(
                "We strive to help!",
                style: TextStyle(
                  fontFamily: 'times new roman',
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search_Screen());
              },
              icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Logout? '),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    // ignore: deprecated_member_use
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        services.logout(context);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.deepPurple[400]),
                  child: TabBar(
                    indicatorColor: Colors.white,
                    indicatorWeight: 1,
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'times new roman',
                    ),
                    unselectedLabelColor: Colors.grey.shade500,
                    tabs: [
                      Tab(
                        text: "Posts".toUpperCase(),
                      ),
                      Tab(text: "Events".toUpperCase()),
                      // Tab(text:"Nearby"),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height *
                      .765, //height of TabBarView
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  child:
                      TabBarView(physics: BouncingScrollPhysics(), children: [
                    Post_Screen(),
                    Event_Screen(),
                    // NearbyLocation(),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
