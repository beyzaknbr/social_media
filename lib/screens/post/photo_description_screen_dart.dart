import 'package:flutter/material.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:social_media/screens/post/photo_click_screen.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/utils.dart';
import 'dart:typed_data';


class PhotoDescriptionScreen extends StatefulWidget {
  final Stream<InstaAssetsExportDetails> photoStream;

  const PhotoDescriptionScreen({super.key, required this.photoStream});

  @override
  State<PhotoDescriptionScreen> createState() => _PhotoDescriptionScreenState();
}

class _PhotoDescriptionScreenState extends State<PhotoDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni gönderi"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: textColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: widget.photoStream,
                builder: (context, snapshot) {
                  // veri akısı ve kullanıcı arayüzüköprü güncelemeler kolay yapılır
                  var img = snapshot.data!.croppedFiles.first.readAsBytesSync();
                  return SizedBox(
                      height: 300,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PhotoClick(bytes: img) ));
                        },
                        child: Image.memory(
                          img,
                          fit: BoxFit.contain,
                        ),
                      ));
                }),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                minLines: 1,
                maxLength: 400,
                keyboardType: TextInputType.multiline, // asagi inmesi icin yapamadim
                style: TextStyle(fontFamily: ""
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                    hintText: "   Bir açıklama ekle..."

                ),

              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text("Konum ekle"),
            ),
            ListTile(
              leading: Icon(Icons.music_note_outlined),
              title: Text("Müzik ekle"),
            ),
            ListTile(
              leading: Icon(Icons.people_alt_outlined),
              title: Text("Kişileri etiketle"),
            ),

          ],
        ),
      ),
      bottomSheet:Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ButtonStyle(

backgroundColor:  MaterialStateProperty.all(textColor),
          ),
          onPressed: (){

          },
          child: Text("Gönderiyi Paylaş"),
        )
      ,
      ) ,
    );
  }
}
