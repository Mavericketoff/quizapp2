import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizapp2/firebase_options.dart';
import 'package:quizapp2/helper/authenticate.dart';
import 'package:quizapp2/helper/constants.dart';
import 'package:quizapp2/views/home.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  //InitialBinding().dependencies();
  runApp(MyApp());
  //await initFireBase();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await Constants.getUerLoggedInSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn = value as bool;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isUserLoggedIn ? Home() : Authenticate(),
    );
  }
}

Future<void> initFireBase() async {
  await Firebase.initializeApp(
    name: 'quizzle-demo',
    options: DefaultFirebaseOptions.currentPlatform,
  );
}