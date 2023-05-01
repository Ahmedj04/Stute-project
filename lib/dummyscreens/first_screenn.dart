import 'package:flutter/material.dart';

class DummyFirstScreen extends StatefulWidget {
  const DummyFirstScreen({Key? key}) : super(key: key);

  @override
  _DummyFirstScreenState createState() => _DummyFirstScreenState();
}

class _DummyFirstScreenState extends State<DummyFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Text("App name goes here",style: TextStyle(fontSize: 25),),
          SizedBox(height: 100,),
          Text("Tagline goes here",style: TextStyle(fontSize: 20),),
          SizedBox(height: 200,),

          ElevatedButton(onPressed: (){
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit_by_streambuilder()));
          },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
              padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // side: MaterialStateProperty.all(
              //   const BorderSide(
              //     color: Colors.blue,
              //     width: 0,
              //   ),
              // ),
              // fixedSize: MaterialStateProperty.all(const Size(330, 30)),
            ),
            child: Text('Teachers',style: TextStyle(color: Colors.black , fontSize: 16),),
          ),

          SizedBox(height: 20,),

          ElevatedButton(onPressed: (){
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit_by_streambuilder()));
          },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
              padding: MaterialStateProperty.all(const EdgeInsets.only(left:130, right:130,top:20,bottom: 20)),
              backgroundColor: MaterialStateProperty.all(Colors.green),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // side: MaterialStateProperty.all(
              //   const BorderSide(
              //     color: Colors.blue,
              //     width: 0,
              //   ),
              // ),
              // fixedSize: MaterialStateProperty.all(const Size(330, 30)),
            ),
            child: Text('Students',style: TextStyle(color: Colors.black , fontSize: 16),),
          ),

          Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 150,
                    child: Divider(height: 1,thickness: 1,)),
                Text('OR', style: TextStyle(fontWeight: FontWeight.bold),),
                Container(
                    width: 160,
                    child: Divider(height: 1,thickness: 1,)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:28.0),
            child: InkWell(
              onTap:(){},
                child: Text("Admin login?",style: TextStyle(fontSize: 13,color: Colors.blue.shade800),))

          ),

        ],
      ),
    );
  }
}
