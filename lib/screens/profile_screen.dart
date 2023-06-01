import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  TextEditingController userName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController dob = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            imageProfile(),
            const SizedBox(height: 10,),
            textField(userName, "UserName", const Icon(Icons.person),
                "UserName", "UserName can't be empty", 1),
            textField(name, "name", const Icon(Icons.person), "Name",
                "Name can't be empty", 1),
            textField(dob, "dob", const Icon(Icons.date_range), "Date of birth",
                "dob can't be empty", 1),
            textField(title, "title", const Icon(Icons.title), "title",
                "title can't be empty", 1),
            textField(about, "about", const Icon(Icons.description), "about",
                "about can't be empty", 4)
          ],
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Select Profile Picture",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    takePhoto(ImageSource.camera);
                  },
                  child: const Icon(
                    Icons.camera,
                    size: 40,
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "camera",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                width: 100,
              ),
              InkWell(
                  onTap: () {
                    takePhoto(ImageSource.gallery);
                  },
                  child: const Icon(
                    Icons.image,
                    size: 40,
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "gallery",
                style: TextStyle(fontSize: 15),
              )
            ],
          )
        ],
      ),
    );
  }

 Future<void>  takePhoto(ImageSource imageSource) async {
    var pickedFile =
        await picker.pickImage(source: imageSource);
    File file=File(pickedFile!.path);
    setState(() {
      imageFile=file;
    });
  }

  Widget imageProfile() {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return bottomsheet();
                      });
                });
          },
          child: CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 80,
            backgroundImage: imageFile==null?const AssetImage("images/facebook.jpg") as ImageProvider: FileImage(imageFile!),
          ),
        ),
      ],
    );
  }

  Widget textField(var controller, String text, var icon, var hinttext,
      var helpertext, int line) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        maxLines: line,
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: icon,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.2),
            ),
            helperText: "",
            hintText: hinttext),
      ),
    );
  }
}
