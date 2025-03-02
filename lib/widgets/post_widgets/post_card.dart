import 'dart:js_interop';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/global_class.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.snap});

  final snap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showMore = false;
  double photoCurrentIndex =0;
  List<String> likedList = [];

void getPostdata() async{



}


  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Container(

        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 568,
        decoration: BoxDecoration(
            color: textFieldColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ]

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              leading: CircleAvatar(),
              title: Text("username"),
              subtitle: Text("adres"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert_outlined),
              ),
            ),
            ExpandablePageView(
                onPageChanged:(value){
                  setState(() {
                    photoCurrentIndex = value.toDouble();
                  });
                },
              children: List.generate(widget.snap["contentUrl"].length, (index) =>  CachedNetworkImage(

              cacheManager: GlobalClass.customCacheManager,
              key: UniqueKey(),
              memCacheHeight: 800,
              //bellekte tutulacak resim boyutu
              imageUrl: widget.snap['contentUrl'][index],
              //liste olduğu için ilk ögeyi kullandım
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              errorWidget: (context, error, stackTrace) {
                return Center(
                  child: Image.asset(
                    'assets/images/error_.png',
                    fit: BoxFit.cover,
                    height: 300.h,
                  ),
                );
              },
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
            ),)),

            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart),),
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.text_bubble),),
                IconButton(onPressed: () {}, icon: Icon(Icons.send_outlined),

                ),
                Spacer(),
                SmoothIndicator(
                    offset: photoCurrentIndex, // degisim yapcaz
                    count: widget.snap["contentUrl"].length ,
                    size: Size(5,10),
                effect: ScrollingDotsEffect(
                  activeDotColor: textColor,
                  activeStrokeWidth: 0.5,
                  dotWidth: 7,
                  dotHeight: 7,
                  fixedCenter: true

                ),),
                Spacer(
                  flex: 3,
                ),
                IconButton(
                  onPressed: () {}, icon: Icon(CupertinoIcons.bookmark),),

              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    overflow: !showMore
                        ? TextOverflow.ellipsis
                        : TextOverflow.visible,
                    maxLines: !showMore ? 3 : null,
                    // showmore false sa 3 satır true ysa null
                    text:  TextSpan(
                        children: [
                          TextSpan(
                              text: "username ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                          TextSpan(
                              text: widget.snap['description'],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: textColor))

                        ]
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: Text(!showMore ? "Daha fazla" : "Daha az"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
