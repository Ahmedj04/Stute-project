import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locally/locally.dart';
import 'package:online_tutor_app/Events_Screen.dart';
import 'package:online_tutor_app/GoogleMaps/nearbylocation.dart';
import 'package:online_tutor_app/Post_Screen.dart';
import 'package:online_tutor_app/Search_screen/searchscreen.dart';
import 'package:online_tutor_app/dummyscreens/HomeScreen.dart';
import 'package:online_tutor_app/firebase_services.dart';

class Homescreen3 extends StatefulWidget {
  const Homescreen3({Key? key}) : super(key: key);

  @override
  _Homescreen3State createState() => _Homescreen3State();
}

class _Homescreen3State extends State<Homescreen3> {

  FirebaseServices services=FirebaseServices();
  User? user=FirebaseAuth.instance.currentUser;
  String? Occupation;

  void initState() {
    print ('fetching details');
    getDetails();
    super.initState();
  }

  Future<void> getDetails() async{
    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).get().then((value) => {
      setState((){
        Occupation=value['Occupation'];
        print("$Occupation");
      })
    });
  }
  // LinearGradient grad=LinearGradient(
  //   colors: [Colors.white,Colors.blue.shade200],
  //   begin: Alignment.bottomRight,
  //   end: Alignment.bottomLeft,
  // );

  final EventPosted=SnackBar(
    content: Text('You are using STUTE App'),
    duration: Duration(seconds: 2),
    action: SnackBarAction(onPressed: (){},label: 'close',textColor: Colors.red,),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 80,
        backgroundColor: Colors.deepPurple[400],
        // backgroundColor: Color(0xffbac7d3),
        // backgroundColor: Colors.blue.shade50,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: grad
        //   ),
        // ),
        automaticallyImplyLeading: false,
        // title: Text("Get Connected to the World!",
        //   style: TextStyle(
        //   fontFamily: 'times new roman',
        //   // color:Colors.black,
        //   color:Colors.white,
        //     fontSize: 20,
        //     fontWeight: FontWeight.w400,),),
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: ()async{
                // ScaffoldMessenger.of(context).showSnackBar(EventPosted);
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NearbyLocation()));
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BakeryList()));
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NearbyLocation()));
              },
              child: Padding(
                padding: EdgeInsets.only(top:(MediaQuery.of(context).size.height*.010)),
                child: Text("STUTE ",style: TextStyle(
                  fontFamily: 'times new roman',
                  // color:Colors.black,
                  color:Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w400,),),
              ),
            ),
          SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: (MediaQuery.of(context).size.height*.004)),
              child: Text("We strive to help!",
                style: TextStyle(
                  fontFamily: 'times new roman',
                  // color:Colors.black,
                  color:Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,),),
            ),

          ],
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: Search_Screen());
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
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
                        child: Text('No')),
                    // SizedBox(width: 70,),
                    TextButton(
                        onPressed: () {
                          services.logout(context);
                        },
                        child: Text('Yes')),
                  ],
                ));
          }, icon:Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [

          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.deepPurple[400]
          //     // color: Color(0xffbac7d3)
          //     //   color: Colors.blue.shade50,
          //     // gradient:grad
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(left:15.0,right: 15,top: 20,bottom: 35),
          //     child: TextField(
          //       onTap: (){
          //         showSearch(context: context, delegate: Search_Screen());
          //       },
          //       readOnly: true,
          //       style: TextStyle(fontSize: 13.5),
          //       cursorHeight: 15,
          //       cursorWidth: 1.5,
          //       decoration: InputDecoration(
          //         contentPadding: EdgeInsets.only(top: 10,bottom: 10),
          //         filled: true,
          //         // fillColor: Colors.grey.shade50,
          //         // fillColor: Colors.deepPurple[400],
          //         // fillColor: Color(0xffbac7d3),
          //         // fillColor:  Colors.blue.shade50,
          //         fillColor:  Colors.white,
          //         hintText: 'Search...',
          //         hintStyle: TextStyle(color: Colors.grey),
          //         prefixIcon: Icon(
          //           Icons.search ,
          //           // color:Colors.black45 ,
          //           color:Colors.grey ,
          //           size: 23,),
          //         enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(5),
          //             borderSide:  BorderSide(
          //                 // color: Colors.black45,
          //                 color: Colors.white,
          //                 width: 0)
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(5),
          //             borderSide:  BorderSide(
          //                 color: Colors.white,
          //                 // color: Colors.black45,
          //                 width: 0)
          //         ),
          //       ),
          //
          //     ),
          //   ),
          // ),



          // ------------------------------------------------------------------------------



          // SizedBox(height: 30,),
          // SizedBox(height: 10,),
          // if(Occupation=="Student")...[
          //   DefaultTabController(
          //     length: 3,
          //     initialIndex: 0,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         Container(
          //           child: TabBar(
          //             indicatorColor: Colors.deepPurple[500],
          //             indicatorWeight: 1,
          //             labelColor: Colors.deepPurple[500],
          //             labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
          //             unselectedLabelColor: Colors.grey.shade500,
          //             tabs: [
          //               Tab(text: "Posts",),
          //               Tab(text:"Events"),
          //               Tab(text: "Categories",),
          //
          //             ],
          //           ),
          //         ),
          //         Container(
          //             height: MediaQuery.of(context).size.height*.599, //height of TabBarView
          //             decoration: BoxDecoration(
          //                 border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
          //             ),
          //             child: TabBarView(
          //                 physics:BouncingScrollPhysics(),
          //                 children: [
          //                   Post_Screen(),
          //                   CategoriesScreen(),
          //                   CategoriesScreen(),
          //                 ]
          //             )
          //         ),
          //       ],
          //     ),
          //   )
          // ]
          //     else...[
          //   DefaultTabController(
          //     length: 2,
          //     initialIndex: 0,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         Container(
          //           child: TabBar(
          //             indicatorColor: Colors.deepPurple[500],
          //             indicatorWeight: 1,
          //             labelColor: Colors.deepPurple[500],
          //             labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
          //             unselectedLabelColor: Colors.grey.shade500,
          //             tabs: [
          //               Tab(text: "Posts",),
          //               Tab(text: "Categories",),
          //
          //             ],
          //           ),
          //         ),
          //
          //         Container(
          //             height: MediaQuery.of(context).size.height*.599, //height of TabBarView
          //             decoration: BoxDecoration(
          //                 border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
          //             ),
          //             child: TabBarView(
          //                 physics:BouncingScrollPhysics(),
          //                 children: [
          //                   Post_Screen(),
          //                   CategoriesScreen(),
          //                 ]
          //             )
          //         ),
          //       ],
          //     ),
          //   )
          // ]


              DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration:BoxDecoration(
                          color:Colors.deepPurple[400]
                          // color:Colors.blue.shade50,
                          // gradient: grad
                        ),
                        child: TabBar(
                          // indicatorColor: Colors.deepPurple[500],
                          indicatorColor: Colors.white,
                          indicatorWeight: 1,
                          // labelColor: Colors.deepPurple[500],
                          labelColor: Colors.white,
                          labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'times new roman',),
                          unselectedLabelColor: Colors.grey.shade500,
                          tabs: [
                            Tab(text: "Posts".toUpperCase(),),
                            Tab(text:"Events".toUpperCase()),
                            // Tab(text:"Nearby"),
                          ],
                        ),
                      ),

                      Container(
                          height: MediaQuery.of(context).size.height*.765, //height of TabBarView
                          decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                          ),
                          child: TabBarView(
                            physics:BouncingScrollPhysics(),
                              children: [
                                Post_Screen(),
                                Event_Screen(),
                                // NearbyLocation(),
                               ]
                          )
                         ),
                    ],
                  ),
              )

        ],
      ),

    );
  }
}

