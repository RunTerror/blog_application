import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final ImagePicker picker = ImagePicker();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  final _gloabalkey = GlobalKey<FormState>();
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "preview",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _gloabalkey,
          child: Column(
            children: [
              titletextField(),
              const SizedBox(
                height: 10,
              ),
              bodytextField(),
              InkWell(
                onTap: () {
                  if (_gloabalkey.currentState!.validate()) {
                    print("validated");
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: const Center(child: Text("Post")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> takePhoto(ImageSource imageSource) async {
    var pickedImage = await picker.pickImage(source: imageSource);
    File file = File(pickedImage!.path);
    setState(() {
      imageFile = file;
    });
  }

  Widget titletextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "title can't be empty";
        } else if (value.length > 100) {
          return "title length should be less than 100";
        }
        return null;
      },
      maxLength: 100,
      maxLines: 1,
      controller: title,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal)),
          prefixIcon: IconButton(
            onPressed: () {
              // takePhoto(ImageSource.camera);

              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return bottomSheet();
                      },
                    );
                  });
            },
            icon: imageFile == null
                ? const Icon(Icons.image)
                : const Icon(
                    Icons.check_box,
                    color: Colors.teal,
                  ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 1.2),
          ),
          helperText: "",
          hintText: "Add Image and Title",
          labelText: "Add Image and Title"),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Select Profile Picture",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.camera,
                    size: 40,
                  )),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.photo,
                    size: 40,
                  ))
            ],
          )
        ],
      ),
    );
    // return showBottomSheet(context: context, builder: builder)
  }

  Widget bodytextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "body can't be empty";
        }
        return null;
      },
      controller: body,
      decoration: const InputDecoration(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 1.2),
          ),
          helperText: "",
          hintText: "provide body to your blog",
          labelText: "body"),
    );
  }
}
