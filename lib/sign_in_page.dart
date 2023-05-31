import 'package:blog_application/network_handler.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
            button()
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
        onPressed: () {
          Map<String, String> data={
            "userName": usernameController.text,
            "password": passwordController.text
          };
          NetworkHandler.post("/user/login", data);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 92, 148, 93),
          side: const BorderSide(width: 3, color: Colors.transparent),
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(40)),
        ),
        child: const Text(
          "Sign up",
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
              borderRadius: BorderRadius.all(Radius.circular(100)))),
    );
  }
}
