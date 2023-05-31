import 'package:blog_application/sign_in_page.dart';
import 'package:blog_application/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(
          key: key,
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<Offset> animation1;
  late AnimationController _controller2;
  late Animation<Offset> animation2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
        duration: const Duration(microseconds: 8000), vsync: this);
    animation1 = Tween<Offset>(
            begin: const Offset(0.0, 8.0), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller1, curve: Curves.easeIn));
        _controller1.forward();
    _controller2 = AnimationController(
        duration: const Duration(microseconds: 8000), vsync: this);
    animation2 = Tween<Offset>(
            begin: const Offset(0.0, 8.0), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller2, curve: Curves.elasticInOut));
        _controller2.forward();
  }


  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

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
            SlideTransition(
              position: animation1,
              child: const Text(
                "DevStack",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 180,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return SignUpPage();
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return const SignInPage(
                        );
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
    return SlideTransition(
      position: animation2,
      child: SizedBox(
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
