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
  TextEditingController proffesion = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController dob = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            imageProfile(),
            const SizedBox(
              height: 10,
            ),
            nametextField(),
            proffesiontextField(),
            dobtextField(),
            titletextField(),
            abouttextField(),
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width/2,
                decoration:const BoxDecoration(
                  color: Colors.teal
                ),
              ),
            )
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

  Future<void> takePhoto(ImageSource imageSource) async {
    var pickedFile = await picker.pickImage(source: imageSource);
    File file = File(pickedFile!.path);
    setState(() {
      imageFile = file;
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
            backgroundImage: imageFile == null
                ? const AssetImage("images/facebook.jpg") as ImageProvider
                : FileImage(imageFile!),
          ),
        ),
      ],
    );
  }

  Widget nametextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null) {
            return "Name can't be empty";
          }
          return null;
        },
        maxLines: 1,
        controller: name,
        decoration: const InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.person),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.2),
            ),
            helperText: "",
            hintText: "Name"),
      ),
    );
  }

  Widget dobtextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null) {
            return "dob can't be null";
          }
          return null;
        },
        maxLines: 1,
        controller: dob,
        decoration: const InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.calendar_month),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.2),
            ),
            helperText: "",
            hintText: "DOB"),
      ),
    );
  }

  Widget titletextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null) {
            return "title can't be null";
          }
          return null;
        },
        maxLines: 1,
        controller: title,
        decoration: const InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.cast_for_education),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.2),
            ),
            helperText: "",
            hintText: "Full Stack Developer"),
      ),
    );
  }

  Widget abouttextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null) {
            return "about can't be null";
          }
          return null;
        },
        maxLines: 3,
        controller: about,
        decoration: const InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.info),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.2),
            ),
            helperText: "",
            hintText: "about"),
      ),
    );
  }

  Widget proffesiontextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null) {
            return "about can't be null";
          }
          return null;
        },
        maxLines: 1,
        controller: proffesion,
        decoration: const InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            prefixIcon: Icon(Icons.work),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.2),
            ),
            helperText: "",
            hintText: "proffesion"),
      ),
    );
  }
}
