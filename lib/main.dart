import 'package:blog_application/first_page.dart';
import 'package:blog_application/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = const FlutterSecureStorage();
  Widget page = const HomePage();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    var token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = const FirstPage();
      });
    } else {
      setState(() {
        page = const HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: page);
  }
}

