import 'package:blog_application/network_handler.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool vis = true;
  final _gloabalkey = GlobalKey<FormState>();
  TextEditingController signupcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  String? errorText;
  bool validate = false;
  bool circular = false;
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
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Form(
            key: _gloabalkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up with email",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                usernametextField(usernamecontroller, "username"),
                const SizedBox(
                  height: 10,
                ),
                emailtextField(signupcontroller, "email"),
                const SizedBox(
                  height: 10,
                ),
                passwordTextField(passwordcontroller, "password"),
                const SizedBox(
                  height: 10,
                ),
                circular ? const CircularProgressIndicator() : button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkUser() async {
    if (usernamecontroller.text.isEmpty) {
      setState(() {
        validate = false;
        errorText = "UserName can't be empty";
      });
    } else {
      var response = await NetworkHandler.get(
          "/user/checkuserName/${usernamecontroller.text}");
      if (response["msg"]) {
        setState(() {
          circular = false;
          validate = false;
          errorText = "username already taken";
        });
      } else {
        setState(() {
          validate = true;
        });
      }
    }
  }

  Widget usernametextField(controller, String text) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        errorText: validate? null: errorText,
          labelText: text,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)))),
    );
  }

  Widget emailtextField(controller, String text) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "email can't be empty";
        }
        if (value.contains("0")) {
          return "email is invalid";
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)))),
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

  Widget button() {
    return SizedBox(
      height: 60,
      width: 150,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            circular = true;
          });
          await checkUser();
          if (_gloabalkey.currentState!.validate() && validate ) {
            Map<String, String> data = {
              "userName": usernamecontroller.text,
              "email": signupcontroller.text,
              "password": passwordcontroller.text
            };
            print(data);
            await NetworkHandler.post("/user/register", data);
            setState(() {
              circular=false;
            });

            // print("validated");
          } else {
            setState(() {
              circular = false;
            });
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
          "Sign up",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
