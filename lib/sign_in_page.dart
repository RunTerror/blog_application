import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blog_application/main.dart';
import 'package:blog_application/network_handler.dart';
import 'package:flutter/material.dart';

import 'first_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final storage = const FlutterSecureStorage();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool vis = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.green,
              ],
              begin: FractionalOffset(0, 1),
              end: FractionalOffset(0, 1),
              stops: [0, 1],
              tileMode: TileMode.repeated),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            const Text(
              "Sign In with Email",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            usernametextField(usernameController, "username"),
            const SizedBox(
              height: 20,
            ),
            passwordTextField(passwordController, "password"),
            const SizedBox(
              height: 20,
            ),
            button(),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              endIndent: 30,
              indent: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {}, child: const Text("Forgot Password?")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }));
                    },
                    child: const Text("New User?")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget usernametextField(controller, String text) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "username can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)))),
    );
  }

  Widget button() {
    return SizedBox(
      height: 60,
      width: 150,
      child: ElevatedButton(
        onPressed: () async {
          Map<String, String> data = {
            "userName": usernameController.text,
            "password": passwordController.text
          };
          var response = await NetworkHandler.post("/user/login", data);
          if (response.statusCode == 200 || response.statusCode == 201) {
            if (context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const FirstPage();
              }));
            }
            var res = jsonDecode(response.body);
            print(res["token"]);
            await storage.write(key: "token", value: res["token"]);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 92, 148, 93),
          side: const BorderSide(width: 3, color: Colors.transparent),
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(40)),
        ),
        child: const Text(
          "Sign in",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget passwordTextField(controller, String text) {
    return TextFormField(
      validator: (value) {
        if (value == null) {
          return "password can't be empty";
        } else {
          if (value.length < 8) {
            return "password length should be more than 7";
          }
        }
        return null;
      },
      obscureText: vis,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: vis == true
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              vis = !vis;
            });
          },
        ),
        labelText: text,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              100,
            ),
          ),
        ),
      ),
    );
  }
}
