// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CollectionPage extends StatefulWidget {
  const CollectionPage({ Key? key }) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CollectionBody()
      
    );
  }
}

class CollectionBody extends StatefulWidget {
  @override
  State<CollectionBody> createState() => _CollectionBodyState();
}

class _CollectionBodyState extends State<CollectionBody> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff344966),
        child: StreamBuilder<QuerySnapshot>(stream: users, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading');
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index){
              return Container(
                height: MediaQuery.of(context).size.height*0.1,
           
                child: new Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("name of the meme"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(child: Text(data.docs[index]['email']),
                        //onTap: () => launch(picUrl))
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },),
      ),
    );
  }
}
