import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import '../Postdetails_screen.dart';

class NearbyLocation extends StatefulWidget {
  const NearbyLocation({Key? key}) : super(key: key);

  @override
  State<NearbyLocation> createState() => _NearbyLocationState();
}

class _NearbyLocationState extends State<NearbyLocation> {

  Location _location = Location() ;
  User? user=FirebaseAuth.instance.currentUser;

  var userlat;
  var userlong;
  var address;

   void UpdateCurrentuserLoc() async{
    _location.getLocation().then((value) => {
      FirebaseFirestore.instance.collection('Users').doc(user!.uid).update({
        'Latitude':value.latitude!,
        'Longitude': value.longitude!,
      })

    });

  }
  void initState() {
    print ('fetching user post_details');
    UpdateCurrentuserLoc();
    getCurrentuserlocation();
    // print(userlat.toString());
    super.initState();
  }

  Future getCurrentuserlocation()async{
    await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get().then((value) => {
      setState((){
        userlat=value['Latitude'];
        userlong=value['Longitude'];
      })
    });
  }

  String formattedDate(timestamp){
    var dateFromTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }

  // Future getDetailOccupation() async{
  //   await FirebaseFirestore.instance.collection("Posts").get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection('Posts').snapshots(),
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
                      height: 300,
                      // image: AssetImage("assets/images/nopost1.jpg"),
                      image: NetworkImage('https://img.freepik.com/free-vector/business-team-looking-new-people-allegory-searching-ideas-staff-woman-with-magnifier-man-with-spyglass-flat-illustration_74855-18236.jpg?w=900&t=st=1667754109~exp=1667754709~hmac=e761f6d99a257a77d63be726224a6890d175d9a6161a68480248b16dae365184'),
                    ),
                    Text('No Nearby Posts!')
                  ],
                ),
              ),
            );

          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length -1,
              itemBuilder: (context , int index){
                var distanceInKm;
                print(userlat);
                print(userlong);
                var distance=Geolocator.distanceBetween(userlat, userlong, snapshot.data!.docs[index]['Latitude'], snapshot.data!.docs[index]['Longitude']);
                distanceInKm =distance/1000;
                print(distanceInKm);
                if(distanceInKm>20){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: PostDetailsScreen(id: (snapshot.data!.docs[index]['id']) ,)));
                    },
                    child: Card(
                      color:Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                      child: Container(
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

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data!.docs[index]['Title'],style: TextStyle(
                                    color:Colors.grey,
                                    fontFamily: 'times new roman',
                                    fontSize: 17 ,
                                    fontWeight: FontWeight.w100
                                ),),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if(snapshot.data!.docs[index]['Price']!="")...[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Price\n"+snapshot.data!.docs[index]['Price'],style: TextStyle(color: Colors.deepPurple[500],fontSize: 13 , fontWeight: FontWeight.w400),),
                                    ),
                                  ],
                                  if(snapshot.data!.docs[index]['Experience']!="")...[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Experience\n"+snapshot.data!.docs[index]['Experience'],style: TextStyle(color:Colors.deepPurple[500],fontSize: 13 , fontWeight: FontWeight.w400),),
                                    ),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  if(snapshot.data!.docs[index]['Teaching Mode']!="")...[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Teaching Mode\n"+snapshot.data!.docs[index]['Teaching Mode'],style: TextStyle(color: Colors.deepPurple[500],fontSize: 13 , fontWeight: FontWeight.w400),),
                                    ),
                                  ],
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data!.docs[index]['Description'],style: TextStyle(
                                    color:Colors.grey,
                                    fontSize: 13 , fontWeight: FontWeight.w300),
                                  maxLines: 2,
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text("Tap for details...",style: TextStyle(
                                        color:Colors.grey,
                                        fontSize: 10 , fontWeight: FontWeight.w300),)),
                                  ),
                                  // Text(data['DateTime'].toString(),style: TextStyle(fontSize: 10),)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0, left: 50),
                                    child: Text(formattedDate(snapshot.data!.docs[index]['DateTime']),style: TextStyle(fontSize: 8 , color:Colors.grey,),),
                                  )
                                ],
                              )



                            ],
                          )
                      ),
                    ),
                  );
                }else{
                  return Text('Hello world');

                }
              }
          );

        });
  }
}
