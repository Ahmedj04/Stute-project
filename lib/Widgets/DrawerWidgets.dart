import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_tutor_app/firebase_services.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  FirebaseServices services=FirebaseServices();
  User? user= FirebaseAuth.instance.currentUser;
  bool enabled=false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').doc(user!.uid).snapshots(),
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: const CircularProgressIndicator());
        }
        return Drawer(
          child: Material(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:18.0),
                  child: Theme(
                    data:  ThemeData().copyWith(dividerColor: Colors.transparent,),
                    child: ExpansionTile(

                      initiallyExpanded: true,
                        textColor: Colors.black,
                        iconColor: Colors.black54,
                        title:Column(
                          children:[
                            Text(snapshot.data['Name']),
                            SizedBox(height: 5,),
                            Text(snapshot.data['Occupation'],style: TextStyle(fontWeight: FontWeight.w400),),
                          ]
                        ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/profilepic.jpg'),
                        radius:20,
                      ),
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profile' , style: TextStyle( fontSize: 14 ,color: Colors.black87),),
                          hoverColor: Colors.black.withOpacity(0.3),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context)=>(orderpage())
                            //     ));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings' , style: TextStyle( fontSize: 14 ,color: Colors.black87),),
                          hoverColor: Colors.black.withOpacity(0.3),
                          onTap: (){
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context)=>(orderpage())
                            //     ));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Log Out' , style: TextStyle( fontSize: 14 ,color: Colors.black87),),
                          onTap: (){
                           services.logout(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),

          ),
        );
      }
    );
  }
}
