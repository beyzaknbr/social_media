import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/widgets/post_widgets/post_card.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: textFieldColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/feed_.png',
          width: 250,
          height: 250,
        ),
        actions: [
          Icon(Icons.favorite_border_outlined),
          Image.asset(
            'assets/images/dm.png',
            width: 40,
          )
        ],
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Posts").where("verified",isEqualTo: true).get(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError){
              return Center(child: Icon(Icons.error));
            }
            return SafeArea(
                child:ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                      return PostCard(snap: snapshot.data!.docs[index].data()
                      );

                }),
            );
          }
      )
    );
  }
}
