import 'package:flutter/material.dart';
import 'package:social_media/utils/colors.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/images/social_yazı.png',
        width: 250,
        height: 250,),
        actions: [
          Icon(Icons.favorite_border_outlined),
      Image.asset('assets/images/dm.png',
      width: 40,)
        ],

      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text("ANA SAYFA")
            
          ],
        ),
      )),
    );
  }
}
