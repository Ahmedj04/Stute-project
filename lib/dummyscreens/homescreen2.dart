import 'package:flutter/material.dart';

class Homescreen2 extends StatefulWidget {
  const Homescreen2({Key? key}) : super(key: key);

  @override
  State<Homescreen2> createState() => _Homescreen2State();
}

class _Homescreen2State extends State<Homescreen2> with SingleTickerProviderStateMixin {

  TabController? controller;

  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 90,
                pinned: true,
                automaticallyImplyLeading: false,
                // stretch: true,
                elevation: 0,
                toolbarHeight: 0,
                backgroundColor: Colors.white,
                flexibleSpace: Row(
                  children: [
                   Container(
                     child: Padding(
                       padding: EdgeInsets.only(top:(MediaQuery.of(context).size.height*.010)),
                       child: Text("STUTE ",style: TextStyle(
                         fontFamily: 'times new roman',
                         // color:Colors.black,
                         color:Colors.white,
                         fontSize: 28,
                         fontWeight: FontWeight.w400,),),
                     ),
                   )
                  ],
                ),
                bottom: TabBar(
                  controller: controller,
                  tabs: [
                    Tab(icon: Icon(Icons.view_module_outlined , size: 30,)),
                    Tab(icon: Icon(Icons.play_arrow_rounded,size: 33,)),
                    // Tab(icon: Icon(Icons.person_pin_outlined,size:28),),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: controller,
            children: [
              Container(
                child: Center(
                  child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Display Tab 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ),
            ],

        ),
    ),
      ),
    );
  }
}
