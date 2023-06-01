import 'package:blog_application/first_page.dart';
import 'package:blog_application/sign_in_page.dart';
import 'package:blog_application/signup_page.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.green,
                ],
                begin: FractionalOffset(0, 1),
                end: FractionalOffset(0, 1),
                stops: [0, 1],
                tileMode: TileMode.repeated)),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
                "DevStack",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 180,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const SignUpPage();
                  }));
                },
                child:
                    boxContainer("images/google.jpg", "Sign up with google")),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {},
                child: boxContainer(
                    "images/facebook.jpg", "Sign up with facebook")),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {},
                child: boxContainer("images/image.jpg", "Sign up with gmail")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SignInPage();
                      }));
                    },
                    child: const Text(
                      "Sign In",
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget boxContainer(String path, String text) {
    return  SizedBox(
        height: MediaQuery.of(context).size.height / 10,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                path,
                width: 50,
                height: 50,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                width: 8,
              )
            ],
          ),
      ),
    );
  }
}
