import 'package:flutter/material.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:social_media/utils/colors.dart';

class PostShare extends StatefulWidget {
  const PostShare({super.key});

  @override
  State<PostShare> createState() => _PostShareState();
}

class _PostShareState extends State<PostShare> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 70,
            height: 10,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: textColor, borderRadius: BorderRadius.circular(30)),
          ),
        ),
        ListTile(
          onTap: () {
            // set picker theme based on app theme primary color
            final theme = InstaAssetPicker.themeData(Theme.of(context).primaryColor);
            InstaAssetPicker.pickAssets(
              context,
              pickerTheme: theme.copyWith(
                  canvasColor: Colors.black, // body background color
                  splashColor: Colors.grey, // ontap splash color
                  colorScheme: theme.colorScheme.copyWith(
                    background: Colors.black87, // albums list background color
                  ),
                  appBarTheme: theme.appBarTheme.copyWith(
                    backgroundColor: Colors.black, // app bar background color
                    titleTextStyle: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle
                        ?.copyWith(color: Colors.white), // change app bar title text style to be like app theme
                  ),
                  // edit `confirm` button style
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      disabledForegroundColor: Colors.red,
                    ),
                  ),
                ),

              onCompleted: (_) {
                print(_);
              },
            );



          },
          title: Text("Gönderi Paylaş"),
          leading: Icon(
            Icons.photo_camera,
          ),
        ),
        ListTile(
          onTap: () {},
          title: Text("Reels Paylaş"),
          leading: Icon(Icons.movie_filter),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
