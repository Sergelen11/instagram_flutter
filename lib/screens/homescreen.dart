import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/models/postmodel.dart';
import 'package:instagram/services/remoteservices.dart';
import 'package:instagram/utils/post.dart';
import 'package:instagram/utils/sp_manager.dart';
import 'package:instagram/utils/story.dart';
import 'package:instagram/utils/yourstory.dart';

// ignore: camel_case_types
class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  // final String? token;
  @override
  State<homeScreen> createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<homeScreen>
    with AutomaticKeepAliveClientMixin<homeScreen> {
  final List people = ['name1', 'name1', 'name1', 'name1', 'name1'];
  String? token;
  List<PostModel>? posts;

  var isLoaded = false;

  @override
  void initState() {
    test();
    super.initState();
  }

  logout() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.deleteAccessToken();
  }

  test() async {
    SpManager sharedPreference = SpManager();
    await sharedPreference.init();
    token = await sharedPreference.getAccessToken();
    posts = await RemoteServices().getPosts(token: token!);
    if (posts != null) {
      print(posts);
      setState(() {
        isLoaded = true;
      });
    }
    // Get.offAllNamed(addpostRoute);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: Colors.black,
                height: 36,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: test,
                      child: const Icon(
                        Icons.add_box_rounded,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: GestureDetector(
                      onTap: logout,
                      child: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
                height: 105,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return YourStoryComponent();
                      }
                      return GestureDetector(
                          onTap: () {
                            print(posts!.length);
                          },
                          child: StoryComponent(name: people[index]));
                    })),
            // Container(
            //     height: 105,
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: people.length,
            //         itemBuilder: (context, index) {
            //           return GestureDetector(
            //               onTap: () {
            //                 print(posts!.length);
            //               },
            //               child: StoryComponent(name: people[index]));
            //         })),
            Expanded(
              child: Visibility(
                visible: isLoaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    itemCount: posts?.length,
                    itemBuilder: (context, index) {
                      return PostComponent(post: posts![index]);
                    }),
              ),
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
