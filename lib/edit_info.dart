import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'Phone_verification/update_phoneNumber/updatephone.dart';

class Edit_info_screen extends StatefulWidget {
  const Edit_info_screen({Key? key}) : super(key: key);

  @override
  _Edit_info_screenState createState() => _Edit_info_screenState();
}

class _Edit_info_screenState extends State<Edit_info_screen> {
  User? user = FirebaseAuth.instance.currentUser;
  final namecontroller = TextEditingController();
  final phonenumbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Edit Details',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontFamily: 'times new roman',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            //  letterSpacing: 2,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 29,
            )),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          }
          namecontroller.text = snapshot.data['Name'];
          phonenumbercontroller.text = snapshot.data['Phone Number'];
          return Form(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .065,
                        child: TextFormField(
                          enabled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill Name field';
                            } else if (value.length < 2) {
                              return "Username should atleast be of 2 characters";
                            }
                            setState(() {
                              namecontroller.text = value;
                            });
                            return null;
                          },
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(fontSize: 13.5),
                          decoration: const InputDecoration(
                            label: Text('Name',
                                style: TextStyle(color: Colors.grey)),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UpdateMyPhone(),
                            ),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .065,
                          child: TextFormField(
                            enabled: false,
                            controller: phonenumbercontroller,
                            // keyboardType: TextInputType.multiline,
                            // maxLines: null,
                            style: const TextStyle(fontSize: 13.5),
                            decoration: const InputDecoration(
                              label: const Text('Contact No.'),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          EasyLoading.show(status: 'Updating');
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user!.uid)
                              .update({
                                'Name': namecontroller.text,
                                'Phone Number': phonenumbercontroller.text,
                              })
                              .then((value) => {
                                    print('updated'),
                                    EasyLoading.showSuccess('Details updated')
                                        .whenComplete(
                                            () => {Navigator.pop(context)}),
                                  });

                        },
                        style: ButtonStyle(
                          // overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
                          // padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(300, 60),
                          ),
                        ),
                        child: Text(
                          'Save Details',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
