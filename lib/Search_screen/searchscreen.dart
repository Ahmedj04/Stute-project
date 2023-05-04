import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Postdetails_screen.dart';

class Search_Screen extends SearchDelegate{

  TextStyle style=TextStyle(color: Colors.black , );
  TextStyle styledes=TextStyle(color: Colors.grey, fontWeight: FontWeight.w300 );

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
   return [
     IconButton(
         onPressed: (){
           query ="";
         },
         icon: Icon(Icons.close , size: 19, color: Colors.black,))
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back ,color: Colors.black, size: 19,)
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Posts').snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong', style: style,);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.data!.docs.where(
                  (QueryDocumentSnapshot<Object?> element) => element['Title']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase())).isEmpty){
            return Center(child: Text("Result not found!" ,style: style),);
          }
          else{
            return ListView(
                children: [
                  ...snapshot.data!.docs.where(
                          (QueryDocumentSnapshot<Object?> element) => element['Title']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?> data){

                    final String title=data.get('Title');
                    final String description=data['Description'];
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsScreen(id: data['id'])),
                          );

                        },
                        contentPadding: EdgeInsets.all(10),
                        title: Text(title,style: style,),
                        subtitle: Text(description ,style: styledes,),
                      ),
                    );
                  })
                ],
              );

          }

        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(child: Text("Search Through Title" ,style: style,),);
  }

  @override
  ThemeData appBarTheme(BuildContext context){
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.grey[50],
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
      ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),

    );
  }
  
}
