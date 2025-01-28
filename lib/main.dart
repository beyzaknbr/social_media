import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media/layouts/mobile_layout.dart';
import 'package:social_media/screens/auth/login_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
    Permission.manageExternalStorage,
    Permission.photos,
    Permission.storage,
  ].request();
  print(statuses[Permission.location]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: StreamBuilder( // giriş yaptıysak her seferinde her seferinde giriş ekranı istemesin
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return MobileLayout();
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Center(child: Icon(Icons.error,color: errorColor,),);
          }
          return LoginPage();
        },
      ),
    );
  }
}
