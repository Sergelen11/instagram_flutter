import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/models/userpostmodel.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/routes.dart';
import 'package:instagram/utils/sp_manager.dart';

class AccountTab1 extends StatefulWidget {
  const AccountTab1({Key? key}) : super(key: key);

  @override
  State<AccountTab1> createState() => _AccountTab1State();
}

class _AccountTab1State extends State<AccountTab1> {
  List<UserPostModel>? userposts;

  bool isLoaded = false;
  String? token;
  @override
  void initState() {
    // getAccessTokenAndData();
    super.initState();
  }

  getAccessTokenAndData() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.getAccessToken();
    userposts = await RemoteServices().getUserPosts(token: token);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return isLoaded
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : userposts != null
    //         ? GridView.builder(
    //             itemCount: userposts.length,
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 3),
    //             itemBuilder: (context, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.all(2.0),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     Get.toNamed(viewpostRoute, arguments: [
    //                       {"posts": userposts, "id": userposts[index].id},
    //                     ]);
    //                   },
    //                   child: Container(
    //                     color: Colors.grey[400],
    //                     child: CachedNetworkImage(
    //                       imageUrl: userposts[index].photoUrl,
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             })
    //         : const Text('is null');
    return Visibility(
      visible: isLoaded,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: GridView.builder(
          itemCount: userposts?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(viewpostRoute, arguments: [
                    {"posts": userposts, "id": userposts?[index].id},
                  ]);
                },
                child: Container(
                  color: Colors.grey[400],
                  child: CachedNetworkImage(
                    imageUrl: userposts![index].photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
