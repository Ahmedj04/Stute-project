import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'login_verify.dart';

class Login_with_MyPhone extends StatefulWidget {
  const Login_with_MyPhone({Key? key}) : super(key: key);

  static String verify="";
  static String phoneno="";
  static TextEditingController countryCode = TextEditingController();

  @override
  State<Login_with_MyPhone> createState() => _Login_with_MyPhoneState();
}

class _Login_with_MyPhoneState extends State<Login_with_MyPhone> {

  @override

  void initState() {
    // TODO: implement initState
    Login_with_MyPhone.countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
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
                "Login Using phone",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We will send you the OTP to verify the number",
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
                        controller: Login_with_MyPhone.countryCode,
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
                            Login_with_MyPhone.phoneno=value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
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
                      print(Login_with_MyPhone.phoneno);
                      if(Login_with_MyPhone.phoneno.isNotEmpty){

                        EasyLoading.show(status: "loading");
                        try{
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '${Login_with_MyPhone.countryCode.text +  Login_with_MyPhone.phoneno}',
                            verificationCompleted: (PhoneAuthCredential credential) {

                            },
                            verificationFailed: (FirebaseAuthException e) {
                              EasyLoading.showError(e.toString());
                            },
                            codeSent: (String verificationId, int? resendToken) {
                              EasyLoading.showSuccess("OTP successfully sent to your mobile number");
                              Login_with_MyPhone.verify=verificationId;
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login_with_MyVerify()));

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