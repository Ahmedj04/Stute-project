import 'package:flutter/material.dart';

import '../Homepage.dart';
import 'Custom_GoogleMAP.dart';

class SetLocation extends StatefulWidget {
  var currentPostid;
  SetLocation({Key? key ,required this.currentPostid}) : super(key: key);
  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute<void>(
                builder: (BuildContext context) =>  HomePage(),), (Route<dynamic> route) => false,
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body:  Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/otp.png',
              //   width: 150,
              //   height: 150,
              // ),
              Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/439/439902.png")),

              SizedBox(
                height: 25,
              ),
              Text(
                "Set Location",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Do you want to share your location!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),

                    onPressed: () {
                      // print(widget.currentPostid+" maee set location mae hun");
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomGoogleMap(currentPostid: widget.currentPostid,)));

                    },
                    child: Text("Open Map To set the current location")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
