import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:syncmed/screens/HomeScreen.dart';
import 'package:syncmed/screens/location.dart';
import 'package:syncmed/screens/login.dart';
import 'package:syncmed/screens/signin.dart';
import 'firebase_options.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'GEMINI_API_KEY',enableDebugging: true);


  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);


  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false
      ,
      theme:  ThemeData(
        useMaterial3: true,
      ),
      home: auth.currentUser == null ? LoginIn() : HomeScreen(),
    );
  }
}
