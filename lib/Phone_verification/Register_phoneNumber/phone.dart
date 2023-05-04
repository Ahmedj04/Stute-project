import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify="";
  static String phoneno="";
  static TextEditingController countryCode = TextEditingController();

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {

  @override

  void initState() {
    // TODO: implement initState
    MyPhone.countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image(image: NetworkImage("https://thumbs.dreamstime.com/b/otp-code-one-time-unlock-password-illustration-otp-code-one-time-unlock-password-illustration-261562501.jpg")),

              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: MyPhone.countryCode,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          onChanged: (value){
                            MyPhone.phoneno=value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ),),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),

                    onPressed: () async{
                      print(MyPhone.phoneno);
                        if(MyPhone.phoneno.isNotEmpty){

                          EasyLoading.show(status: "loading");
                          try{
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '${MyPhone.countryCode.text +  MyPhone.phoneno}',
                              verificationCompleted: (PhoneAuthCredential credential) {

                              },
                              verificationFailed: (FirebaseAuthException e) {
                                EasyLoading.showError(e.toString());
                                // EasyLoading.showError('Verification failed!\n The provided Phone number is Invalid');
                              },
                              codeSent: (String verificationId, int? resendToken) {
                                EasyLoading.showSuccess("OTP successfully sent to your mobile number");
                                MyPhone.verify=verificationId;
                                Navigator.pushNamed(context, 'verify');
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );
                          }catch(e){
                            EasyLoading.showError(e.toString());
                          }

                        }
                        else{
                          EasyLoading.showError('Number invalid');
                        }


                    },
                    child: Text("Send the code")),
              )
            ],
          ),
        ),
      ),
    );
  }
}