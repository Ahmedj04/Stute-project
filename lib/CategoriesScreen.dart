import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight:MediaQuery.of(context).size.height*.60,
              ),
              width:MediaQuery.of(context).size.width*1,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 4,
                // padding: EdgeInsets.only(right:500),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    child: Card(
                        child:InkWell(
                          onTap: (){},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.dashboard),),
                              Text("Design")
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    child: Card(
                        child:InkWell(
                          onTap: (){},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.developer_mode),),
                              Text("Developer")
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    child: Card(
                        child:InkWell(
                          onTap: (){},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.business),),
                              Text("business")
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    child: Card(
                        child:InkWell(
                          onTap: (){},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.dashboard),
                              Padding(
                                padding: const EdgeInsets.only(top:18.0),
                                child: Text("Design"),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    child: Card(
                        child:InkWell(
                          onTap: (){},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.developer_mode),),
                              Text("Developer")
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    child: Card(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.business),),
                            Text("Business")
                          ],
                        )
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
