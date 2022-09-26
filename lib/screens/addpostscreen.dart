// ignore_for_file: unnecessary_const

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/routes.dart';
import 'package:instagram/utils/sp_manager.dart';

// ignore: camel_case_types
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

// ignore: camel_case_types
class _AddPostScreenState extends State<AddPostScreen> {
  File? _file;
  late String? token;
  @override
  void initState() {
    getAccessToken();
    super.initState();
    // print(token);
  }

  getAccessToken() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.getAccessToken();
  }

  TextEditingController decsController = TextEditingController();
  Future pickImage(ImageSource gallery) async {
    try {
      final image = await ImagePicker().pickImage(source: gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        _file = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  printFileName(file) {
    print(file);
  }

  selectedImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  print(token!);
                  // pickImage(ImageSource.camera);
                  // Navigator.of(context).pop();
                  // Uint8List file = await pickImage(ImageSource.camera);
                  // setState(() {
                  //   _file = file;
                  // });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Pick from gallery'),
                onPressed: () async {
                  pickImage(ImageSource.gallery);

                  // Navigator.of(context).pop();
                  // Uint8List file = await pickImage(ImageSource.gallery);
                  // setState(() {
                  //   _file = file;
                  // });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
            onPressed: () => {
              selectedImage(context),
              // printFileName(_file)
            },
            icon: const Icon(Icons.upload),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              title: const Text(
                'Post to',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () async {
                      final response = await RemoteServices().NewPost(
                          token: token!,
                          description: decsController.text,
                          file: _file!);
                      if (response.statusCode == 200) {
                        Get.offAllNamed(mainRoute);
                      }
                      // printFileName(_file);
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ))
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60 / 2),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 58,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          controller: decsController,
                          decoration: const InputDecoration(
                            hintText: 'Add a caption....',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   width: 45,
                      //   height: 58,
                      //   child: Image.network(
                      //     'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmFja2dyb3VuZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter,
                                  image: FileImage(_file!)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
