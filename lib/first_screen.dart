import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:ui';
import 'LoginScreen.dart';
import 'SignUpScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple[400],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              // height: 160,
              height:  MediaQuery.of(context).size.height*.21,
              color: Colors.deepPurple[400],
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("STUTE",style: TextStyle(fontFamily: 'times new roman',
                            fontSize: 35 , fontWeight: FontWeight.w500,color: Colors.white),),
                      ],
                    ),
                    SizedBox(height: 25,),

                    Row(
                      children: [
                        Text("Learn and interact with tutor online worldwide!",
                          style: TextStyle(fontSize: 13 , color: Colors.white70),),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Text("Get connected to the world!",style: TextStyle(fontSize: 13 , color: Colors.white70),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          CarouselSlider(
            options:CarouselOptions(
              // height: 300,
              height: MediaQuery.of(context).size.height*.4,
              viewportFraction: 1,
              autoPlay: true,
            ) ,
            items: [
              Image(
                height: 300,
                image: AssetImage("assets/images/pic2.png"),
              ),
              Image(
                height: 300,
                image: AssetImage("assets/images/pic1.jpg"),
              ),
              Image(
                height: 300,
                image: AssetImage("assets/images/pic3.png"),
              ),
              Image(
                height: 300,
                image: AssetImage("assets/images/pic4.jpg"),
              ),
            ],

          ),

          Padding(
            // padding: const EdgeInsets.only(top:8.0, bottom: 8,left: 15,right: 15),
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*.010, bottom: MediaQuery.of(context).size.height*.010,left: MediaQuery.of(context).size.height*.02,right: MediaQuery.of(context).size.height*.02),
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                side: MaterialStateProperty.all(
                   BorderSide(
                    color: Color(0xa64700c6),
                    width: 0,
                  ),
                ),
                fixedSize: MaterialStateProperty.all(const Size(300, 60)),
              ),
              child: Text('Login',style: TextStyle(color: Colors.deepPurple[400] , fontSize: 16),),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*.002, bottom: MediaQuery.of(context).size.height*.010,left: MediaQuery.of(context).size.height*.02,right: MediaQuery.of(context).size.height*.02),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child:SignUpScreen()));
            },
              style: ButtonStyle(
                // overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple[400]),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                // side: MaterialStateProperty.all(
                //   const BorderSide(
                //     color: Colors.blue,
                //     width: 0,
                //   ),
                // ),
                fixedSize: MaterialStateProperty.all(const Size(300, 60)),
              ),
              child: Text('SignUp',style: TextStyle(color: Colors.white , fontSize: 16),),
            ),
          ),

        ],
      ),
    );
  }
}
