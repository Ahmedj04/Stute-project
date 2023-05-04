import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'GoogleMaps/locateUserLocation_googlemap.dart';

class PostDetailsScreen extends StatefulWidget {
  String id;

  PostDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  var name;
  var title;
  var description;
  var number;
  var datetime;
  var latitude;
  var longitude;
  User? user = FirebaseAuth.instance.currentUser;

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+$number',
      text: "Hey! I'm using STUTE APP .It's a Great APP. Do try it.",
    );
    await launch('$link');
  }

  @override
  String formattedDate(timestamp) {
    var dateFromTimestamp =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimestamp);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 19,
          ),
        ),
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontFamily: 'times new roman',
            fontSize: 20,
            fontWeight: FontWeight.w200,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Posts')
              .doc(widget.id)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            name = snapshot.data['Name'];
            title = snapshot.data['Title'];
            description = snapshot.data['Description'];
            number = snapshot.data['Phone Number'];
            latitude = snapshot.data['Latitude'];
            longitude = snapshot.data['Longitude'];
            datetime = snapshot.data['DateTime'];

            sendsms() {
              String sms1 = "sms: $number";
              launch(sms1);
            }

            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$name",
                        style: GoogleFonts.poppins(
                            color: Colors.deepPurple[500],
                            fontSize:
                                MediaQuery.of(context).size.height * 0.019,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        formattedDate(datetime),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$title",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 20.0, right: 8, bottom: 20),
                  child: Text("$description",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w300)),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (snapshot.data['Price'] != "") ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 20, right: 8, bottom: 10),
                        child: Text(
                          "Price\n" + snapshot.data['Price'],
                          style: TextStyle(
                              color: Colors.deepPurple[500],
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                    if (snapshot.data['Experience'] != "") ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 40, right: 15),
                        child: Text(
                          "Experience\n" + snapshot.data['Experience'],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (snapshot.data['Teaching Mode'] != "") ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 20, right: 8, bottom: 10),
                        child: Text(
                          "Teaching Mode\n" + snapshot.data['Teaching Mode'],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (snapshot.data['Address'] != "") ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 20, right: 8, bottom: 25),
                        child: Text(
                          "Address:\n" + snapshot.data['Address'],
                          style: TextStyle(
                              color: Colors.deepPurple[500],
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                    if (snapshot.data['Latitude'] != "" &&
                        snapshot.data['Longitude'] != "") ...[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 0, right: 8, bottom: 0),
                          child: TextButton(
                              onPressed: () {
                                print(snapshot.data['Latitude']);
                                print(widget.id +
                                    " mae jarha hu google screeen pe");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        LocateUserLocation_Google_maps_Screen(
                                          coordinatesid: widget.id,
                                        )));
                              },
                              child: Text(
                                "Tap to open Maps\n",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ))),
                    ],
                  ],
                ),
                if (snapshot.data['Address'] != "" ||
                    snapshot.data['Price'] != "" ||
                    snapshot.data['Experience'] != "" ||
                    snapshot.data['Teaching Mode'] != "") ...[
                  Divider(),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Center(
                      child: Text(
                    'Contact us',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: GFButton(
                        onPressed: () {
                          sendsms();
                        },
                        text: "Message",
                        textStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        color: Colors.black,
                        icon: Icon(Icons.send, color: Colors.white),
                        shape: GFButtonShape.pills,
                        elevation: 6,
                        size: GFSize.LARGE,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: GFButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('Call? '),
                                    content: Text(
                                        'Are you sure you want to make CALL?'),
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
                                            FlutterPhoneDirectCaller.callNumber(
                                                    '$number')
                                                .whenComplete(() =>
                                                    Navigator.of(context)
                                                        .pop(false));
                                          },
                                          child: Text('Yes')),
                                    ],
                                  ));
                        },
                        text: "Call",
                        textStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        color: Colors.blue,
                        icon: Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        shape: GFButtonShape.pills,
                        elevation: 6,
                        size: GFSize.LARGE,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      // width: 10,
                      child: GFButton(
                        onPressed: () {
                          launchWhatsApp();
                        },
                        text: "Whatsapp",
                        textStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                        color: Colors.green,
                        icon: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                        ),
                        shape: GFButtonShape.pills,
                        elevation: 6,
                        size: GFSize.LARGE,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }
}
