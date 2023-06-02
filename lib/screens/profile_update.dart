import 'package:blog_application/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
         const Text("Complete your profile for better experience"),
          SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const ProfileScreen();
              }));
            }, child:const Text("complete")),
          )
        ],),
      ),
    );
  }
}