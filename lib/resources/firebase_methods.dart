import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {// POST YÜKLEME İÇİN 2.ADIM
  final fire = FirebaseFirestore.instance;

  Future<bool> uploadPost(
      String description,
      String author,
      bool isComment,
      bool isDownload,
      String music,
      String type,
      Map location,
      List<Map> users,
      List<Uint8List> bytes,
      String musicName,
      Map musicData,) async {
    try {
      List<String> contentUrl = [];
      for(var element in bytes ){
        String url = await StorageMethods().uploadImageToStorage(
            "posts", element, true);
        contentUrl.add(url);
      }
      String id = Uuid().v1();
      Post post = Post(
          description: description,
          author: author,
          contentUrl: contentUrl,
          isComment: isComment,
          isDownload: isDownload,
          music: music,
          postId: id,
          publishDate: DateTime.now(),
          type: type,
          verified: true,
          location: location,
          users: users
      );
      await fire.collection("Posts").doc(id).set(post.toJson()); // FİREBASE KAYDETMEK İÇİN Posts adinda koleksiyon yaptık,oraya git bir dosya oluştur adına  oluşturduğumuz id yi verdim ve set dedim
      return true;
    }


    catch

    (

    err) {
      return false;
    }
  }
}