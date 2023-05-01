import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_tutor_app/Widgets/DrawerWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user=FirebaseAuth.instance.currentUser;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(user!.uid).snapshots(),
        builder:(BuildContext context , AsyncSnapshot snapshot){
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          }
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white10,
              leading: InkWell(
                onTap: (){
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.white10,
                  backgroundImage: AssetImage('assets/images/profilepic.jpg'),
                ),
              ),
              actions: [
                IconButton(onPressed: (){},
                    icon: Icon(Icons.more_vert,color: Colors.black54,))
              ],
            ),
            drawer: DrawerWidget(),
          );

        }
    );
  }
}
